Return-Path: <linux-kernel-owner+w=401wt.eu-S1754622AbWLRWQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbWLRWQA (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754626AbWLRWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 17:16:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35819 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbWLRWP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 17:15:58 -0500
Date: Mon, 18 Dec 2006 22:15:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, apw@shadowen.org, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org, mkravetz@us.ibm.com,
       hch@infradead.org, jk@ozlabs.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, benh@kernel.crashing.org, gone@us.ibm.com,
       kmannth@us.ibm.com
Subject: Re: [PATCH] Fix sparsemem on Cell
Message-ID: <20061218221534.GB25472@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
	cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
	mkravetz@us.ibm.com, jk@ozlabs.org, linux-kernel@vger.kernel.org,
	paulus@samba.org, benh@kernel.crashing.org, gone@us.ibm.com,
	kmannth@us.ibm.com
References: <20061215165335.61D9F775@localhost.localdomain> <4582D756.7090702@shadowen.org> <1166203440.8105.22.camel@localhost.localdomain> <20061215114536.dc5c93af.akpm@osdl.org> <20061216170353.2dfa27b1.kamezawa.hiroyu@jp.fujitsu.com> <1166476437.8648.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166476437.8648.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 01:13:57PM -0800, Dave Hansen wrote:
> On Sat, 2006-12-16 at 17:03 +0900, KAMEZAWA Hiroyuki wrote:
> >  /* add this memory to iomem resource */
> >  static struct resource *register_memory_resource(u64 start, u64 size)
> >  {
> > @@ -273,10 +284,13 @@
> >  		if (ret)
> >  			goto error;
> >  	}
> > +	atomic_inc(&memory_hotadd_count);
> >  
> >  	/* call arch's memory hotadd */
> >  	ret = arch_add_memory(nid, start, size);
> >  
> > +	atomic_dec(&memory_hotadd_count);
> 
> I'd be willing to be that this will work just fine.  But, I think we can
> do it without any static state at all, if we just pass a runtime-or-not
> flag down into the arch_add_memory() call chain.
> 
> I'll code that up so we can compare to yours.  

Yes, I stronly concur that passing an explicit flag is much much better
than any hack involving global state.
