Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbTDAGlu>; Tue, 1 Apr 2003 01:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbTDAGlt>; Tue, 1 Apr 2003 01:41:49 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:48891
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262074AbTDAGls>; Tue, 1 Apr 2003 01:41:48 -0500
Date: Tue, 1 Apr 2003 01:48:50 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: gibbs@scsiguy.com
Subject: aic7(censored) use after free in 2.5.66
Message-ID: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this on boot on an 8way/16G box, perhaps Justin should try 
and push his latest? CONFIG_PREEMPT=y if that makes any difference at 
all.. If anyone is interested i can provide more info.

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28

Slab corruption: start=f7d66248, expend=f7d662c7, problemat=f7d662ac
Last user: [<c024f0b7>](ahc_linux_free_device+0x27/0x60)
Data: 
****************************************************************************************************6C 
**************************A5 
Next: 71 F0 2C .B7 F0 24 C0 A5 C2 0F 17 00 A0 E8 EB 00 80 85 EC C2 03 00 00 C2 03 00 00 00 00 00 A0 
slab error in check_poison_obj(): cache `size-128': object was modified 
after freeing
Call Trace:
 [<c01436c9>] check_poison_obj+0x179/0x190
 [<c0144f5d>] kmalloc+0xdd/0x190
 [<c01dd4fa>] con_insert_unipair+0x8a/0xe0
 [<c0144f5d>] kmalloc+0xdd/0x190
 [<c01dd5a4>] con_clear_unimap+0x54/0xc0
 [<c0143583>] check_poison_obj+0x33/0x190
 [<c01dd4fa>] con_insert_unipair+0x8a/0xe0
 [<c01dd926>] con_set_default_unimap+0xc6/0x140
 [<c01e0a35>] vc_allocate+0x95/0x130
 [<c01e4039>] con_open+0x19/0x90
 [<c01d2389>] tty_open+0x249/0x460
 [<c0143583>] check_poison_obj+0x33/0x190
 [<c0164e57>] get_chrfops+0x27/0xb0
 [<c015cf97>] get_empty_filp+0x47/0xe0
 [<c0165262>] chrdev_open+0x82/0x100
 [<c015b3e7>] dentry_open+0xc7/0x160
 [<c0144dde>] kmem_cache_alloc+0x9e/0x140
 [<c015b30d>] filp_open+0x4d/0x60
 [<c016933e>] getname+0x5e/0xa0
 [<c015b765>] sys_open+0x35/0x70
 [<c010aecf>] syscall_call+0x7/0xb


-- 
function.linuxpower.ca
