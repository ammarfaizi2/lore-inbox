Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUHWOUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUHWOUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 10:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUHWOUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 10:20:44 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:9915 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S264530AbUHWOUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 10:20:36 -0400
Date: Mon, 23 Aug 2004 16:20:35 +0200
To: linux-kernel@vger.kernel.org, orinoco-devel@lists.sourceforge.net
Subject: kernel Oops and schedule while atomic in orinoco driver
Message-ID: <20040823142035.GA23967@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got a nice Ooops with orinoco drivers from cvs head and 2.4.8.1-mm4:
(orinoco driver is from yesterdays cvs)

Unable to handle kernel paging request at virtual address bfff8dbf
 printing eip:
c01b6cd5
*pde = 1c472067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: usbhid radeon irtty_sir sir_dev irda crc_ccitt eth1394 ehci_hcd ohci1394 ieee1394 yenta_socket pcmcia_core slamr sd_mod usb_storage uhci_hcd usbcore joydev acerhk intel_agp agpgart orinoco_pci orinoco hermes evdev
CPU:    0
EIP:    0060:[<c01b6cd5>]    Tainted: P   VLI
EFLAGS: 00010003   (2.6.8.1-mm4n) 
EIP is at memcpy+0x1d/0x3d
eax: 00000001   ebx: dd2e3eda   ecx: 00000001   edx: 00000006
esi: bfff8dbf   edi: dd2e3eda   ebp: 00000000   esp: dd2e3e7c
ds: 007b   es: 007b   ss: 0068
Process waproamd (pid: 2820, threadinfo=dd2e2000 task=defe6c70)
Stack: d51d8008 ffffbbbb d51d7ffc e087b2b9 c028490c 00000040 dd1e1380 00000800 
       dd2e3eb4 e99517b4 00000001 d51d7ffc d51d8000 d51d7ffc ffffbbbb bfff8db9 
       00000004 d66a31c0 00000000 df1dfa20 dd2e3f64 00000246 8b150034 106b0001 
Call Trace:
 [<e087b2b9>] orinoco_ioctl_getscan+0x242/0x602 [orinoco]
 [<c028490c>] sockfd_lookup+0x16/0x71
 [<c015f7ad>] do_select+0x1af/0x2ba
 [<c0295cee>] wireless_process_ioctl+0x1ea/0x68b
 [<e087b077>] orinoco_ioctl_getscan+0x0/0x602 [orinoco]
 [<c028c733>] dev_load+0x21/0x6d
 [<c028e227>] dev_ioctl+0x1ca/0x2a2
 [<c0285321>] sock_ioctl+0x25a/0x276
 [<c015ee40>] sys_ioctl+0xf1/0x229
 [<c011f6e2>] sys_time+0x16/0x50
 [<c0105f03>] syscall_call+0x7/0xb
Code: 50 fd 31 c0 c3 31 d2 b8 f2 ff ff ff c3 90 83 ec 0c 89 1c 24 89 74 24 04 89 7c 24 08 89 c3 89 d6 89 c8 c1 e8 02 89 ca 89 df 89 c1 <f3> a5 f6 c2 02 74 02 66 a5 f6 c2 01 74 01 a4 8b 7c 24 08 89 d8 
 <6>note: waproamd[2820] exited with preempt_count 1
bad: scheduling while atomic!
 [<c02dbe37>] schedule+0x4cb/0x4d0
 [<c01188cd>] try_to_wake_up+0x99/0xa1
 [<c01404cf>] unmap_page_range+0x3d/0x63
 [<c01406aa>] unmap_vmas+0x1b5/0x1c6
 [<c014445f>] exit_mmap+0x78/0x143
 [<c011a16b>] mmput+0x60/0xa3
 [<c011dfba>] do_exit+0x149/0x3fb
 [<c01070d6>] do_divide_error+0x0/0x10c
 [<c011775b>] do_page_fault+0x0/0x54f
 [<c011775b>] do_page_fault+0x0/0x54f
 [<c011795c>] do_page_fault+0x201/0x54f
 [<c01188cd>] try_to_wake_up+0x99/0xa1
 [<c0118eef>] __wake_up_common+0x33/0x56
 [<c011775b>] do_page_fault+0x0/0x54f
 [<c0106951>] error_code+0x2d/0x38
 [<c01b6cd5>] memcpy+0x1d/0x3d
 [<e087b2b9>] orinoco_ioctl_getscan+0x242/0x602 [orinoco]
 [<c028490c>] sockfd_lookup+0x16/0x71
 [<c015f7ad>] do_select+0x1af/0x2ba
 [<c0295cee>] wireless_process_ioctl+0x1ea/0x68b
 [<e087b077>] orinoco_ioctl_getscan+0x0/0x602 [orinoco]
 [<c028c733>] dev_load+0x21/0x6d
 [<c028e227>] dev_ioctl+0x1ca/0x2a2
 [<c0285321>] sock_ioctl+0x25a/0x276
 [<c015ee40>] sys_ioctl+0xf1/0x229
 [<c011f6e2>] sys_time+0x16/0x50
 [<c0105f03>] syscall_call+0x7/0xb


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GLOADBY MARWOOD (n.)
Someone who stops Jon Cleese on the street and demands that he does a
funny walk.
			--- Douglas Adams, The Meaning of Liff
