Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136282AbREILjQ>; Wed, 9 May 2001 07:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136291AbREILjF>; Wed, 9 May 2001 07:39:05 -0400
Received: from smtp.mountain.net ([198.77.1.35]:1545 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S136282AbREILjB>;
	Wed, 9 May 2001 07:39:01 -0400
Message-ID: <3AF92C24.DD8F8660@mountain.net>
Date: Wed, 09 May 2001 07:38:12 -0400
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.3 i486)
X-Accept-Language: English/United, States, en-US, English/United, Kingdom, en-GB, English, en, French, fr, Spanish, es, Italian, it, German, de, , ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
In-Reply-To: <E14xPf0-0001pn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> 
> > IIRC this thread is about boot going catatonic right after unloading
> > __initmem.
> 
> Nope. Its about memory corruptions. Your bug sounds very different
> 
> > Earlier, it looks like handle_mm_fault is being triggered from
> > fast_clear_page.
> 
> That would be messy. The other way around is sane but not that way

Indeed, I was confused. Looks like ide-dma is getting goofy somehow.

Here is a decoded trace. Typos are likely. If the problem is not obvious to
anyone, I'll switch around my serial console setup to get some better info.

Warning (Oops_read): Code line not seen, dumping what data is available

Trace; ffff037f <END_OF_CODE+3fcfb2ab/????>
Trace; ffff0000 <END_OF_CODE+3fcfaf2c/????>
Trace; ffff0000 <END_OF_CODE+3fcfaf2c/????>
Trace; ffff0720 <END_OF_CODE+3fcfb64c/????>
Trace; c01b956a <ide_build_dmatable+2a/120>
Trace; c01b3fb5 <ide_set_handler+55/60>
Trace; c01b9aca <ide_dmaproc+11a/210>
Trace; c01b9380 <ide_dma_intr+0/b0>
Trace; c01b9940 <dma_timer_expiry+0/70>
Trace; c01bd457 <do_rw_disk+257/300>
Trace; c01b4d2a <ide_wait_stat+7a/e0>
Trace; c01b5010 <start_request+160/210>
Trace; c01b51ff <ide_do_request+10f/340>
Trace; c01b3430 <ali_cleanup+10/70>
Trace; c0132e45 <__wait_on_buffer+75/90>
Trace; c0134026 <bread+16/70>
Trace; c018665c <__make_request+43c/6f0>
Trace; c01866ce <__make_request+4ae/6f0>
Trace; c01866e6 <__make_request+4c6/6f0>
Trace; c018665c <__make_request+43c/6f0>
Trace; c01866ce <__make_request+4ae/6f0>
Trace; c01866e6 <__make_request+4c6/6f0>
Trace; c01b956a <ide_build_dmatable+2a/120>
Trace; c01b3fb5 <ide_set_handler+55/60>
Trace; c01b9aca <ide_dmaproc+11a/210>
Trace; c01b9380 <ide_dma_intr+0/b0>
Trace; c01b9940 <dma_timer_expiry+0/70>
Trace; c01bd457 <do_rw_disk+257/300>
Trace; c01b4d2a <ide_wait_stat+7a/e0>
Trace; c01b5010 <start_request+160/210>
Trace; c01b51ff <ide_do_request+10f/340>
Trace; c01b546e <do_ide_request+e/20>
Trace; c01134d0 <schedule+200/3e0>
Trace; c012bd2c <free_shortage+1c/c0>
Trace; c012cbd7 <__alloc_pages+87/300>
Trace; c022c12f <fast_copy_page+f/90>
Trace; c0125f4d <filemap_nopage+2bd/420>
Trace; c0125f58 <filemap_nopage+2c8/420>
Trace; c022c0ca <fast_clear_page+a/60>
Trace; c0122b7d <handle_mm_fault+cd/e0>
Trace; c012bd2c <free_shortage+1c/c0>
Trace; c0122a15 <do_no_page+45/e0>
Trace; c022c0ca <fast_clear_page+a/60>
Trace; c0222b7d <packet_ioctl+17d/350>
Trace; c0225476 <do_xprt_transmit+46/3d0>
Trace; c02254c3 <do_xprt_transmit+93/3d0>
Trace; c0112ba9 <do_page_fault+2a9/450>
Trace; c01239cf <do_munmap+5f/280>
Trace; c0112900 <do_page_fault+0/450>
Trace; c0106ddc <error_code+34/3c>
Trace; c022be20 <clear_user+30/40>
Trace; c0112900 <do_page_fault+0/450>
Trace; c0134026 <bread+16/70>
Trace; c018665c <__make_request+43c/6f0>
Trace; c01866ce <__make_request+4ae/6f0>
Trace; c01866e6 <__make_request+4c6/6f0>
Trace; c01b956a <ide_build_dmatable+2a/120>
Trace; c01b3fb5 <ide_set_handler+55/60>
Trace; c01b9aca <ide_dmaproc+11a/210>
Trace; c01b9380 <ide_dma_intr+0/b0>
Trace; c01b9940 <dma_timer_expiry+0/70>
Trace; c01bd457 <do_rw_disk+257/300>
Trace; c01b4d2a <ide_wait_stat+7a/e0>
Trace; c01b5010 <start_request+160/210>
Trace; c01b51ff <ide_do_request+10f/340>
Trace; c01b546e <do_ide_request+e/20>
Trace; c01134d0 <schedule+200/3e0>
Trace; c012be03 <inactive_shortage+33/90>
Trace; c0124d05 <__find_get_page+35/80>
Trace; c013ae1b <search_binary_handler+17b/190>
Trace; c0125d44 <filemap_nopage+b4/420>
Trace; c013af79 <do_execve+149/200>
Trace; c0122a15 <do_no_page+45/e0>
Trace; c012267d <vmtruncate+12d/160>
Trace; c0112ba9 <do_page_fault+2a9/450>
Trace; c022d075 <rwsem_down_write_failed+65/140>
Trace; c022f396 <stext_lock+37a/16bc>
Trace; c0106cbf <system_call+33/38>


1 warning issued.  Results may not be reliable.

Cheers,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
