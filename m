Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVCKVT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVCKVT2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVCKVT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 16:19:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42406 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261303AbVCKVTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 16:19:07 -0500
Date: Fri, 11 Mar 2005 13:55:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 fix for write throttling on x86 >1G
Message-ID: <20050311165518.GA7412@logos.cnet>
References: <20050311061035.GZ26348@opteron.random> <20050311160413.GK4816@logos.cnet> <20050311205309.GD9270@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311205309.GD9270@opteron.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 09:53:09PM +0100, Andrea Arcangeli wrote:
> Hello Marcelo,
> 
> On Fri, Mar 11, 2005 at 01:04:13PM -0300, Marcelo Tosatti wrote:
> > Out of curiosity, that was SuSE not mainline ? 
> 
> yep.
> 
> > Do we really want to limit dirty cache to low mem on HIGHIO capable 
> > machines? I'm afraid doing so might hurt performance on such systems.
> > 
> > I think it might be wise to have nr_free_buffer_pages() take highmem
> > into account if CONFIG_HIGHIO is set ?
> 
> The problem is the buffercache/blkdev-pagecache: it simply can't go in
> highmem. A similar fix happened recently in 2.6 for the same reasons,
> but in 2.6 we allowed it with some logic specific for the
> blkdev-pagecache.

Right, I dont think it is easy nor wanted to make that distiction in v2.4.  

> nr_free_buffer_pages() was never intended to take highmem into account,
> that's why there's the GFP_USER thing already, except we didn't loop
> into the zonelist, so I didn't try to make a fix similar to 2.6.

Hopefully it is not a big deal to not-allow >1GB dirty pagecache on v2.4. 

Applied, thanks.

