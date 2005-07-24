Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVGXQUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVGXQUf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVGXQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 12:20:35 -0400
Received: from tim.rpsys.net ([194.106.48.114]:51608 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261383AbVGXQUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 12:20:32 -0400
Subject: Re: 2.6.13-rc3-mm1
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Dirk Opfer <dirk@opfer-online.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
References: <20050715013653.36006990.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 24 Jul 2005 17:20:21 +0100
Message-Id: <1122222021.7585.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 01:36 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/

On the Zaurus I'm seeing a couple of false "BUG: soft lockup detected on
CPU#0!" reports. These didn't show under 2.6.12-mm1 which was the last
-mm kernel I tested. softlockup.c seems identical between these versions
so it looks like some other change has caused this to appear...

Both of these are triggered from the nand driver. The functions
concerned (nand_wait_ready and nand_read_buf) are known to be slow (they
wait on hardware).

Richard

BUG: soft lockup detected on CPU#0!
Pid: 1, comm:              swapper
CPU: 0
PC is at sharpsl_nand_dev_ready+0x14/0x28
LR is at nand_wait_ready+0x30/0x50
pc : [<c015f15c>]    lr : [<c0159ea4>]    Not tainted
sp : c034fa24  ip : c034fa34  fp : c034fa30
r10: c3c09400  r9 : c035e890  r8 : 0000c75a
r7 : c022533c  r6 : c3c09580  r5 : c3c09400  r4 : ffff8fc3
r3 : c027f0bc  r2 : c4856000  r1 : c4856000  r0 : c3c09400
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: A0004000  DAC: 00000017
[<c001dd38>] (show_regs+0x0/0x4c) from [<c0059f48>] (softlockup_tick
+0x7c/0xb0)
 r4 = C034E000
[<c0059ecc>] (softlockup_tick+0x0/0xb0) from [<c0042198>] (do_timer
+0x278/0x500)
 r5 = 00000000  r4 = 00000001
[<c0041f20>] (do_timer+0x0/0x500) from [<c00211ac>] (timer_tick
+0xb4/0xf8)
[<c00210f8>] (timer_tick+0x0/0xf8) from [<c00279a0>]
(pxa_timer_interrupt+0x48/0xa8)
 r6 = C034F9DC  r5 = C034E000  r4 = F2A00000
[<c0027958>] (pxa_timer_interrupt+0x0/0xa8) from [<c001cb60>] (__do_irq
+0x6c/0xc4)
 r8 = C034F9DC  r7 = 00000000  r6 = 00000000  r5 = C034E000
 r4 = C0226314
[<c001caf4>] (__do_irq+0x0/0xc4) from [<c001cddc>] (do_level_IRQ
+0x68/0xb8)
[<c001cd74>] (do_level_IRQ+0x0/0xb8) from [<c001ce80>] (asm_do_IRQ
+0x54/0x164)
 r6 = 04000000  r5 = F2D00000  r4 = FFFFFFFF
[<c001ce2c>] (asm_do_IRQ+0x0/0x164) from [<c001b9b8>] (__irq_svc
+0x38/0x78)
[<c015f148>] (sharpsl_nand_dev_ready+0x0/0x28) from [<c0159ea4>]
(nand_wait_ready+0x30/0x50)
[<c0159e74>] (nand_wait_ready+0x0/0x50) from [<c0159f60>] (nand_command
+0x9c/0x1f0)
 r7 = 00000000  r6 = C3C09400  r5 = C3C09580  r4 = 00000000
[<c0159ec4>] (nand_command+0x0/0x1f0) from [<c015b4b8>]
(nand_do_read_ecc+0x720/0x7c8)
 r8 = C034FACC  r7 = 00000200  r6 = C3C09580  r5 = 0000C75A
 r4 = 00000000
[<c015ad98>] (nand_do_read_ecc+0x0/0x7c8) from [<c015b5e8>]
(nand_read_ecc+0x44/0x4c)
[<c015b5a4>] (nand_read_ecc+0x0/0x4c) from [<c0155364>] (part_read_ecc
+0xa4/0xbc)
 r4 = 00000000
[<c01552c0>] (part_read_ecc+0x0/0xbc) from [<c00e5280>]
(jffs2_flash_read+0x1fc/0x2b0)
 r7 = 00000000  r6 = 011E8B70  r5 = 00000000  r4 = C034FBF0
[<c00e5084>] (jffs2_flash_read+0x0/0x2b0) from [<c00dbd48>]
(jffs2_fill_scan_buf+0x2c/0x4c)
[<c00dbd1c>] (jffs2_fill_scan_buf+0x0/0x4c) from [<c00dc424>]
(jffs2_scan_medium+0x63c/0x1884)
 r4 = 011E8B7C
[<c00dbde8>] (jffs2_scan_medium+0x0/0x1884) from [<c00e0020>]
(jffs2_do_mount_fs+0x1bc/0x6cc)
[<c00dfe64>] (jffs2_do_mount_fs+0x0/0x6cc) from [<c00e2d60>]
(jffs2_do_fill_super+0x130/0x2b4)
[<c00e2c30>] (jffs2_do_fill_super+0x0/0x2b4) from [<c00e3244>]
(jffs2_get_sb_mtd+0xf4/0x134)
 r8 = 00008401  r7 = C3C4B4E0  r6 = C3C4B4FC  r5 = C3C4B200
 r4 = C3C4B400
[<c00e3150>] (jffs2_get_sb_mtd+0x0/0x134) from [<c00e32d4>]
(jffs2_get_sb_mtdnr+0x50/0x5c)
[<c00e3284>] (jffs2_get_sb_mtdnr+0x0/0x5c) from [<c00e3410>]
(jffs2_get_sb+0x130/0x1c0)
 r7 = 00008001  r6 = C034FD5C  r5 = C3C50000  r4 = FFFFFFEA
[<c00e32e0>] (jffs2_get_sb+0x0/0x1c0) from [<c00890d0>] (do_kern_mount
+0x50/0xf4)
[<c0089080>] (do_kern_mount+0x0/0xf4) from [<c00a3de8>] (do_mount
+0x3ac/0x650)
[<c00a3a3c>] (do_mount+0x0/0x650) from [<c00a44c8>] (sys_mount
+0x9c/0xe8)
[<c00a442c>] (sys_mount+0x0/0xe8) from [<c0008b64>] (mount_block_root
+0xb0/0x264)
 r7 = C0343000  r6 = C034FF54  r5 = C0343006  r4 = C0343000
[<c0008ab4>] (mount_block_root+0x0/0x264) from [<c0008d74>] (mount_root
+0x5c/0x6c)
[<c0008d18>] (mount_root+0x0/0x6c) from [<c0008dc4>] (prepare_namespace
+0x40/0xe4)
 r5 = C0019C70  r4 = C0019CC0
[<c0008d84>] (prepare_namespace+0x0/0xe4) from [<c001b200>] (init
+0x190/0x1fc)
 r5 = C034E000  r4 = C01F5AA0
[<c001b070>] (init+0x0/0x1fc) from [<c0039a10>] (do_exit+0x0/0xd8c)
 r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
 r4 = 00000000
VFS: Mounted root (jffs2 filesystem) readonly.

and 

BUG: soft lockup detected on CPU#0!
Pid: 1063, comm:              busybox
CPU: 0
PC is at nand_read_buf+0x28/0x3c
LR is at 0x100
pc : [<c0159cb8>]    lr : [<00000100>]    Not tainted
sp : c355dac8  ip : 0000003b  fp : c355dad4
r10: c3c09400  r9 : c3b20884  r8 : 00000002
r7 : 00000000  r6 : c3c09580  r5 : 00000000  r4 : c3b20884
r3 : c4856014  r2 : 000000d3  r1 : c3b20884  r0 : c3c09580
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 397F  Table: A354C000  DAC: 00000015
[<c001dd38>] (show_regs+0x0/0x4c) from [<c0059f48>] (softlockup_tick
+0x7c/0xb0)
 r4 = C355C000
[<c0059ecc>] (softlockup_tick+0x0/0xb0) from [<c0042198>] (do_timer
+0x278/0x500)
 r5 = 00000000  r4 = 00000001
[<c0041f20>] (do_timer+0x0/0x500) from [<c00211ac>] (timer_tick
+0xb4/0xf8)
[<c00210f8>] (timer_tick+0x0/0xf8) from [<c00279a0>]
(pxa_timer_interrupt+0x48/0xa8)
 r6 = C355DA80  r5 = C355C000  r4 = F2A00000
[<c0027958>] (pxa_timer_interrupt+0x0/0xa8) from [<c001cb60>] (__do_irq
+0x6c/0xc4)
 r8 = C355DA80  r7 = 00000000  r6 = 00000000  r5 = C355C000
 r4 = C0226314
[<c001caf4>] (__do_irq+0x0/0xc4) from [<c001cddc>] (do_level_IRQ
+0x68/0xb8)
[<c001cd74>] (do_level_IRQ+0x0/0xb8) from [<c001ce80>] (asm_do_IRQ
+0x54/0x164)
 r6 = 04000000  r5 = F2D00000  r4 = FFFFFFFF
[<c001ce2c>] (asm_do_IRQ+0x0/0x164) from [<c001b9b8>] (__irq_svc
+0x38/0x78)
[<c0159c90>] (nand_read_buf+0x0/0x3c) from [<c015b328>]
(nand_do_read_ecc+0x590/0x7c8)
[<c015ad98>] (nand_do_read_ecc+0x0/0x7c8) from [<c015b5e8>]
(nand_read_ecc+0x44/0x4c)
[<c015b5a4>] (nand_read_ecc+0x0/0x4c) from [<c0155364>] (part_read_ecc
+0xa4/0xbc)
 r4 = 00000000
[<c01552c0>] (part_read_ecc+0x0/0xbc) from [<c00e5280>]
(jffs2_flash_read+0x1fc/0x2b0)
 r7 = 00000000  r6 = 0242897C  r5 = 00000000  r4 = C355DC4C
[<c00e5084>] (jffs2_flash_read+0x0/0x2b0) from [<c00dbd48>]
(jffs2_fill_scan_buf+0x2c/0x4c)
[<c00dbd1c>] (jffs2_fill_scan_buf+0x0/0x4c) from [<c00dc424>]
(jffs2_scan_medium+0x63c/0x1884)
 r4 = 02428988
[<c00dbde8>] (jffs2_scan_medium+0x0/0x1884) from [<c00e0020>]
(jffs2_do_mount_fs+0x1bc/0x6cc)
[<c00dfe64>] (jffs2_do_mount_fs+0x0/0x6cc) from [<c00e2d60>]
(jffs2_do_fill_super+0x130/0x2b4)
[<c00e2c30>] (jffs2_do_fill_super+0x0/0x2b4) from [<c00e3244>]
(jffs2_get_sb_mtd+0xf4/0x134)
 r8 = 00000400  r7 = C3C510E0  r6 = C3C510FC  r5 = C3F59C00
 r4 = C3C51000
[<c00e3150>] (jffs2_get_sb_mtd+0x0/0x134) from [<c00e32d4>]
(jffs2_get_sb_mtdnr+0x50/0x5c)
[<c00e3284>] (jffs2_get_sb_mtdnr+0x0/0x5c) from [<c00e3410>]
(jffs2_get_sb+0x130/0x1c0)
 r7 = 00000400  r6 = C355DDB8  r5 = C3D70000  r4 = FFFFFFEA
[<c00e32e0>] (jffs2_get_sb+0x0/0x1c0) from [<c00890d0>] (do_kern_mount
+0x50/0xf4)
[<c0089080>] (do_kern_mount+0x0/0xf4) from [<c00a3de8>] (do_mount
+0x3ac/0x650)
[<c00a3a3c>] (do_mount+0x0/0x650) from [<c00a44c8>] (sys_mount
+0x9c/0xe8)
[<c00a442c>] (sys_mount+0x0/0xe8) from [<c001bdc0>] (ret_fast_syscall
+0x0/0x2c)
 r7 = 00000015  r6 = 000AC1F8  r5 = 00000000  r4 = 000A9050



