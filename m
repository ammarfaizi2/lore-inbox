Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWE1FMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWE1FMN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 01:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWE1FMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 01:12:13 -0400
Received: from smtp.enter.net ([216.193.128.24]:1040 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965145AbWE1FML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 01:12:11 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sun, 28 May 2006 01:12:00 +0000
User-Agent: KMail/1.8.1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
In-Reply-To: <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605280112.01639.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 03:27, Jon Smirl wrote:
> On 5/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > > Fully merging fbdev with DRM would really create some problems for
> > > > the embedded people. If the design of using the fbdev driver as a
> > > > base layer and the DRM drivers as an acceleration layer works then
> > > > that's all that's truly needed. Merging the DRM and fbdev code bases
> > > > would create a situation where the embedded people would have to
> > > > configure *out* the DRM code that has been merged into the fbdev
> > > > drivers. Not only would such a thing create potential bugs in the
> > > > system, it is a step that could create problems with people
> > > > maintaining the .config's for those systems.
> > >
> > > It may cause problems for some embedded people but I wouldn't worry
> > > about them right now. If they don't like something I'm sure we'll hear
> > > from them. Most people don't go to the expense of putting a DRM
> > > capable chip into a system and then not use all of its capabilities.
> > > Remember, only 8 out of the 60 fbdev drivers have DRM modules.
> > >
> > > Worst thing that can happen is that they lose 50K of memory. Don't
> > > spend a lot of effort worrying about this especially if no one is
> > > complaining. Issues like this can be addressed later.
> >
> > Yes, however, I don't think a lot of embedded people are putting DRM
> > capable chips in their machines. And I will worry about that at all
> > points, to great length - I will actually fight to keep a complete merger
> > from happening. For exactly the reasons I stated above.
>
> For a specific DRM chip there are currently four modules:
> fbdev-core
> fbdev-chip depends on fbdev-core
> drm-core
> drm-chip depends on drm-core
> RIght now drm and fbdev can be loaded independently.
>
> I would always keep fbdev-core and drm-core as separate modules.  But
> drm-core may become dependent on fbdev-core.

yeah, that could work. Have fbdev-core handle all PCI interactions and 
drm-core uses those functions.

> So after merging, drivers without DRM would still load exactly what
> they load today. They wouldn't need to load the dependent drm-core
> module. These non-DRM modules are essentially unchanged.
> fbdev-core
> fbdev-chip depends on fbdev-core
>
> Merged DRM drivers can end up in one of two configurations
> fbdev-core
> fbdev-chip depends on fbdev-core
> drm-core depends on fbdev-core
> drm-chip depends on fbdev-chip, drm-core, fbdev-core

Not exactly. drm-chip would depend on fbdev-chip and drm-core, which both 
depend on fbdev-core -- not a direct dependency. However, the layering model 
you present would likely keep the embedded people happy. Provided the 
drm-chip and fbdev-chip interfaces are kept seperate. Such a seperation need 
only hold true for the current generation of fbdev drivers. New drivers added 
at a later date could be unified drm/fbdev-chip modules or split, as the 
creator determines.

> fbdev-core
> drm-core depends on fbdev-core
> merged-chip depends on drm-core, fbdev-core
>
> I'm saying don't worry too much if it is more efficient to create
> merged-chip for somthing like the Radeon instead of keeping fbdev-chip
> and drm-chip. It is more important to get a stable functioning driver
> working. If someone really complains the driver can be broken back up
> at a later date (they can always use the old fbdev driver in the
> meanwhile). If you spend all of your time worrying about 10K of memory
> for some embedded system that may or may not use the driver, you won't
> be spending enough time on getting the basic driver right.

Okay. That works. I wasn't going to worry about the embedded stuff, so much as 
try to keep a clean division of things so stuff the embedded people don't 
need isn't used.

> In the new model you won't be able to load standalone DRM. That's
> becuase both of those modules are now dependent on their fbdev counter
> parts.
> drm-core - standalone disallowed
> drm-chip - standalone disallowed


DRH
