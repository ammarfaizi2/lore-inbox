Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUCXT5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUCXT5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:57:48 -0500
Received: from hera.kernel.org ([63.209.29.2]:6800 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263161AbUCXT5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:57:45 -0500
Date: Wed, 24 Mar 2004 17:58:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 SMP - BUG at page_alloc.c:105
Message-ID: <20040324205811.GB6572@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The backtrace is odd to me. 

set_page_dirty() does not call __free_pages_ok() directly or indirectly.

How can it be?

---

Hi,

I found this in the logs of a Dual Athlon MP machine (Tyan board)
running 2.4.25-SMP:

kernel BUG at page_alloc.c:105! 
invalid operand: 0000 
CPU:    0 
EIP: 0010:[__free_pages_ok+80/704]    Not tainted 
EFLAGS: 00010286 
eax: c0333674   ebx: c1b2d720   ecx: 00000000   edx: f22f7a84 
esi: 00000001   edi: 00000000   ebp: 00000001   esp: f6901e3c 
ds: 0018   es: 0018   ss: 0018 
Process svscan (pid: 1348, stackpage=f6901000) 
Stack: c033364c f741cbc0 f22f7a84 00000001 0804c000 c0133ea6 f22f79c0 00000004  
       00000001 00000001 0804c000 00000001 c01308fa c1b2d720 f68e3080 0804b000  
       00001000 0844b000 c03ac4e0 00000001 0804c000 f68e3084 f42baa40 f7212440  
Call Trace: [set_page_dirty+166/176] [zap_page_range+330/400] [exit_mmap+221/352] \
[mmput+88/176] [do_exit+259/800]   [sig_exit+195/208] [dequeue_signal+95/192] \
[do_signal+448/694] [schedule_timeout+94/176] [process_timeout+0/96] \
[sys_nanosleep+232/448]   [do_page_fault+0/1347] [signal_return+20/24] 

Other than this BUG (that took down the machine hard, I was lucky to log
across the network), there appear to be no relevant logs shortly before
this crash.


