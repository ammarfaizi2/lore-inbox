Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVBQTny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVBQTny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVBQTny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:43:54 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:65210 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261189AbVBQTnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:43:40 -0500
Date: Thu, 17 Feb 2005 20:43:37 +0100
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] page table iterators
Message-ID: <20050217194336.GA8314@wotan.suse.de>
References: <4214A1EC.4070102@yahoo.com.au> <4214A437.8050900@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214A437.8050900@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 01:03:35AM +1100, Nick Piggin wrote:
> I am pretty surprised myself that I was able to consolidate
> all "page table range" functions into a single type of iterator
> (well, there are a couple of variations, but it's not too bad).

I started a similar project - but it uses the existing loops,
just using {pte,pmd,pud,pgd}_next. The idea is to optimize
page table walking by keeping some state in the struct page
of the page table page that says whether an entry is set 
or not. To make this work I switched everything to indexes
instead of pointers.

Main problem are some nasty include loops. 

-Andi
