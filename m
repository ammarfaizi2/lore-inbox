Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264749AbUFGPIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264749AbUFGPIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUFGPIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:08:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:44424 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264749AbUFGPI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:08:26 -0400
Subject: Re: [PATCH] (urgent) ppc32: Fix CPUs with soft loaded TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <40C4186C.8000700@intracom.gr>
References: <1086556255.1859.14.camel@gaston>
	 <Pine.LNX.4.58.0406061418450.1730@ppc970.osdl.org>
	 <1086558161.10538.24.camel@gaston>  <40C4186C.8000700@intracom.gr>
Content-Type: text/plain
Message-Id: <1086620737.10517.50.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 10:05:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi
> 
> Unfortunately this is not enough for me on 8xx.
> 
> When starting init it bombs with
>
> .../...
>
> In order to fix this I now have to remove update_mmu_cache  by defining 
> it empty.

Looks bogus. Please, instead of random band-aids, try to analyse the
problem a bit deeper, that would help. SW TLB load works on 603 now,
so there must be something wrong in the low level 8xx related code.

do_no_page should have inserted/fixed a PTE, so the cache flush in
update_mmu_cache should work. If not, then something went wrong,
but then, please at least have a look at what PTE was inserted and
why it would be faulting that way, stop randomly playing with
update_mmu_cache.

Ben.


