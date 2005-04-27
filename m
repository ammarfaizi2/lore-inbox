Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVD0Pzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVD0Pzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVD0Pzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:55:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47827 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261700AbVD0Pza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:55:30 -0400
Date: Wed, 27 Apr 2005 16:55:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jes Sorensen <jes@wildopensource.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: returning non-ram via ->nopage, was Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050427155526.GA25921@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Jes Sorensen <jes@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <16987.39773.267117.925489@jaguar.mkp.net> <20050412032747.51c0c514.akpm@osdl.org> <yq07jj8123j.fsf@jaguar.mkp.net> <20050413204335.GA17012@infradead.org> <yq08y3bys4e.fsf@jaguar.mkp.net> <20050424101615.GA22393@infradead.org> <yq03btftb9u.fsf@jaguar.mkp.net> <20050425144749.GA10093@infradead.org> <yq0ll75rxsl.fsf@jaguar.mkp.net> <426FB56B.5000006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426FB56B.5000006@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2005 at 11:53:15AM -0400, Jeff Garzik wrote:
> I don't see anything wrong with a ->nopage approach.
> 
> At Linus's suggestion, I used ->nopage in the implementation of 
> sound/oss/via82cxxx_audio.c.

The difference is that you return kernel memory (actually pci_alloc_consistant
memory that has it's own set of problems), while this is memory not in mem_map,
so he allocates some regularly kernel memory too to have a struct page and
just leaks it

