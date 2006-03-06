Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWCFWka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWCFWka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWCFWka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:40:30 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64675 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932415AbWCFWk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:40:28 -0500
Date: Tue, 7 Mar 2006 09:39:30 +1100
From: Nathan Scott <nathans@sgi.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, christoph <hch@lst.de>,
       mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060307093930.D219568@wobbly.melbourne.sgi.com>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140801549.22756.195.camel@dyn9047017100.beaverton.ibm.com> <20060306100321.GA27319@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060306100321.GA27319@in.ibm.com>; from suparna@in.ibm.com on Mon, Mar 06, 2006 at 03:33:21PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 03:33:21PM +0530, Suparna Bhattacharya wrote:
> On Fri, Feb 24, 2006 at 09:19:08AM -0800, Badari Pulavarty wrote:
> > 
> > I am thinking of having a "fast path" which doesn't deal with any
> > of those and "slow" path to deal with all that non-sense.
> > ...
> > slow_path is going to be slow & ugly. How important is to handle
> > 1k, 2k filesystems efficiently ? Should I try ?
> 
> With 64K page size that could include 4K, 8K, 16K, 32K block size filesystems
> as well, not sure how likely that would be ?

A number of architectures have a pagesize greater than 4K.  Most
(OK, sample size of 2) mkfs programs default to using 4K blocksizes.
So, any/all platforms not having a 4K pagesize will be disadvantaged.
Search on the definition of PAGE_SHIFT in asm-*/page.h and for all
platforms where its not defined to 12, this will hurt.

cheers.

-- 
Nathan
