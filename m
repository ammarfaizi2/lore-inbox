Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSAVRQP>; Tue, 22 Jan 2002 12:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSAVRQG>; Tue, 22 Jan 2002 12:16:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55822 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288028AbSAVRP5>; Tue, 22 Jan 2002 12:15:57 -0500
Date: Tue, 22 Jan 2002 12:15:28 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Alok K. Dhir" <alok@dhir.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Autostart RAID 1+0 (root)
In-Reply-To: <001201c1a03e$e654acd0$9865fea9@pcsn630778>
Message-ID: <Pine.LNX.3.96.1020122120342.27404A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Alok K. Dhir wrote:

> I want to test using a software RAID 1+0 partition as root: md0 and md1
> set up as mirrors between two disks each, and md2 set up as a stripe
> between md0 and md1.  However, the RedHat 7.2 installer doesn't allow
> creating nested RAID partitions.

Here's my understanding. If you are using hardware RAID you can do
anything your controller supports, and it looks like a single drive to the
CPU. But if you are looking for reliable boot, you need to use /boot as a
RAID-1 partition on the first two drives, and make that partition the
active partition (that may not be needed with your BIOS).

This is because if the first disk fails totally, the 2nd will be used to
boot. You also should use an initrd image to be sure all you need to get
up is on that small mirrored partition. After that your other partitions
can be whatever pleases you.
 
> Being stubborn, I installed the OS onto a separate 4 gig disk, installed
> all the latest patches+fixes to the OS, including the RH2.4.9-13 kernel,
> then created md0, md1, and md2.  I formatted md2 with reiserfs.  No
> problem so far.
> 
> Next, I copied the entire contents of the root partition onto md2,
> changed the relevant line of /boot/grub/grub.conf from:
> 
> 	kernel /vmlinuz-2.4.9-13 ro root=/dev/sda2
> 
> To:
> 
> 	kernel /vmlinuz-2.4.9-13 ro root=/dev/md2
> 
> Changed fstab so "/" points to /dev/md2 as well, crossed my fingers, and
> rebooted.
> 
> No luck.  I get a "cannot mount root" error.
> 
> Attempting to speed read the boot messages before I get the panic, it
> appears that md0 and md1 are autostarted, but it doesn't look like md2
> is.
> 
> Does the kernel support autostarting nested RAID partitions?
> 
> Is doing software 1+0 a bad idea anyway due to performance issues?

It should outperform most other RAID configs under heavy load, but in most
cases RAID-5 is fine for system which don't need the absolute highest
performance. Note that the extra writes are queued and there are no extra
reads unless it is in recovery mode. RAID-1 can be faster, because there
are two copies of the data, if one drive is busy the other can be used. I
haven't checked to see that software RAID does that correctly and gets the
benefit.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

