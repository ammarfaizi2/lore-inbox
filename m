Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVCHFpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVCHFpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCHFoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:44:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:5829 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261271AbVCHFn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:43:29 -0500
Date: Tue, 8 Mar 2005 05:43:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] unified device list allocator
Message-ID: <20050308054325.GA1262@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050308051818.GI3120@waste.org> <20050307213302.560de053.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307213302.560de053.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:33:02PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > +	/* search for insertion point in reverse for dynamic allocation */
> >  +	list_for_each_prev(l, list) {
> 
> hrmph.  Any time we do anything in O(n) time, some smarty comes along with
> a workload which blows us out of the water.  Although it's hard to think of
> any register_blkdev()-intensive workloads.
> 
> It's not possible to do this with prio-trees?

Andrew, I think in this particular case you suffer of a sporadic severe
condition of overengineeritis.

register_blkdev only happens at module_init time (and in fact should go
away completely, so I'm not happy wit hthe surgey to keep it barely alive
at all)

