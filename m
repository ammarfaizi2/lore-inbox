Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262620AbVDYOrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVDYOrx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVDYOrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:47:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31388 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262620AbVDYOrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:47:52 -0400
Date: Mon, 25 Apr 2005 15:47:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: returning non-ram via ->nopage, was Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050425144749.GA10093@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <16987.39773.267117.925489@jaguar.mkp.net> <20050412032747.51c0c514.akpm@osdl.org> <yq07jj8123j.fsf@jaguar.mkp.net> <20050413204335.GA17012@infradead.org> <yq08y3bys4e.fsf@jaguar.mkp.net> <20050424101615.GA22393@infradead.org> <yq03btftb9u.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq03btftb9u.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes has this shiny new IA64 uncached foo bar whizbang driver (see the patch
at http://marc.theaimsgroup.com/?l=linux-kernel&m=111416930927092&w=2),
which has a nopage routine that calls remap_pfn_range from ->nopage for
uncached memory that's not part of the mem map.  Because ->nopage wants
to return a struct page * he's allocating a normal kernel page and actually
returns that one - to get the page he wants into the pagetables his does
all the pagetable manipulation himself before (See the glory details of
pagetable walks and modification inside a driver in the patch above).

I don't think these hacks are acceptable for a driver, especially as the
problem can easily be solved by calling remap_pfn_range in ->mmap - except
SGI also wants node locality..
