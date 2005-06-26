Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVFZXui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVFZXui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVFZXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:50:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261669AbVFZXuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:50:13 -0400
Date: Sun, 26 Jun 2005 16:49:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, bcrl@kvack.org
Subject: Re: increased translation cache footprint in v2.6
Message-Id: <20050626164939.2f457bf6.akpm@osdl.org>
In-Reply-To: <20050626172334.GA5786@logos.cnet>
References: <20050626172334.GA5786@logos.cnet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> As can be seen the number of entries is more than twice (dominated by kernel addresses).

But doesn't this:

I-TLB userspace misses: 142369  I-TLB userspace misses: 2179    ITLB u: 139190
I-TLB kernel misses: 118288    	I-TLB kernel misses: 1369	ITLB k: 116319
D-TLB userspace misses: 222916 	D-TLB userspace misses: 180249	DTLB u: 38667
D-TLB kernel misses: 207773    	D-TLB kernel misses: 167236	DTLB k: 38273

mean that we're mainly missing on data accesses?

>  Sorry, I've got no list of functions for these addresses, but it was pretty obvious at the time 
>  looking at the sys_read() codepath and respective virtual addresses.
> 
>  Manual reorganization of the functions sounded too messy, although BenL mentions something about
>  fget_light() can and should be optimized.

The workload you're using also does write(), and the write() paths got
significantly deeper.

Stack misses, perhaps.  But a tlb entry caches the translation for a single
page, yes?
