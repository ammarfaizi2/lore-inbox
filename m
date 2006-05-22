Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWEVJ4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWEVJ4b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 05:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbWEVJ4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 05:56:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37344 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751018AbWEVJ4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 05:56:30 -0400
Date: Mon, 22 May 2006 11:55:31 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: trenn@suse.de, "Yu, Luming" <luming.yu@intel.com>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Tom Seeley <redhat@tomseeley.co.uk>,
       Dave Jones <davej@redhat.com>, Jiri Slaby <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT]
Message-ID: <20060522095531.GC25624@elf.ucw.cz>
References: <1148046258.9319.441.camel@queen.suse.de> <E1FhbYy-0005jL-00@skye.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FhbYy-0005jL-00@skye.ra.phy.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > https://bugzilla.novell.com/show_bug.cgi?id=173420
> 
> >From Comment #30 at the above url: "The Linux ACPI code seems to
> actively prevent the fan from running and that worries me."
> 
> I saw that as well, and found the following recipe would work around
> the problem:
> 
> 1. Set the trip point to, say, 70 C -- well above the actual
>    temperature.
> 
> 2. Then set the trip to anything reasonable that's under the current
>    temperature (27 C always works).  Now the fan turns on, and behaves
>    fine from then.
> 
> My explanation is that, before step 1, the fan is off but the OS
> thinks it's on.  So the dialogue goes something like:
> 
> Hardware (from EC or BIOS?): Ack, I'm overheating, turn on the fan now!
> OS: There, there, take it easy.  I've checked bit fields in my
>      memory, and the fan is on.  So I don't have to do anything.
> Hardware: Ack, ...
> OS: There, there, ...
> [Hence the 100% kacpid CPU usage]
> 
> Based on this explanation, I added a resume method to the fan driver.
> It would turn on the fan and mark it as on.  So then the internal OS
> state matched the actual state.  The fix didn't work for at least one
> reason: ACPI drivers didn't have suspend/resume methods (though now
> there are test patches to add those methods).

Can you redo your patches with those methods?

> Another fix, probably worth doing anyway, is to turn on the fan if the
> BIOS asks for it, whether or not the OS thinks it's on.  The chance of
> the two pieces of information getting out of synch, and the hardware
> damage it can cause, is enough to make it worthwhile.  The reverse

There should be 0% hardware damage chance. Fan failure means overheats
mean emergency power cutoff. I even tested it with paper into fan
blades several times. It mostly works.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
