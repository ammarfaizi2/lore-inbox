Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945930AbWBONQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945930AbWBONQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 08:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945934AbWBONQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 08:16:51 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:59246 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1945930AbWBONQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 08:16:50 -0500
Date: Wed, 15 Feb 2006 14:16:53 +0100
From: Sander <sander@humilis.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc3 kernel BUG at drivers/scsi/sata_mv.c:1018
Message-ID: <20060215131653.GA26178@favonius>
Reply-To: sander@humilis.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 12:37:52 up 15 days,  3:55, 25 users,  load average: 3.71, 3.11, 2.78
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff and others,

I get a kernel BUG message when I try to create a raid1 or raid5 over
nine 64MB partitions located on nine sata disks (Maxtor Pro 500) on a
fresh setup. The system locks hard: no sysrq.

The onboard controller is an nVidia nForce with three disks.
The six other disks are connected to a Marvell 88SX6081 controller.

Last night and the first half of today all disks were tested with
badblocks in write mode, which the system survived just fine (one disk
out of ten detected as broken, so nine disks left).

A google search leads me to

http://www.uwsg.iu.edu/hypermail/linux/kernel/0601.2/0479.html

and

http://www.uwsg.iu.edu/hypermail/linux/kernel/0601.2/0626.html

I had MSI disabled in the .config already, and will try again with debug
options set.

In the mean time, is this of any help?

I can try any patch you throw at me, or any config option, as this
system is not in production yet.

	Sander

Linux version 2.6.16-rc3 (root@elisha) (gcc version 4.0.3 20060104 (prerelease) (Debian 4.0.2-6))

mdadm -C -l1 -n9 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 \
/dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1 /dev/sdi1

[19697.866199] md: bind<sda1>
[19697.866251] md: bind<sdc1>
[19697.866294] md: bind<sdd1>
[19697.866332] md: bind<sde1>
[19697.866374] md: bind<sdf1>
[19697.866414] md: bind<sdg1>
[19697.866454] md: bind<sdh1>
[19697.866492] md: bind<sdi1>
[19697.866531] md: bind<sdj1>
[19697.866734] raid1: raid set md0 active with 9 out of 9 mirrors
[19697.866888] ----------- [cut here ] --------- [please bite here ] ---------
[19697.866921] Kernel BUG at drivers/scsi/sata_mv.c:1018
[19697.866950] invalid opcode: 0000 [1] SMP 
[19697.866984] CPU 1 
[19697.867010] Modules linked in:
[19697.867040] Pid: 2491, comm: mdadm Not tainted 2.6.16-rc3 #1
[19697.867075] RIP: 0010:[<ffffffff8029975a>] <ffffffff8029975a>{mv_qc_prep+307}
[19697.867103] RSP: 0000:ffff81013fc9bd28  EFLAGS: 00010002
[19697.867152] RAX: ffff81000c63f03d RBX: ffff81013a691500 RCX: ffff81000c63f02a
[19697.867186] RDX: ffff81013a5639d8 RSI: 0000000000000046 RDI: ffff81013a5639b8
[19697.867220] RBP: ffff81013a5639b8 R08: 0000000000000004 R09: ffff81013fc9bc4c
[19697.867267] R10: 00000000000000c3 R11: ffffffff802e188d R12: 0000000000000000
[19697.867302] R13: ffff81013a563480 R14: ffffffff8027d502 R15: ffff81013a563480
[19697.867335] FS:  00002b35e01f7ae0(0000) GS:ffff81013fc759c0(0000) knlGS:0000000000000000
[19697.867384] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[19697.867415] CR2: 0000000000511768 CR3: 00000001333fc000 CR4: 00000000000006e0
[19697.867450] Process mdadm (pid: 2491, threadinfo ffff81013a040000, task ffff81013a591020)
[19697.867497] Stack: ffff81013a5639b8 ffff81013a5639b8 ffff81013a603280 ffffffff802932bd 
[19697.867546]        ffff81013a603280 ffff81013a5639b8 ffff81013a562280 ffff81013a563558 
[19697.867624]        ffff81013a563480 ffffffff8027d502 
[19697.867662] Call Trace: <IRQ> <ffffffff802932bd>{ata_qc_issue+794}
[19697.867710]        <ffffffff8027d502>{scsi_done+0} <ffffffff8029765d>{ata_scsi_translate+172}
[19697.867778]        <ffffffff802972ae>{ata_scsi_rw_xlat+0} <ffffffff8027d502>{scsi_done+0}


-- 
Humilis IT Services and Solutions
http://www.humilis.net
