Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272279AbTG3Wq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272286AbTG3Wq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:46:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:2498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272279AbTG3WqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:46:22 -0400
Date: Wed, 30 Jul 2003 15:34:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mremap sleeping in incorrect context
Message-Id: <20030730153439.7df44a69.akpm@osdl.org>
In-Reply-To: <1059586337.2420.44.camel@gaston>
References: <1059586337.2420.44.camel@gaston>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Just had that in my log, running 2.6.0-test2. I'm not familiar
> with this code, but Arjan says this is an old problem that was
> fixed ages ago, maybe the fix was lost ?
> 
> Debug: sleeping function called from invalid context at
> mm/page_alloc.c:545
> Call trace:
>  [c000c1a8] dump_stack+0x18/0x28
>  [c0021044] __might_sleep+0x6c/0x84
>  [c004e33c] __alloc_pages+0x338/0x33c
>  [c0014940] pte_alloc_one+0x24/0x160
>  [c005c224] pte_alloc_map+0x88/0x2a8
>  [c0065a40] move_one_page+0xd0/0x2a4
>  [c0065c6c] move_page_tables+0x58/0xb8
>  [c0065d60] move_vma+0x94/0x824
>  [c00666f4] do_mremap+0x204/0x468
>  [c00669d4] sys_mremap+0x7c/0xcc

oops.  What are your CONFIG_HIGHMEM and CONFIG_HIGHPTE settings there?
