Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162998AbWLBNMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162998AbWLBNMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 08:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162999AbWLBNMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 08:12:30 -0500
Received: from mailfe10.swipnet.se ([212.247.155.33]:2530 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1162998AbWLBNM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 08:12:29 -0500
X-T2-Posting-ID: QNQmBGb/vtbMR2qCRwCDCQ==
X-Cloudmark-Score: 0.000000 []
From: Trond Gribbestad Lund <grev-ond@c2i.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel Oops in 2.6.19
Date: Sat, 2 Dec 2006 14:13:14 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021413.14770.grev-ond@c2i.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's the output:

BUG: unable to handle kernel paging request at virtual address ff7d968c
 printing eip:
c014dda9
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: nvidia(P) snd_pcm_oss snd_mixer_oss
CPU:    1
EIP:    0060:[<c014dda9>]    Tainted: P      VLI
EFLAGS: 00210286   (2.6.19 #1)
EIP is at do_no_page+0x5a/0x310
eax: ff7d9600   ebx: 00000000   ecx: f6df8000   edx: f75a61d0
esi: f7920b68   edi: b6b981e5   ebp: 00000000   esp: f6df9ef4
ds: 007b   es: 007b   ss: 0068
Process ksplash (pid: 860, ti=f6df8000 task=c1af8560 task.ti=f6df8000)
Stack: f5500e60 00000007 f6df9f14 00000004 f6df8000 00000000 00000000 00000000
       00000002 00000000 f7920b68 b6b981e5 f5500e60 c014e2ed f7a9a740 f75a61d0
       b6b981e5 f5500e60 f7920b68 00000000 b6b981e5 00000000 f7a9a774 00000004
Call Trace:
 [<c014e2ed>] __handle_mm_fault+0xfe/0x299
 [<c0114a01>] do_page_fault+0x26c/0x579
 [<c0159289>] sys_open+0x27/0x2b
 [<c0114795>] do_page_fault+0x0/0x579
 [<c03b2ca1>] error_code+0x39/0x40
 [<c03b007b>] packet_notifier+0x45/0x150
 =======================
Code: 00 c7 44 24 04 07 00 00 00 e8 05 79 fc ff 8b 44 24 3c f6 40 15 04 74 08 
0f 0b 6d 08 9f 1a 3e c0 8b 54 24 3c 8b 42 48 85 c0 74 17 <8b> 80 8c 00 00 00 
89 44 24 1c 8b 48 34 89 4c 24 18 0f ae e8 8d
EIP: [<c014dda9>] do_no_page+0x5a/0x310 SS:ESP 0068:f6df9ef4
 <1>BUG: unable to handle kernel paging request at virtual address ff7d968c
 printing eip:
c014f0ee
*pde = 00000000
Oops: 0000 [#2]
PREEMPT SMP
Modules linked in: nvidia(P) snd_pcm_oss snd_mixer_oss
CPU:    1
EIP:    0060:[<c014f0ee>]    Tainted: P      VLI
EFLAGS: 00210286   (2.6.19 #1)
EIP is at unlink_file_vma+0x12/0x48
eax: f78a71f4   ebx: f75a61d0   ecx: f78a71f4   edx: f78a71f4
esi: f71b4224   edi: ff7d9600   ebp: f75a61d0   esp: f6df9d70
ds: 007b   es: 007b   ss: 0068
Process ksplash (pid: 860, ti=f6df8000 task=c1af8560 task.ti=f6df8000)
Stack: f78a71d0 f79ead6c f79ead50 f75a61d0 f71b4224 b60e7000 00000000 c014bd43
       f75a61d0 08048000 08079000 00000000 b60e7000 f6df9dd0 f5590e48 f7a9a740
       00000001 c0150edc f6df9dd0 f5590e48 00000000 00000000 f6df9dd4 00000000
Call Trace:
 [<c014bd43>] free_pgtables+0x53/0xa4
 [<c0150edc>] exit_mmap+0xbe/0x140
 [<c011d353>] mmput+0x24/0x6f
 [<c01222df>] do_exit+0x1a7/0x413
 [<c0120176>] printk+0x16/0x19
 [<c0104015>] die+0x1f8/0x200
 [<c0114c1a>] do_page_fault+0x485/0x579
 [<c0161c40>] do_path_lookup+0x18f/0x1ab
 [<c0140faf>] find_get_page+0x41/0x48
 [<c0114795>] do_page_fault+0x0/0x579
 [<c03b2ca1>] error_code+0x39/0x40
 [<c014dda9>] do_no_page+0x5a/0x310
 [<c014e2ed>] __handle_mm_fault+0xfe/0x299
 [<c0114a01>] do_page_fault+0x26c/0x579
 [<c0159289>] sys_open+0x27/0x2b
 [<c0114795>] do_page_fault+0x0/0x579
 [<c03b2ca1>] error_code+0x39/0x40
 [<c03b007b>] packet_notifier+0x45/0x150
 =======================
Code: 89 40 04 89 43 24 5b c3 8d 42 1c 89 5c 24 08 89 44 24 0c 5b e9 0c af ff 
ff 55 57 56 53 83 ec 0c 8b 6c 24 20 8b 7d 48 85 ff 74 2e <8b> 9f 8c 00 00 00 
8d 73 2c 89 f0 e8 5c 36 26 00 89 5c 24 08 89
EIP: [<c014f0ee>] unlink_file_vma+0x12/0x48 SS:ESP 0068:f6df9d70
 <1>Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: ksplash/0x00000001/860
 [<c03b0de9>] __sched_text_start+0x51/0x653
 [<c014f102>] unlink_file_vma+0x26/0x48
 [<c0120176>] printk+0x16/0x19
 [<c0122219>] do_exit+0xe1/0x413
 [<c0120176>] printk+0x16/0x19
 [<c0104015>] die+0x1f8/0x200
 [<c0114c1a>] do_page_fault+0x485/0x579
 [<c01528ad>] page_remove_rmap+0x8e/0x92
 [<c0114795>] do_page_fault+0x0/0x579
 [<c03b2ca1>] error_code+0x39/0x40
 [<c014f0ee>] unlink_file_vma+0x12/0x48
 [<c014bd43>] free_pgtables+0x53/0xa4
 [<c0150edc>] exit_mmap+0xbe/0x140
 [<c011d353>] mmput+0x24/0x6f
 [<c01222df>] do_exit+0x1a7/0x413
 [<c0120176>] printk+0x16/0x19
 [<c0104015>] die+0x1f8/0x200
 [<c0114c1a>] do_page_fault+0x485/0x579
 [<c0161c40>] do_path_lookup+0x18f/0x1ab
 [<c0140faf>] find_get_page+0x41/0x48
 [<c0114795>] do_page_fault+0x0/0x579
 [<c03b2ca1>] error_code+0x39/0x40
 [<c014dda9>] do_no_page+0x5a/0x310
 [<c014e2ed>] __handle_mm_fault+0xfe/0x299
 [<c0114a01>] do_page_fault+0x26c/0x579
 [<c0159289>] sys_open+0x27/0x2b
 [<c0114795>] do_page_fault+0x0/0x579
 [<c03b2ca1>] error_code+0x39/0x40
 [<c03b007b>] packet_notifier+0x45/0x150
 =======================
