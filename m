Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWE3HcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWE3HcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 03:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWE3HcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 03:32:20 -0400
Received: from eridanilinux.demon.co.uk ([62.49.18.88]:61861 "EHLO
	eridanilinux.demon.co.uk") by vger.kernel.org with ESMTP
	id S932173AbWE3HcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 03:32:19 -0400
Date: Tue, 30 May 2006 08:32:18 +0100 (BST)
From: Michael McConnell <soruk@eridani.co.uk>
X-X-Sender: soruk@zeskia.int.eridani.co.uk
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.16.18: PPA driver oopses with large memory model
Message-ID: <Pine.LNX.4.44.0605300828050.2126-100000@zeskia.int.eridani.co.uk>
Organization: Eridani Star System
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Tried to email the maintainer <campbell@torque.net> as listed in the top of 
drivers/scsi/ppa.c - but it bounced.  There's no entry in MAINTAINERS for 
this driver either.

Anyhow. Since upgrading the RAM in my machine to require CONFIG_HIMEM4G 
(using CONFIG_VMSPLIT_3G) the PPA driver oopses with the following oops when 
trying to write a file to the disc.  The disc is in ext2 format.

If there's any more info you folks need from my system, please shout. 
Additionally, please copy me in on replies since I'm not on the mailing list.

Thanks,

-- Michael

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f88e477a
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ppa
CPU:    0
EIP:    0060:[<f88e477a>]    Not tainted VLI
EFLAGS: 00010216   (2.6.16.18 #1) 
EIP is at ppa_in+0x13a/0x1b0 [ppa]
eax: 00000200   ebx: 00000378   ecx: 00000100   edx: 0000037c
esi: f672fb40   edi: 00000000   ebp: 00000378   esp: c1d23e8c
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c1d22000 task=c1cff030)
Stack: <0>f672fb40 c1cdfc00 c0151f4b 00000200 f645cb60 00000379 f672fb40 f88e4b99 
       f672fb40 00000000 00000200 00000378 00000001 ffff57fb c1bcda60 f672fb40 
       f645cb60 f672fb40 00000378 f88e4dd5 f645cb60 c1d23ef4 f69a18c0 c1cff030 
Call Trace:
 [<c0151f4b>] slab_destroy+0x3b/0xa0
 [<f88e4b99>] ppa_completion+0x129/0x220 [ppa]
 [<f88e4dd5>] ppa_engine+0x85/0x430 [ppa]
 [<c0379540>] schedule+0x310/0x600
 [<f88e4cb2>] ppa_interrupt+0x22/0xc0 [ppa]
 [<c0129282>] run_workqueue+0x62/0xd0
 [<f88e4c90>] ppa_interrupt+0x0/0xc0 [ppa]
 [<c0129448>] worker_thread+0x158/0x180
 [<c0116790>] default_wake_function+0x0/0x20
 [<c0116790>] default_wake_function+0x0/0x20
 [<c01292f0>] worker_thread+0x0/0x180
 [<c012c886>] kthread+0xb6/0xf0
 [<c012c7d0>] kthread+0x0/0xf0
 [<c0100fd5>] kernel_thread_helper+0x5/0x10
Code: eb 12 46 c7 04 24 e3 53 00 00 e8 22 07 92 c7 83 fe 63 7f 73 89 da ec a8 01 74 e7 89 f8 e9 55 ff ff ff 8b 4c 24 28 8d 55 04 d1 f9 <f3> 66 6d eb 91 0f b7 cb b8 25 00 00 00 8d 59 02 89 da ee 8b 44 

-- Michael "Soruk" McConnell
   Eridani Star System

   MailStripper - http://www.MailStripper.eu/ - SMTP spam filter
   Mail Me Anywhere - http://www.MailMeAnywhere.com/ - Mobile email

