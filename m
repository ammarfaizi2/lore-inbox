Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVLMVEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVLMVEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVLMVEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:04:53 -0500
Received: from [194.90.237.34] ([194.90.237.34]:47973 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1030221AbVLMVEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:04:52 -0500
Date: Tue, 13 Dec 2005 23:07:58 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051213210757.GC6715@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <439D417E.903@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439D417E.903@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting  Nick Piggin <nickpiggin@yahoo.com.au>:
> > 
> >>or try to do something tricky with page_count to determine
> >>if we need to do a copy in fork() rather than a COW.
> > 
> > 
> > I'm actually reasonably happy with the trick that I'm using:
> > performing a second get_user_pages after DMA and comparing
> > the page lists.
> > However, doing this every time on the off chance that a
> > page was made COW forces me into task context, every time.
> > 
> 
> I think it might be possible to solve it with the early-copy in
> fork(). I'll tinker with it.

A possible way to do this would be adding an option to get_user_pages,
and if selected, setting a flag on all pages in range.
This flag should be cleared in put_page when the reference count drops to 1.

The only thing left would be to do the actual copy if the flag is set.

HTH,

-- 
MST
