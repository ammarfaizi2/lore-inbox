Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVBDQa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVBDQa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 11:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbVBDQa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 11:30:57 -0500
Received: from gprs215-42.eurotel.cz ([160.218.215.42]:4802 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261570AbVBDQad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 11:30:33 -0500
Date: Fri, 4 Feb 2005 17:30:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Message-ID: <20050204163019.GC1290@elf.ucw.cz>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420367CF.7060206@gmx.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 3) The user space reset programs have to be serialized because of the
> > rule about only a single VGA at a time. Calling vm86 from kernel mode
> > is not a good idea. Doing this in user space lets you have two reset
> > programs, vm86 and emu86 for non-x86 machines.
> 
> With the approach I detailed in the thread starter, this is easily
> possible. vesaposter can call the kernel function used to synchronize
> in an endless loop and this kernel function would not only be used
> to synchronize, but its return value would tell vesaposter what to do
> to which card. An alternative would be to restart vesaposter as soon
> as it has finished its job, which would make the POSTing reliable
> even if the BIOS code hangs or causes crashes. The kernel can simply
> store a list of video devices and their respective treatments and
> the kernel function called by vesaposter would just iterate through
> the list. Hmmm... why not call it
> 
> int video_helper(struct video_actions *what_to_do)

I do not know, synchronously executing userland code from kernel seems
like wrong thing to do.

> And the problem of locking all application memory: The current tool
> for POSTing and restoring video state (vbetool) uses only 27k on
> disk. If we put it in initramfs, we could maybe avoid mlock
> completely (if we can guarantee initramfs contents aren't swapped
> out). And it would be available early enough for initializing
> video hardware on boot.

I do not understand how initramfs fits into picture... Plus lot of
people (me :-) do not use initramfs...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
