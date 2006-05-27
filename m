Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965191AbWE1Cpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965191AbWE1Cpd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 22:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWE1Cpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 22:45:33 -0400
Received: from smtp.enter.net ([216.193.128.24]:19214 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S965170AbWE1Cpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 22:45:33 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Sat, 27 May 2006 22:45:21 +0000
User-Agent: KMail/1.8.1
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272213.58015.dhazelton@enter.net> <9e4733910605271934q76d41330lcf339f221612d74b@mail.gmail.com>
In-Reply-To: <9e4733910605271934q76d41330lcf339f221612d74b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605272245.22320.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 May 2006 02:34, Jon Smirl wrote:
> On 5/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> > Yes, I noticed this while studying the DRM code. Part of me doing this,
> > actually, will also be updating the DRM in kernel to the latest release.
> > (Doing such provides at least one new DRM driver that already has it's X
> > counterpart in the 6.8.2 tree)
>
> DaveA will take care of merging drivers from CVS into the kernel tree.
> Drivers that are in CVS and not in the kernel are probably there
> because their DMA engines are not secure. With Direct Rendering normal
> users can submit DMA commands to the GPUs. The kernel drivers check
> these commands and make sure that the user isn't using the DMA
> controller to play with memory that they don't own. If the DRM driver
> is missing these checks it can't go into the kernel since it isn't
> secure. I'd ignore DRM CVS and just play with the code in the kernel
> tree.

Okay. Wasn't aware of any major differences in the code - in fact, I'm using 
the CVS on my machine right now. (Not that it works - I can't get *any* 
acceleration, even using binary-only drivers from the card manufacturer)

> > Fully merging fbdev with DRM would really create some problems for the
> > embedded people. If the design of using the fbdev driver as a base layer
> > and the DRM drivers as an acceleration layer works then that's all that's
> > truly needed. Merging the DRM and fbdev code bases would create a
> > situation where the embedded people would have to configure *out* the DRM
> > code that has been merged into the fbdev drivers. Not only would such a
> > thing create potential bugs in the system, it is a step that could create
> > problems with people maintaining the .config's for those systems.
>
> It may cause problems for some embedded people but I wouldn't worry
> about them right now. If they don't like something I'm sure we'll hear
> from them. Most people don't go to the expense of putting a DRM
> capable chip into a system and then not use all of its capabilities.
> Remember, only 8 out of the 60 fbdev drivers have DRM modules.
>
> Worst thing that can happen is that they lose 50K of memory. Don't
> spend a lot of effort worrying about this especially if no one is
> complaining. Issues like this can be addressed later.

Yes, however, I don't think a lot of embedded people are putting DRM capable 
chips in their machines. And I will worry about that at all points, to great 
length - I will actually fight to keep a complete merger from happening. For 
exactly the reasons I stated above.

> > > BTW, I have already submitted a patch that does this and it was
> > > rejected. I might be able to find it somewhere, but the dependency
> > > code is not very hard to write.
> >
> > If you can find it Jon, I'd appreciate it. If not, then I'll have to dive
> > into the code head first and hope I don't drown in it.
>
> I'll poke around and see if I can find it, but it probably wouldn't
> merge anymore.  It took me less than a day to write it so it shouldn't
> be too hard to recreate. Just add a do nothing function to each of the
> 8 fbdev drivers and then make each of the 8 DRM drivers call it. Then
> adjust the include and make files until everything compiles. You're
> not trying to change anything yet, you're just trying to bind them to
> each other.

Thanks.

DRH
