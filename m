Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965398AbWI0G4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbWI0G4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965399AbWI0G4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:56:19 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:11750 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965398AbWI0G4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:56:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
Date: Wed, 27 Sep 2006 08:58:42 +0200
User-Agent: KMail/1.9.1
Cc: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060926053728.GA8970@kroah.com> <20060926203948.GB15674@suse.de> <1159346843.6957.21.camel@Homer.simpson.net>
In-Reply-To: <1159346843.6957.21.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270858.43361.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 September 2006 10:47, Mike Galbraith wrote:
> On Tue, 2006-09-26 at 13:39 -0700, Greg KH wrote: 
> > On Tue, Sep 26, 2006 at 12:34:05PM +0000, Mike Galbraith wrote:
> > > On Mon, 2006-09-25 at 22:37 -0700, Greg KH wrote:
> > > > Here are a bunch of driver core and sysfs patches and fixes for 2.6.18.
> > > 
> > > Hi,
> > > 
> > > Just as an fyi, these patches cause a ~regression on my P4/HT box.
> > > 
> > > Suspend stopped here working after 2.6.17.
> > 
> > Does 2.6.18 also have these problems?
> 
> Suspend failure, yes, kill box on failure, no.
> 
> > If so, it's not due to these patches :)
> 
> The 'Mikie's box' killer is definitely somewhere in these patches.  I
> decided to test them after having just happened to have tried
> 2.6.18-rc7-mm1 to see if it the mm tree had fixed my suspend problem for
> me, and then seeing your post.  Since 2.6.18 with these patches went
> from ho-hum broke to ding-dong dead, I figured I should mention it.
> 
> > > I haven't dug into why, but
> > > since then, I get a message "Class driver suspend failed for cpu0", and
> > > the suspend fails, but everything works fine afterward.  If I ignore the
> > > return of drv->suspend(), the box will suspend and resume just fine,
> > > both with this patch set and without.  (which is what I've been doing
> > > while waiting for it to fix itself or for my round toit to turn up)
> > 
> > What driver is controling cpu0?
> > What driver is failing the suspend?
> 
> Dunno, see below.   
> 
> > What line did you have to change?
> 
> drivers/base/sys.c:409
> 
> Adding a WARN_ON() there wasn't particularly illuminating.  I enabled
> debugging (this is virgin 2.6.18), and get the following.  I see a
> problem I didn't notice before, see 'Hmm' below.  I have no idea if it
> has anything to do with box killer problem with patchset applied.

Please try to remove the acpi_cpufreq driver before the suspend.

If that works, please add your system configuration to the bugzilla entry at
http://bugzilla.kernel.org/show_bug.cgi?id=7188

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
