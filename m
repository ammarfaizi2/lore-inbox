Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264650AbUEOG3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbUEOG3T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 02:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUEOG3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 02:29:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:22919 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264650AbUEOG3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 02:29:17 -0400
Date: Fri, 14 May 2004 23:28:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 is crashing repeatedly
Message-Id: <20040514232842.63fd3240.akpm@osdl.org>
In-Reply-To: <20040515062258.7048.qmail@science.horizon.com>
References: <20040515062258.7048.qmail@science.horizon.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:
>
>  I have now captured a kernel crash.  Everything after iput in the second crash
>  was hand-coped, and may suffer from transcription errors, but it was done
>  quite carefully.
> 
>  System has ECC memory and has been very stable, with uptimes in excess of
>  1 year when kernel upgrades were infrequent (2.5 development).
> 
>  Stock 2.6.6 kernel, config as posted before.
> 
>  Unable to handle kernel NULL pointer dereference at virtual address 00000004
>   printing eip:
>  c012a392
>  *pde = 00000000
>  Oops: 0002 [#1]
>  CPU:    0
>  EIP:    0060:[<c012a392>]    Not tainted
>  EFLAGS: 00010012   (2.6.6) 
>  EIP is at free_block+0x52/0xd0
>  eax: 00000000   ebx: e9a3f000   ecx: e9a3f200   edx: df654000
>  esi: f7f8a560   edi: 00000016   ebp: f7f8a56c   esp: f7d89dec
>  ds: 007b   es: 007b   ss: 0068
>  Process kswapd0 (pid: 8, threadinfo=f7d88000 task=f7d8eb50)
>  Stack: f7f8a57c 0000001b c17fd784 c17fd784 f7f8a560 dc3cdac0 0000001b c012a449 
>         f7fe73dc c17fd774 c17fd774 00000296 dc3cdac0 c037a304 c012a61a dc3cdb40 
>         f7d89e5c 0000003d c014f385 dc3cdb40 c014f5c3 dc19c0c8 dc19c0c0 00000080 
>  Call Trace:
>   [<c012a449>] cache_flusharray+0x39/0xc0
>   [<c012a61a>] kmem_cache_free+0x3a/0x50
>   [<c014f385>] destroy_inode+0x35/0x40
>   [<c014f5c3>] dispose_list+0x43/0x70
>   [<c014f87e>] prune_icache+0xae/0x1b0
>   [<c014f995>] shrink_icache_memory+0x15/0x20

Drat, random memory corruption.

Can you enable CONFIG_SLAB_DEBUG?  And CONFIG_DEBUG_PAGEALLOC too, although
beware that the latter is a bit costly in terms of CPU cycles and memory
usage.

