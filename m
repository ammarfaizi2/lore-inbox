Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTEGTeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbTEGTeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:34:06 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17592 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264257AbTEGTc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:32:28 -0400
Date: Wed, 7 May 2003 21:45:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
Message-ID: <20030507194501.GA3166@wohnheim.fh-wedel.de>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de> <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de> <20030507143315.GA6879@stargate.galaxy> <20030507144736.GE8978@holomorphy.com> <20030507164901.GB19324@wohnheim.fh-wedel.de> <Pine.LNX.4.50.0305071009050.2208-100000@blue1.dev.mcafeelabs.com> <20030507174027.GD19324@wohnheim.fh-wedel.de> <Pine.LNX.4.50.0305071107590.2208-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.50.0305071107590.2208-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003 11:35:25 -0700, Davide Libenzi wrote:
> 
> It was not really clear you were talking about interrupts stack, that are
> a feasible thing. Even though, I'd not feel confident going down to 4k,
> looking at the post that started this thread.

Neither would I - yet. And the single functions are just part of the
problem, the lowest hanging fruits maybe. In the next step, we have to
find cases like the below and fix them. 4608 bytes should still be ok,
especially since the interrupt stuff is still on the per-process
stack. 

The real bitch is that those cases depend on your .config and your
hardware, so finding them will take quite some time and cannot be done
by a couple of developers alone. Damn!

do_IRQ: stack overflow: 4608
de9b57a0 00001200 00000000 c14b2d4c c0289250 db6a1560 db6924e4 c010b298 
c14b2d4c c14b2d4c 00000000 c0289250 db6a1560 db6924e4 00000000 00000018 
00000018 ffffff00 c0134f3b 00000010 00000296 de9b5800 0000000c 1b564045 
Call Trace:    [call_do_IRQ+5/13] [try_to_swap_out+187/400]
[swap_out_pmd+260/288] [swap_out_mm+248/336] [swap_out+91/224]
[shrink_cache+317/784] [shrink_caches+99/160]
[call_console_drivers+101/288] [try_to_free_pages_zone+54/80]
[balance_classzone+87/496] [__alloc_pages+243/400]
[find_or_create_page+114/240] [grow_dev_page+46/208]
[grow_buffers+152/256] [getblk+70/112] [bread+32/144]
[ext3_get_branch+111/240] [ext3_get_block_handle+120/704]
[schedule_task+91/112] [create_buffers+107/224]
[ext3_get_block+74/144] [block_read_full_page+585/656]
[__alloc_pages+181/400] [__alloc_pages+297/400]
[page_cache_read+171/208] [ext3_get_block+0/144]
[read_cluster_nonblocking+57/80] [filemap_nopage+285/560]
[do_no_page+121/448] [ext3_read_inode+425/720]
[handle_mm_fault+119/272] [do_page_fault+364/1277]
[rb_insert_color+210/240] [do_page_fault+0/1277] [error_code+52/60]
[clear_user+51/80] [load_elf_interp+338/784] [do_page_fault+0/1277]
[error_code+52/60] [clear_user+51/80] [padzero+40/48]
[load_elf_binary+1356/2960] [ext3_dirty_inode+137/256]
[load_elf_binary+0/2960] [search_binary_handler+258/384]
[do_execve+379/544] [sys_execve+80/128] 

Jörn

-- 
"Translations are and will always be problematic. They inflict violence 
upon two languages." (translation from German)
