Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVA1VY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVA1VY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVA1VY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:24:28 -0500
Received: from mailhub.une.edu.au ([129.180.1.142]:48617 "EHLO
	mailhub2.une.edu.au") by vger.kernel.org with ESMTP id S262709AbVA1VXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:23:36 -0500
Date: Sat, 29 Jan 2005 08:23:34 +1100
From: Norman Gaywood <norm@turing.une.edu.au>
To: linux-kernel@vger.kernel.org
Subject: panic in raid1_end_write_request
Message-ID: <20050128212334.GA6576@turing.une.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell PE2650, Dual Xeon, 1G memory and several software raid1
partitions, ext3. Main duties include NFS, DHCP and samba. A Fedora
kernel 2.6.10-1.747_FC3smp which includes 2.6.10-ac10.

This system panics frequently, between several hours to several days. It
does not seem to be related to load. Hardware and memory tests indicate
a good system.

Panic messages are similar to:

Unable to handle kernel NULL pointer dereference at virtual address 00000038
 printing eip:
f882940f
*pde = 379c9001
Oops: 0000 [#1]
SMP 
Modules linked in: iptable_filter ip_tables nfsd exportfs md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core nfs lockd sunrpc microcode dm_mod video button battery ac cfi_probe gen_probe scb2_flash mtdcore chipreg map_funcs tg3 floppy sg ext3 jbd raid1 aic7xxx sd_mod scsi_mod
CPU:    3
EIP:    0060:[<f882940f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.10-1.747_FC3smp) 
EIP is at raid1_end_write_request+0x8e/0xb2 [raid1]
eax: 00000000   ebx: f7dda400   ecx: f79e78a0   edx: 00000000
esi: 00000018   edi: f7dd6e00   ebp: f7dda400   esp: c03aef18
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03ae000 task=f7f5fa40)
Stack: f7fbd100 00001000 f8829381 00000000 c01564ce 00001000 f7fbd100 00000000 
       c03aef60 c0217b6f f7bcca24 00000000 00000000 00000000 00001000 f7bcca24 
       f7d4b33c f78f4080 00000001 f88435ec 00000001 e4d10b80 f7bcca24 f78f4080 
Call Trace:
 [<f8829381>] raid1_end_write_request+0x0/0xb2 [raid1]
 [<c01564ce>] bio_endio+0x50/0x55
 [<c0217b6f>] __end_that_request_first+0xea/0x1ab
 [<f88435ec>] scsi_end_request+0x1b/0x9d [scsi_mod]
 [<f88439a7>] scsi_io_completion+0x206/0x40f [scsi_mod]
 [<c011a394>] __wake_up+0x29/0x3c
 [<f883fadd>] scsi_finish_command+0xad/0xb1 [scsi_mod]
 [<f883fa02>] scsi_softirq+0xb6/0xbe [scsi_mod]
 [<c0121f60>] __do_softirq+0x4c/0xb1
 [<c0105d9f>] do_softirq+0x41/0x48
 =======================
 [<c0105cd0>] do_IRQ+0x74/0x7e
 [<c010467e>] common_interrupt+0x1a/0x20
 [<c0102018>] default_idle+0x0/0x2f
 [<c02b007b>] xfrm_sk_policy_lookup+0x2cd/0x355
 [<c0102041>] default_idle+0x29/0x2f
 [<c01020a0>] cpu_idle+0x26/0x3b
Code: 53 08 89 44 0e 04 89 54 0e 08 f0 ff 0b 0f 94 c0 84 c0 74 0f 8b 43 14 e8 bf 5f a3 c7 89 d8 e8 15 fe ff ff 8b 47 04 8b 1f 8b 04 06 <8b> 48 38 f0 ff 48 48 0f 94 c2 84 d2 74 0d 85 c9 74 09 f0 0f ba 
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 

-- 
Norman Gaywood, Systems Administrator
School of Mathematics, Statistics and Computer Science
University of New England, Armidale, NSW 2351, Australia

norm@turing.une.edu.au            Phone: +61 (0)2 6773 2412
http://turing.une.edu.au/~norm    Fax:   +61 (0)2 6773 3312

Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
