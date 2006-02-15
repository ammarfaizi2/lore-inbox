Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWBOOdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWBOOdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBOOdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:33:40 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:625 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932451AbWBOOdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:33:39 -0500
Date: Wed, 15 Feb 2006 15:33:46 +0100
From: Sander <sander@humilis.net>
To: Sander <sander@humilis.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3 kernel BUG at drivers/scsi/sata_mv.c:1018
Message-ID: <20060215143346.GB26178@favonius>
Reply-To: sander@humilis.net
References: <20060215131653.GA26178@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215131653.GA26178@favonius>
X-Uptime: 12:37:52 up 15 days,  3:55, 25 users,  load average: 3.71, 3.11, 2.78
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote (ao):
# Hi Jeff and others,
# 
# I get a kernel BUG message when I try to create a raid1 or raid5 over
# nine 64MB partitions located on nine sata disks (Maxtor Pro 500) on a
# fresh setup. The system locks hard: no sysrq.
# 
# The onboard controller is an nVidia nForce with three disks.
# The six other disks are connected to a Marvell 88SX6081 controller.
# 
# Last night and the first half of today all disks were tested with
# badblocks in write mode, which the system survived just fine (one disk
# out of ten detected as broken, so nine disks left).
# 
# A google search leads me to
# 
# http://www.uwsg.iu.edu/hypermail/linux/kernel/0601.2/0479.html
# 
# and
# 
# http://www.uwsg.iu.edu/hypermail/linux/kernel/0601.2/0626.html
# 
# I had MSI disabled in the .config already, and will try again with debug
# options set.
# 
# In the mean time, is this of any help?
# 
# I can try any patch you throw at me, or any config option, as this
# system is not in production yet.
# 
# 	Sander
# 
# Linux version 2.6.16-rc3 (root@elisha) (gcc version 4.0.3 20060104 (prerelease) (Debian 4.0.2-6))
# 
# mdadm -C -l1 -n9 /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1 \
# /dev/sdd1 /dev/sde1 /dev/sdf1 /dev/sdg1 /dev/sdh1 /dev/sdi1
# 
# [19697.866199] md: bind<sda1>
# [19697.866251] md: bind<sdc1>
# [19697.866294] md: bind<sdd1>
# [19697.866332] md: bind<sde1>
# [19697.866374] md: bind<sdf1>
# [19697.866414] md: bind<sdg1>
# [19697.866454] md: bind<sdh1>
# [19697.866492] md: bind<sdi1>
# [19697.866531] md: bind<sdj1>
# [19697.866734] raid1: raid set md0 active with 9 out of 9 mirrors
# [19697.866888] ----------- [cut here ] --------- [please bite here ] ---------
# [19697.866921] Kernel BUG at drivers/scsi/sata_mv.c:1018
# [19697.866950] invalid opcode: 0000 [1] SMP 
# [19697.866984] CPU 1 
# [19697.867010] Modules linked in:
# [19697.867040] Pid: 2491, comm: mdadm Not tainted 2.6.16-rc3 #1
# [19697.867075] RIP: 0010:[<ffffffff8029975a>] <ffffffff8029975a>{mv_qc_prep+307}
# [19697.867103] RSP: 0000:ffff81013fc9bd28  EFLAGS: 00010002
# [19697.867152] RAX: ffff81000c63f03d RBX: ffff81013a691500 RCX: ffff81000c63f02a
# [19697.867186] RDX: ffff81013a5639d8 RSI: 0000000000000046 RDI: ffff81013a5639b8
# [19697.867220] RBP: ffff81013a5639b8 R08: 0000000000000004 R09: ffff81013fc9bc4c
# [19697.867267] R10: 00000000000000c3 R11: ffffffff802e188d R12: 0000000000000000
# [19697.867302] R13: ffff81013a563480 R14: ffffffff8027d502 R15: ffff81013a563480
# [19697.867335] FS:  00002b35e01f7ae0(0000) GS:ffff81013fc759c0(0000) knlGS:0000000000000000
# [19697.867384] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
# [19697.867415] CR2: 0000000000511768 CR3: 00000001333fc000 CR4: 00000000000006e0
# [19697.867450] Process mdadm (pid: 2491, threadinfo ffff81013a040000, task ffff81013a591020)
# [19697.867497] Stack: ffff81013a5639b8 ffff81013a5639b8 ffff81013a603280 ffffffff802932bd 
# [19697.867546]        ffff81013a603280 ffff81013a5639b8 ffff81013a562280 ffff81013a563558 
# [19697.867624]        ffff81013a563480 ffffffff8027d502 
# [19697.867662] Call Trace: <IRQ> <ffffffff802932bd>{ata_qc_issue+794}
# [19697.867710]        <ffffffff8027d502>{scsi_done+0} <ffffffff8029765d>{ata_scsi_translate+172}
# [19697.867778]        <ffffffff802972ae>{ata_scsi_rw_xlat+0} <ffffffff8027d502>{scsi_done+0}


I would like to add that this is on a 64bit Opteron system. With these
debug options enabled, I get (albeit little) extra output.

Is there anything I can do to get more output?


CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
# CONFIG_SCHEDSTATS is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_KOBJECT=y
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
# CONFIG_FORCED_INLINING is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_DEBUG_RODATA is not set
# CONFIG_IOMMU_DEBUG is not set



[  500.043196] md: bind<sda1>
[  500.043320] md: bind<sdb1>
[  500.046718] md: bind<sdc1>
[  500.046828] md: bind<sdd1>
[  500.046935] md: bind<sde1>
[  500.047043] md: bind<sdf1>
[  500.047147] md: bind<sdg1>
[  500.047254] md: bind<sdh1>
[  500.047357] md: bind<sdi1>
[  500.047834] raid1: raid set md0 active with 9 out of 9 mirrors
[  500.048039] ----------- [cut here ] --------- [please bite here ] ---------
[  500.048093] Kernel BUG at drivers/scsi/sata_mv.c:1018
[  500.048143] invalid opcode: 0000 [1] SMP 
[  500.048241] CPU 1 
[  500.048309] Modules linked in:
[  500.048381] Pid: 2379, comm: mdadm Not tainted 2.6.16-rc3 #1
[  500.048431] RIP: 0010:[<ffffffff802b17e3>] <ffffffff802b17e3>{mv_qc_prep+320}
[  500.048503] RSP: 0000:ffff81013fca7bd8  EFLAGS: 00010002
[  500.048592] RAX: ffff810006c9a03d RBX: ffff81013b35dda0 RCX: ffff810006c9a08a
[  500.048646] RDX: ffff81013ac44aa0 RSI: 0000000000000092 RDI: ffff81013ac44a80
[  500.048701] RBP: ffff81013fca7bf8 R08: 0000000000000004 R09: ffff81013fca7afc
[  500.048757] R10: 00000000000000c3 R11: ffffffff80585968 R12: ffff81013ac44a80
[  500.048812] R13: 0000000000000000 R14: ffff81013ac44548 R15: ffffffff80293f69
[  500.048867] FS:  00002adb0f5c4ae0(0000) GS:ffff81013fc52e88(0000) knlGS:0000000000000000
[  500.048936] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  500.048990] CR2: 00007ffffff98e98 CR3: 000000013295c000 CR4: 00000000000006e0
[  500.049046] Process mdadm (pid: 2379, threadinfo ffff81013a26e000, task ffff81013b2b7820)
[  500.049114] Stack: ffff81013b385a48 ffff81013ac44548 ffff81013ac44a80 ffff81013b385a48 
[  500.049277]        ffff81013fca7c48 ffffffff802aae98 ffff81013fca7c48 ffff81013ac44548 
[  500.049491]        ffff81013b385a48 ffff81013ac44a80 
[  500.049622] Call Trace: <IRQ> <ffffffff802aae98>{ata_qc_issue+855}
[  500.049779]        <ffffffff80293f69>{scsi_done+0} <ffffffff802af549>{ata_scsi_translate+190}
[  500.049958]        <ffffffff802af187>{ata_scsi_rw_xlat+0} <ffffffff80293f69>{scsi_done+0}
[  535.019510] BUG: spinlock lockup on CPU#1, mdadm/2379, ffff81013f6c4b78
[  535.019561] 
[  535.019562] Call Trace: <IRQ> <ffffffff80217e87>{_raw_spin_lock+219}
[  535.019718]        <ffffffff80398a25>{_spin_lock+9} <ffffffff802b1d6f>{mv_interrupt+86}
[  535.019889]        <ffffffff801403af>{handle_IRQ_event+48} <ffffffff8014048f>{__do_IRQ+167}
[  535.020064]        <ffffffff8010d2c5>{do_IRQ+62} <ffffffff8010ae64>{ret_from_intr+0}
[  535.020236]        <ffffffff80114a5f>{smp_send_stop+71} <ffffffff80123819>{panic+165}
[  535.023678]        <ffffffff8010beee>{show_stack+211} <ffffffff8012604c>{do_exit+133}
[  535.023851]        <ffffffff8010c3e9>{kernel_math_error+0} <ffffffff8010c999>{do_trap+237}
[  535.024022]        <ffffffff80293f69>{scsi_done+0} <ffffffff8010ce10>{do_invalid_op+157}
[  535.024194]        <ffffffff802b17e3>{mv_qc_prep+320} <ffffffff802fe42a>{pci_conf1_read+204}
[  535.024523]        <ffffffff8021bfbb>{pci_bus_read_config_dword+121} <ffffffff8010b5fd>{error_exit+0}
[  535.024696]        <ffffffff80293f69>{scsi_done+0} <ffffffff802b17e3>{mv_qc_prep+320}
[  535.024868]        <ffffffff802aae98>{ata_qc_issue+855} <ffffffff80293f69>{scsi_done+0}
[  535.025038]        <ffffffff802af549>{ata_scsi_translate+190}


-- 
Humilis IT Services and Solutions
http://www.humilis.net
