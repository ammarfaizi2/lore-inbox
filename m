Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUD2Iqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUD2Iqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUD2Iol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:44:41 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:47625 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263696AbUD2I1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:27:38 -0400
Date: Thu, 29 Apr 2004 09:27:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       trond.myklebust@fys.uio.no, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
Message-ID: <20040429092730.A30057@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Scott <nathans@sgi.com>, Andrew Morton <akpm@osdl.org>,
	trond.myklebust@fys.uio.no, sgoel01@yahoo.com,
	linux-kernel@vger.kernel.org
References: <1083035471.3710.65.camel@lade.trondhjem.org> <20040426205928.58d76dbc.akpm@osdl.org> <1083043386.3710.201.camel@lade.trondhjem.org> <20040426225834.7035d2c1.akpm@osdl.org> <1083080207.2616.31.camel@lade.trondhjem.org> <20040428062942.A27705@infradead.org> <1083169062.2856.36.camel@lade.trondhjem.org> <20040428173811.A1505@infradead.org> <20040428120715.68bc51dd.akpm@osdl.org> <20040429114821.F662560@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429114821.F662560@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Thu, Apr 29, 2004 at 11:48:21AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 11:48:21AM +1000, Nathan Scott wrote:
> Another thing I think XFS could make good use of on the generic
> buffered IO path would be mpage_readpages and mpage_writepages
> variants that can use a get_blocks_t (like the direct IO path)
> instead of the single-block-at-a-time get_block_t interface thats
> used now.  The existence of such beasts would probably impact the
> direction xfs_aops.c takes a fair bit I'd guess Christoph?

For mpage_readpages - yes.  To use mpage_writepages from XFS I'd need
a large-scale rewrite to handle delayed allocations and unwritten extents,
so at least for the 2.6.x timeframe we're probably better of keeping our
own ->writepages inside XFS.

