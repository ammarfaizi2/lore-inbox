Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265776AbSJTFba>; Sun, 20 Oct 2002 01:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSJTFba>; Sun, 20 Oct 2002 01:31:30 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:7697 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265776AbSJTFb3>; Sun, 20 Oct 2002 01:31:29 -0400
Date: Sun, 20 Oct 2002 07:37:02 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
Message-ID: <20021020053702.GA3579@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <Pine.LNX.3.96.1021019152828.29078L-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021019152828.29078L-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Davidsen <davidsen@tmr.com>
Date: Sat, Oct 19, 2002 at 03:40:22PM -0400
> I've beaten this dead horse before, but it still irks me that Linux can't
> power down an SMP system. People claim that it can't be done safely, but
> maybe somone can reverse engineer NT if we aren't up to the job.
> 
I'm trying to find out the same. So far:

2.5.43 will power down my smp VP6 board if I replace the BUG() calls in
arch/i386/kernel/apm.c with warnings. Somehow, the kernel doesn't
succesfully schedule itself to run on CPU 0. However, for my bios that
isn't needed.

2.5.44 doesn't work yet, since there's something funky going on with the
global_device_list() in drivers/base/power.c; the list is some kind of
loop when shutting down. I'm trying to find out what is happening there.
If you really need it working now, I'd be tempted to #if 0 out the whole
thing - at that point, my drives are unmounted and I don't really mind
what state the devices go down in when removing power in a few seconds.

> Every once in a while a power fail will leave the systems on UPS, and at
> some point it's needed to shut them down before the UPS is dead. You don't
> want that, since if the power comes up and then drops during boot it may
> hose filesystems. So I want the system really down while the UPS has a
> fair bit of power left.
> 
> The only suggestion I got was to install NT, put a powerdown in the
> startup directory, use lilo -R to reboot in NT, then do a reboot. 
> Wonderful. What I'm actually doing is rebooting a UP kernel and checking
> in rc.local for only one processor, in which case I power down. That
> works, but it's ugly! 
> 
> Is it really that hard to shutdown all CPUs but one, then power down?
> 
No, but it just doesn't work yet :-)

Jurriaan
-- 
I am the fingernail that scrapes the chalkboard of your soul
	Darkwing Duck
GNU/Linux 2.5.41 SMP/ReiserFS 2x1380 bogomips load av: 2.34 2.71 2.00
