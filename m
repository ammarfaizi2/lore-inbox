Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVLCTKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVLCTKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 14:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVLCTKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 14:10:43 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:55269 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932146AbVLCTKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 14:10:43 -0500
Message-ID: <4391ED8D.1040104@colorfullife.com>
Date: Sat, 03 Dec 2005 20:10:05 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Alok Kataria <alokk@calsoftinc.com>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [RFC] Use compound pages for higher order slab allocations.
References: <Pine.LNX.4.62.0511301334450.20244@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0511301334450.20244@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>+static inline struct page *virt_to_compound_page(const void *addr)
>+{
>+	struct page * page = virt_to_page(addr);
>+
>+	if (PageCompound(page))
>+        	page = (struct page *)page_private(page);
>+
>  
>
This would end up in every kmem_cache_free/kfree call. Is it really 
worth the effort, are the high order allocation a problem?
I'm against such a change without a clear proof that just using high 
order allocations is not possible.

--
    Manfred
