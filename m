Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUJDMMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUJDMMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUJDMMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:12:43 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:60902 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268072AbUJDMMd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:12:33 -0400
Date: Mon, 4 Oct 2004 08:12:32 -0400 (EDT)
From: William Knop <wknop@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: libata badness
Message-ID: <Pine.LNX.4.60-041.0410040656001.2350@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm running a raid5 array atop a few sata drives via a promise tx4 
controller. The kernel is the official fedora lk 2.6.8-1, although I had 
run a few different kernels (never entirely successfully) with this array 
in the past.

In fact, this past weekend, I was getting oopses and panics (on lk 
2.6.8.1, 2.6.9-rc3, 2.6.9-rc3-mm1, and 2.6.9-rc3 w/ Jeff Garzik's recent 
libata patches) all of which happened when rebuilding a spare drive in the 
array. Unfortunately, somehow my root filesystem (ext3) got blown away-- 
it was on a reliable scsi drive (no bad blocks; I checked afterwards), and 
an adaptec aic7xxx host. The ram was good; I ran memtest86 on it. I'm 
assuming this was caused by some major kernel corruption, originating from 
libata.

I have since rebuilt my computer using an AMD Sempron (basically a Duron) 
rather than a P4. Other than that (cpu + m/b), it's the same hardware.

The errors I got over the weekend are similar to the one I just captured 
on my fresh fc2/lk2.6.8-1 install (at the same point; the spare disk had 
begun rebuilding). It's attached below.

Anyway, I haven't been able to find any other reports of this, so I'm at a 
loss about what to do. I hesitate to bring my array up at all now, for 
fear of blowing it away. Any assistance would be greatly appriciated.

Thanks much,
Will


---------- SNIP ----------
Unable to handle kernel paging request at virtual address 01000004
  printing eip:
229e4d8c
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: raid5 xor sata_promise md5 ipv6 parport_pc lp parport 
autofs4 sunrpc sk98lin sg joydev dm_mod uhci_hcd ehci_hcd button battery 
asus_acpi ac ext3 jbd sata_via libata aic7xxx sd_mod scsi_mod
CPU:    0
EIP:    0060:[<229e4d8c>]    Not tainted
EFLAGS: 00010206   (2.6.8-1.521)
EIP is at handle_stripe+0x29a/0x1407 [raid5]
eax: 00000001   ebx: 00000000   ecx: 00915cb8   edx: 21f7e1c0
esi: 1ccbd118   edi: 21f7e1c0   ebp: 01000000   esp: 1d300f28
ds: 007b   es: 007b   ss: 0068
Process md0_raid5 (pid: 2626, threadinfo=1d300000 task=1d317970)
Stack: 2283eb57 20db8000 21f7e1c0 21c30288 1ccbd204 20db8000 00000001 
1ccbd158
        00000002 00000000 00000000 00000001 00000000 00000000 00000001 
00000000
        00000001 00000001 00000000 00000003 1ccbd0ac 21f7e1c0 1ccbd0ac 
21f76c00
Call Trace:
  [<2283eb57>] ata_scsi_queuecmd+0xbe/0xc7 [libata]
  [<229e6b1c>] raid5d+0x1ce/0x2f8 [raid5]
  [<0228f5d2>] md_thread+0x227/0x256
  [<0211be05>] autoremove_wake_function+0x0/0x2d
  [<0211be05>] autoremove_wake_function+0x0/0x2d
  [<0228f3ab>] md_thread+0x0/0x256
  [<021041d9>] kernel_thread_helper+0x5/0xb
Code: 8b 55 04 83 c1 08 8b 45 00 83 d3 00 39 da 72 0e 0f 87 e0 01
---------- SNIP ----------

