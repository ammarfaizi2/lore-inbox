Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVBTO5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVBTO5z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVBTO4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:56:43 -0500
Received: from imo-m24.mx.aol.com ([64.12.137.5]:63144 "EHLO
	imo-m24.mx.aol.com") by vger.kernel.org with ESMTP id S261843AbVBTO4L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:56:11 -0500
From: AndyLiebman@aol.com
Message-ID: <195.393b1504.2f49ff04@aol.com>
Date: Sun, 20 Feb 2005 09:56:04 EST
Subject: Frequent Oops on Shutdown 2.6.10
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en
X-Mailer: 9.0 Security Edition for Windows sub 1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I compiled the 2.6.10 kernel with HyperThreading optimization (I'm  running a 
3.06 Ghz single Xeon processor with HT enabled). More or less, I'm  running 
Mandrake 10 Official, but with my own kernel. Can anybody help explain  why I'm 
getting this Oops on shutdown? It doesn't happen all the time -- about  50 
percent of the time. Never happens with the 2.6.6 kernel. I configured the  
2.6.10 kernel with mostly the same settings -- saying "no" to everything new,  
except optimizing for P4/Xeon processor, enabling HT optimization, and NOT  
enabling lots of "ham radio" and "ISDN" stuff that seemed to be enabled in the  
Mandrake kernel. 
 
Some relevant things about the machine: 
Single Xeon 3.06 processor
2 GB ECC RAM
2x 3ware 9500S-8 SATA RAID Cards
16 SATA drives
2 built-in GigE ports on motherboard
2 Intel 1000 MT Server Adapters on each of the two 133 Mhz  PCI-X slots
 
Here's the output from the Oops


*pde = 00000000
Oops:  0000 [#1]
SMP
Modules linked in: raid) appletalk xfs sd_mod sg sr_mod  3w_9xxx scsi_mod 
nfsd exportfs ipv6 af_packet raw ide_floppy ide_tape ide_cd  cdrom e1000 uhci_hcd 
usbcore rtc ext3 jbd
CPU: 1
EIP:  0060:[<c018b600>] Not tainted VLI
EFLAGS: 00010246  (2.6.10es-feb06)
EIP is at remove_proc_entry+0x2a/0x166
eax: 00000000 ebx:  f66a4e00 ecx: ffffffff edx: f6da1300
esi: f7cfb000 edi: 00000005 ebp:  c2183eb4 esp: c2183e94
ds: 007b es: 007b ss: 0068
Process swapper (pid: 0,  threadinfo=c2182000 task=c214e520)
Stack: c043402c c043402c 00000000 c2024980  00000005 f66a4e00 f7cfb000 
00000000 c2183ec8 f8c4f051 00000005 f6da1300 f66a4e00  c2183ee8 f8c2cc7b f66a4e00 
c2024980 00000002 00000000 f6da7e80 f6da6080 c2183f04  c0289967 f66a4e00
Call Trace: 
[<c0103352>]  show_stack+0xaf/0xb7
[<c01034d9>]  show_registers+0x15f/0x1d2
[<c01036dd>]  die+0xfa/0x180
[<c011365e>]  do_page_fault+0x464/0x646
[<c0102fbf>]  error_code+0x2b/0x30
[<f8c4f051>] snmp6_unregister_dev+0x41/0x57  [ipv6]
[<f8c2cc7b>] in6_dev_finish_destroy+0x35/0xb6  [ipv6]
[<c0289967>] dst_destroy+0xa2/0xcd
[<c028969a>]  dst_run_gc+0x72/0xfb
[<c0123584>]  run_timer_softirq+0xc4/0x185
[<c011f631>]  __do_softirq+0x65/0xd3
[<c011f6d0>]  do_softirq+0x31/0x33
[<c0102f18>]  apic_timer_interrupt+0x1c/0x24
[<c0100747>]  cpu_idle+0x31/0x3f
[<00000000>] 0x0
[<c2183fbc>]  0xc2183fbc
Code: e2 55 89 ef 83 ec 20 8b 55 0c 8b 4d 08 89 5d f4 85 d2 89 75  f8 89 7d 
fc 89 4d f0 0f 84 b0 00 00 00 8b 7d f0 31 c0 b9 ff ff ff ff <f2>  ae f7 d1 49 
8b 42 34 8d 5a 34 85 c0 89 ce 0f 84 84 00 00 00 
<0>Kernel  panic – not syncing: Fatal exception in interrupt
 
