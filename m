Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTKSHIH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 02:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTKSHIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 02:08:07 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:44673 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263873AbTKSHIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 02:08:02 -0500
Date: Wed, 19 Nov 2003 08:08:01 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org
Subject: Loop Device lockup with 2.4.23-pre7 ...
Message-ID: <20031119070801.GA29018@MAIL.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


complete lockup after doing ...

    dd if=/dev/zero of=x.dat bs=1k

on a mounted 256MB loop device, ext2 format ...


__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x30/0)
__alloc_pages: 0-order allocation failed (gfp=0xf0/0)
__alloc_pages: 0-order allocation failed (gfp=0x30/0)
...

ksymoops 2.4.9 on i686 2.4.23-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre7/ (default)
     -m /boot/System.map-2.4.23-pre7 (default)

Pid: 32489, comm:                loop0
EIP: 0010:[<c0136ea5>] CPU: 1 EFLAGS: 00000286    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 01000000 EBX: c16b9030 ECX: c16b9030 EDX: 00000000
ESI: c16b9030 EDI: 00000020 EBP: c55ebd10 DS: 0018 ES: 0018
Warning (Oops_set_regs): garbage 'DS: 0018 ES: 0018' at end of register line ignored
CR0: 8005003b CR2: 90232fe0 CR3: 1834d000 CR4: 000006d0
Call Trace:    [<c0136a0e>] [<c0136a90>] [<c0136b6f>] [<c014097a>] [<c0140d81>]
  [<c0140d8d>] [<c0141048>] [<c0124902>] [<c017db78>] [<c017de98>] [<c0136838>]
  [<c0141845>] [<c01379a8>] [<c0142184>] [<c017de10>] [<c012ece4>] [<f8822310>]
  [<c017de10>] [<f8822694>] [<f8822ca2>] [<c0108e76>] [<f8822bb0>] [<c0107476>]
  [<f8822bb0>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c0136ea5 <.text.lock.vmscan+5d/a8>   <=====

>>EBX; c16b9030 <_end+136950c/384d24dc>
>>ECX; c16b9030 <_end+136950c/384d24dc>
>>ESI; c16b9030 <_end+136950c/384d24dc>
>>EBP; c55ebd10 <_end+529c1ec/384d24dc>

Trace; c0136a0e <shrink_caches+3e/50>
Trace; c0136a90 <try_to_free_pages_zone+70/100>
Trace; c0136b6f <try_to_free_pages+4f/80>
Trace; c014097a <free_more_memory+1a/40>
Trace; c0140d81 <getblk+41/50>
Trace; c0140d8d <getblk+4d/50>
Trace; c0141048 <bread+18/80>
Trace; c0124902 <update_process_times+22/a0>
Trace; c017db78 <ext2_get_branch+58/d0>
Trace; c017de98 <ext2_get_block+88/470>
Trace; c0136838 <shrink_cache+3d8/410>
Trace; c0141845 <__block_prepare_write+e5/2e0>
Trace; c01379a8 <__alloc_pages+198/2a0>
Trace; c0142184 <block_prepare_write+24/80>
Trace; c017de10 <ext2_get_block+0/470>
Trace; c012ece4 <find_or_create_page+114/130>
Trace; f8822310 <[loop]lo_send+120/290>
Trace; c017de10 <ext2_get_block+0/470>
Trace; f8822694 <[loop]do_bh_filebacked+54/90>
Trace; f8822ca2 <[loop]loop_thread+f2/210>
Trace; c0108e76 <ret_from_fork+6/20>
Trace; f8822bb0 <[loop]loop_thread+0/210>
Trace; c0107476 <arch_kernel_thread+26/40>
Trace; f8822bb0 <[loop]loop_thread+0/210>


