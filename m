Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSJPLJz>; Wed, 16 Oct 2002 07:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJPLJy>; Wed, 16 Oct 2002 07:09:54 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:25511 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S262387AbSJPLJx>; Wed, 16 Oct 2002 07:09:53 -0400
Date: Wed, 16 Oct 2002 12:15:49 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Andrew Morton <akpm@digeo.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: oops (Re: 2.5.43-mm1)
In-Reply-To: <3DAD0F3D.39E5B5DC@digeo.com>
Message-ID: <Pine.LNX.4.44.0210161212520.11594-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Auth-User: mb
X-uvscan-result: clean (181m9V-0003Gj-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My SMP highmem Athlon did the following (further details on request):

kernel BUG at arch/i386/mm/highmem.c:40!
invalid operand: 0000
autofs4 usbtest ohci-hcd r128 agpgart 3c59x af_packet iptable_filter ip_tables floppy mousedev hid usbcore rtc unix
CPU:    1
EIP:    0060:[<c011ca7a>]    Not tainted
EFLAGS: 00010206
EIP is at kmap_atomic+0x4a/0x90
eax: c0004f34   ebx: fffcd000   ecx: c2117708   edx: 6d62d163
esi: 0000000f   edi: 0000004c   ebp: 00001000   esp: f5821ec8
ds: 0068   es: 0068   ss: 0068
Process crond (pid: 2353, threadinfo=f5820000 task=f7756040)
Stack: f5612400 00000000 c013cc8a c2117708 0000000f fffcd000 fffcb000 f74dd640
       c0455edc c2117708 f5612400 40413000 40014000 c013cecf c0455edc f5612400
       40013000 00001000 c0455edc 40013000 f5612404 40014000 c0455edc c013cf63
Call Trace:
 [<c013cc8a>] zap_pte_range+0xaa/0x240
 [<c013cecf>] zap_pmd_range+0xaf/0x100
 [<c013cf63>] unmap_page_range+0x43/0x70
 [<c0140b80>] unmap_region+0xf0/0x180
 [<c0140efc>] do_munmap+0x17c/0x210
 [<c0140fe9>] sys_munmap+0x59/0x80
 [<c0109773>] syscall_call+0x7/0xb

Code: 0f 0b 28 00 64 a4 30 c0 2b 0d 8c 31 48 c0 c1 f9 03 69 c9 cd
 <6>note: crond[2353] exited with preempt_count 4
Debug: sleeping function called from illegal context at include/linux/rwsem.h:44
Call Trace:
 [<c01244a0>] profile_exit_task+0x20/0x60
 [<c012817a>] do_exit+0x7a/0x320
 [<c0268156>] unblank_screen+0x26/0x100
 [<c010a930>] do_invalid_op+0x0/0x70
 [<c010a7c8>] die+0xe8/0xf0
 [<c010a997>] do_invalid_op+0x67/0x70
 [<c011ca7a>] kmap_atomic+0x4a/0x90
 [<c014d5cc>] buffered_rmqueue+0xcc/0x1e0
 [<c0149ebf>] cache_free_debugcheck+0x12f/0x1b0
 [<c0148f09>] __cache_free+0x39/0x80
 [<c010a1b5>] error_code+0x2d/0x38
 [<c011ca7a>] kmap_atomic+0x4a/0x90
 [<c013cc8a>] zap_pte_range+0xaa/0x240
 [<c013cecf>] zap_pmd_range+0xaf/0x100
 [<c013cf63>] unmap_page_range+0x43/0x70
 [<c0140b80>] unmap_region+0xf0/0x180
 [<c0140efc>] do_munmap+0x17c/0x210
 [<c0140fe9>] sys_munmap+0x59/0x80
 [<c0109773>] syscall_call+0x7/0xb


