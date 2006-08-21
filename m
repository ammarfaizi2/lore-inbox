Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbWHULYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbWHULYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 07:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbWHULYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 07:24:24 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:10219 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S964997AbWHULYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 07:24:23 -0400
Date: Mon, 21 Aug 2006 13:24:05 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Subject: oops in __delayacct_blkio_ticks with 2.6.18-rc4
Message-ID: <20060821112405.GA28356@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


https://bugzilla.novell.com/show_bug.cgi?id=200526


tsk->delays became 0 after or during the call to spinlock. _spin_lock cant be
called with 0.

pear login: Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA
Modules linked in: pppoe pppox ppp_generic slhc joydev st ide_cd nfs lockd
nfs_acl sunrpc autofs ipv6 sg pdc202xx_new e1000 dm_mod raid0 ipr
firmware_class sr_mod cd
rom sd_mod scsi_mod
NIP: C00000000009D614 LR: C00000000009D604 CTR: 0000000000000000
REGS: c0000000bb307630 TRAP: 0300   Not tainted (2.6.18-rc4-20060810162421-ppc64)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24042422  XER: 20000001
DAR: 0000000000000028, DSISR: 0000000040000000
TASK = c0000002e0542ae0[24051] 'w' THREAD: c0000000bb304000 CPU: 5
GPR00: C00000000009D604 C0000000BB3078B0 C000000000620130 C0000002E308EAA0
GPR04: C0000000BB307AD0 C0000000BB307AD8 C0000000BB307AEF C0000002D2A29480
GPR08: C00000011A482380 0000000000989680 0000000000000000 0000000000000000
GPR12: 0000000000000000 C000000000476B80 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000011 0000000000400044
GPR20: 0000000000000000 0000000000005DED 0000000029B33DD2 000000000000FF15
GPR24: C00000013B42D500 0000000000000007 0000000000010002 0000000000000000
GPR28: 0000000000000000 C0000002D2A29480 C0000000004CAC98 C0000002D2A29480
NIP [C00000000009D614] .__delayacct_blkio_ticks+0x34/0x6c
LR [C00000000009D604] .__delayacct_blkio_ticks+0x24/0x6c
Call Trace:
[C0000000BB3078B0] [C00000000009D604] .__delayacct_blkio_ticks+0x24/0x6c (unreliable)
[C0000000BB307940] [C000000000128320] .do_task_stat+0x4b0/0x6fc
[C0000000BB307C40] [C000000000124F4C] .proc_info_read+0x9c/0x144
[C0000000BB307CF0] [C0000000000D394C] .vfs_read+0x118/0x200
[C0000000BB307D90] [C0000000000D3E30] .sys_read+0x4c/0x8c
[C0000000BB307E30] [C00000000000871C] syscall_exit+0x0/0x40
Instruction dump:
fba1ffe8 7c7d1b78 f8010010 f821ff71 60000000 60000000 e8630818 482e2c49
60000000 e97d0818 3d200098 61299680 <e86b0028> e80b0030 7c630214 7c634b92
