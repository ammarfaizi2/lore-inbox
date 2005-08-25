Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVHYSgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVHYSgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVHYSgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:36:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60296 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932340AbVHYSgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:36:54 -0400
Date: Thu, 25 Aug 2005 19:36:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to atomic_t
Message-ID: <20050825183642.GA20132@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	Eric Dumazet <dada1@cosmosbay.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org> <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org> <430DA052.9070908@cosmosbay.com> <1124968309.5856.9.camel@npiggin-nld.site> <430DB8FA.4080009@cosmosbay.com> <430DDAF2.6030601@yahoo.com.au> <430DE001.8060604@cosmosbay.com> <20050825181935.GA4738@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825181935.GA4738@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 11:49:35PM +0530, Dipankar Sarma wrote:
> On Thu, Aug 25, 2005 at 05:13:05PM +0200, Eric Dumazet wrote:
> > Nick Piggin a ?crit :
> > 
> > >OK, well I would prefer you do the proper atomic operations throughout
> > >where it "really matters" in file_table.c, and do your lazy synchronize
> > >with just the sysctl exported value.
> > >
> > 
> > But... I got complains about atomic_read(&counter) being 'an atomic op' 
> > (untrue), so my second patch just doesnt touch the path where nr_files was 
> > read.
> > 
> 
> Here is a patch that I had done some time ago that uses atomic_t,
> yet retains the sysctl handler. Eric, you earlier patch is incorrect
> exactly for that reason.
> 
> One other thing - the claim that it removes filp_count_lock
> from fast path is bogus. The slab constructor/destructors are
> called only when we return the free file structs to the page
> allocator. That we don't do very often and therefore we
> don't acquire the lock - atleast not for every filp open
> and close.
> 
> This is not to say we don't want a better reference counter like
> a per-cpu counter, but there is some difficult stuff there and
> the returns need to justify that. I would appreciate if you
> or anyone can demonstrate this to be a problem.
> 
> The patch below was meant for debugging some suspected problems
> with -mm.

As mentioned when we last discussed it the nr_files usage in XFS
is boguss and should go away first so we don't need the accessor
and export.  Hopefully we can get rid of the max_files usage
in af_unix aswell, can you ping davem on it?

