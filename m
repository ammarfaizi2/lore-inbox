Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261949AbUK3C3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261949AbUK3C3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUK3C3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:29:01 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:41173 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261949AbUK3C2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:28:45 -0500
Date: Tue, 30 Nov 2004 03:28:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: [2/7] Xen VMM patch set : return code for arch_free_page
Message-ID: <20041130022852.GM4365@dualathlon.random>
References: <E1CVHzW-0004XC-00@mta1.cl.cam.ac.uk> <E1CVI3j-0004Zq-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CVI3j-0004Zq-00@mta1.cl.cam.ac.uk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 11:20:54PM +0000, Ian Pratt wrote:
> 
> This patch adds a return value to the existing arch_free_page function
> that indicates whether the normal free routine still has work to
> do. The only architecture that currently uses arch_free_page is arch
> 'um'. arch xen needs this for 'foreign pages' - pages that don't
> belong to the page allocator but are instead managed by custom
> allocators. Such pages are marked using PG_arch_1.

This sure looks good too.

> @@ -508,7 +509,8 @@ static void fastcall free_hot_cold_page(
>  	struct per_cpu_pages *pcp;
>  	unsigned long flags;
>  
> -	arch_free_page(page, 0);
> +	if (arch_free_page(page, 0))
> +		return;

If you want you can microoptimize the guest placing zone =
page_zone(page) after arch_free_page. Just a side note (it cannot be
measurable anyways).
