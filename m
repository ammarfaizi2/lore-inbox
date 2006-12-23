Return-Path: <linux-kernel-owner+w=401wt.eu-S1752879AbWLWJ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbWLWJ1Y (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbWLWJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:27:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50947 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbWLWJ1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:27:23 -0500
Date: Sat, 23 Dec 2006 09:27:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: Alex Tomas <alex@clusterfs.com>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] delayed allocation for ext4
Message-ID: <20061223092718.GA26276@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Chinner <dgc@sgi.com>, Alex Tomas <alex@clusterfs.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <m37iwjwumf.fsf@bzzz.home.net> <20061223033123.GL44411608@melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223033123.GL44411608@melbourne.sgi.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 23, 2006 at 02:31:23PM +1100, David Chinner wrote:
> >  - ext4-delayed-allocation.patch
> >    delayed allocation itself, enabled by "delalloc" mount option.
> >    extents support is also required. currently it works only
> >    with blocksize=pagesize.
> 
> Ah, that's why you can get away with a page flag - you've ignored
> the partial page delay state problem. Any plans to use the
> existing method in the future so we will be able to use ext4 delalloc
> on machines with a page size larger than 4k?

I think fixing this up for blocksize < pagesize is an absolute requirement
to get things merged.  We don't need more filesystems that are crippled
on half of our platforms.

Note that recording delayed alloc state at a page granularity in addition
to just the buffer heads has a lot of advantages aswell and would help
xfs, too.  But I think it makes a lot more sense to record it as a radix
tree tag to speed up the gang lookups for delalloc conversion.
