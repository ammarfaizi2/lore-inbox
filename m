Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbUD2Bw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbUD2Bw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbUD2Bw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:52:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:46887 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262866AbUD2BwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:52:18 -0400
Date: Thu, 29 Apr 2004 11:48:21 +1000
From: Nathan Scott <nathans@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
Message-ID: <20040429114821.F662560@wobbly.melbourne.sgi.com>
References: <20040426191512.69485c42.akpm@osdl.org> <1083035471.3710.65.camel@lade.trondhjem.org> <20040426205928.58d76dbc.akpm@osdl.org> <1083043386.3710.201.camel@lade.trondhjem.org> <20040426225834.7035d2c1.akpm@osdl.org> <1083080207.2616.31.camel@lade.trondhjem.org> <20040428062942.A27705@infradead.org> <1083169062.2856.36.camel@lade.trondhjem.org> <20040428173811.A1505@infradead.org> <20040428120715.68bc51dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040428120715.68bc51dd.akpm@osdl.org>; from akpm@osdl.org on Wed, Apr 28, 2004 at 12:07:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 12:07:15PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > I'm not yet sure where I'm heading with revamping xfs_aops.c, but what
> >  I'd love to see in the end is more or less xfs implementing only
> >  writepages and some generic implement writepage as writepages wrapper.
> ...
> Any code which implements writearound-inside-writepage should be targetted
> at a generic implementation, not an fs-specific one if poss.  We could go

Another thing I think XFS could make good use of on the generic
buffered IO path would be mpage_readpages and mpage_writepages
variants that can use a get_blocks_t (like the direct IO path)
instead of the single-block-at-a-time get_block_t interface thats
used now.  The existence of such beasts would probably impact the
direction xfs_aops.c takes a fair bit I'd guess Christoph?

cheers.

-- 
Nathan
