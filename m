Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVALXvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVALXvC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVALXuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:50:46 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:46935 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261596AbVALXuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:50:17 -0500
Message-ID: <41E5B7AD.40304@yahoo.com.au>
Date: Thu, 13 Jan 2005 10:50:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: clameter@sgi.com, torvalds@osdl.org, ak@muc.de, hugh@veritas.com,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com>	<Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com>	<m1652ddljp.fsf@muc.de>	<Pine.LNX.4.58.0501110937450.32744@schroedinger.engr.sgi.com>	<41E4BCBE.2010001@yahoo.com.au>	<20050112014235.7095dcf4.akpm@osdl.org>	<Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>	<20050112104326.69b99298.akpm@osdl.org>	<41E5AFE6.6000509@yahoo.com.au> <20050112153033.6e2e4c6e.akpm@osdl.org>
In-Reply-To: <20050112153033.6e2e4c6e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>So my patches cost about 7% in lmbench fork benchmark.
> 
> 
> OK, well that's the sort of thing we need to understand fully.  What sort
> of CPU was that on?
> 

That was on a P4, although I've seen pretty similar results on ia64 and
other x86 CPUs.

Note that this was with my ptl removal patches. I can't see why Christoph's
would have _any_ extra overhead as they are, but it looks to me like they're
lacking in atomic ops. So I'd expect something similar for Christoph's when
they're properly atomic.

> Look, -7% on a 2-way versus +700% on a many-way might well be a tradeoff we
> agree to take.  But we need to fully understand all the costs and benefits.
> 

I think copy_page_range is the one to keep an eye on.

