Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263503AbVCEAgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbVCEAgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbVCEASo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:18:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13443 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263339AbVCEAA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:00:56 -0500
Subject: Re: [PATCH] 2.6.11-mm1 ext3 writepages support for writeback mode
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304154346.488b0a14.akpm@osdl.org>
References: <1109978510.7236.18.camel@dyn318077bld.beaverton.ibm.com>
	 <20050304154346.488b0a14.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1109980684.7236.35.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Mar 2005 15:58:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 15:43, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > Here is the 2.6.11-mm1 patch for adding writepages support
> > for ext3 writeback mode. Could you include it in -mm tree ?
> 
> spose so.  Does it work?
> 
> Do you have any benchmarking results handy?

I did few benchmarks earlier which showed 5-7% improvement
on throughput. I will run the numbers again.

> 
> > +static int
> > +ext3_writeback_writepages(struct address_space *mapping, 
> > +				struct writeback_control *wbc)
> > +{
> > +	struct inode *inode = mapping->host;
> > +	handle_t *handle = NULL;
> > +	int err, ret = 0;
> > +
> > +	if (!mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
> > +		return ret;
> 
> Can we please add a comment explaining why this is here?  I've already
> forgotten why we put it there.

This is to avoid not starting the journal when we are trying to
destroy journal inode. I will add comments.

>       journal_destory()
>               iput(journal inode)
>                       do_writepages()
>                               generic_writepages()
>                                       ext3_writeback_writepage()
>                                               journal_start()

 
Thanks,
Badari


