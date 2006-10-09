Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWJIVGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWJIVGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 17:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWJIVGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 17:06:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:50633 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964862AbWJIVGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 17:06:39 -0400
Subject: Re: User switchable HW mappings & cie
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@tungstengraphics.com>,
       linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <Pine.LNX.4.64.0610091151380.3952@g5.osdl.org>
References: <1160347065.5926.52.camel@localhost.localdomain>
	 <452A35FF.50009@tungstengraphics.com>
	 <Pine.LNX.4.64.0610091151380.3952@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 07:06:23 +1000
Message-Id: <1160427983.7752.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway, so right now you can use "vm_insert_page()" and it will increment 
> the page count and add things to the rmap lists, which is what current 
> users want. But if you don't have a normal page, you should be able to 
> basically avoid that part entirely, and just use
> 
> 	set_pte_at(mm, addr, pte, make-up-a-pte-here);
> 
> and you're done (of course, you need to use all the appropriate magic to 
> set up the pte, ie you'd normally have something like
> 
> 	pte = get_locked_pte(mm, addr, &ptl);
> 	..
> 	pte_unmap_unlock(pte, ptl);
> 
> around it). Note that "vm_insert_page()" is _not_ for VM_PFNMAP mappings, 
> exactly because it does actually increment page counts. It's for a 
> "normal" mapping that just wants to insert a reference-counted page.

Yes, that's why we want a vm_insert_pfn() as I really don't want to see
PTE manipulations proliferate in drivers :) Nick is coming up with an
implementation faster than I can think about the code anyway ;)

Cheers,
Ben.


