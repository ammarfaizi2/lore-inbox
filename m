Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290735AbSARQkv>; Fri, 18 Jan 2002 11:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290737AbSARQka>; Fri, 18 Jan 2002 11:40:30 -0500
Received: from server1.symplicity.com ([209.61.154.230]:32004 "HELO
	mail2.symplicity.com") by vger.kernel.org with SMTP
	id <S290735AbSARQkV>; Fri, 18 Jan 2002 11:40:21 -0500
From: "Alok K. Dhir" <alok@dhir.net>
To: <linux-kernel@vger.kernel.org>
Subject: Autostart RAID 1+0 (root)
Date: Fri, 18 Jan 2002 11:40:55 -0500
Message-ID: <001201c1a03e$e654acd0$9865fea9@pcsn630778>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey all - I may be trying to do the impossible here, but here goes:

I want to test using a software RAID 1+0 partition as root: md0 and md1
set up as mirrors between two disks each, and md2 set up as a stripe
between md0 and md1.  However, the RedHat 7.2 installer doesn't allow
creating nested RAID partitions.

Being stubborn, I installed the OS onto a separate 4 gig disk, installed
all the latest patches+fixes to the OS, including the RH2.4.9-13 kernel,
then created md0, md1, and md2.  I formatted md2 with reiserfs.  No
problem so far.

Next, I copied the entire contents of the root partition onto md2,
changed the relevant line of /boot/grub/grub.conf from:

	kernel /vmlinuz-2.4.9-13 ro root=/dev/sda2

To:

	kernel /vmlinuz-2.4.9-13 ro root=/dev/md2

Changed fstab so "/" points to /dev/md2 as well, crossed my fingers, and
rebooted.

No luck.  I get a "cannot mount root" error.

Attempting to speed read the boot messages before I get the panic, it
appears that md0 and md1 are autostarted, but it doesn't look like md2
is.

Does the kernel support autostarting nested RAID partitions?

Is doing software 1+0 a bad idea anyway due to performance issues?

Any ideas?

Thanks!

