Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319448AbSILGQT>; Thu, 12 Sep 2002 02:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319449AbSILGQT>; Thu, 12 Sep 2002 02:16:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19686 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319448AbSILGQS>;
	Thu, 12 Sep 2002 02:16:18 -0400
Date: Thu, 12 Sep 2002 08:20:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Message-ID: <20020912062057.GK30234@suse.de>
References: <15743.15275.412038.388540@argo.ozlabs.ibm.com> <20020911130209.GL1089@suse.de> <15744.12392.868240.502920@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15744.12392.868240.502920@argo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12 2002, Paul Mackerras wrote:
> Jens Axboe writes:
> 
> > Doesn't look like it's needed at all, at least you never turn on highmem
> > I/O with ide_toggle_bounce() :-)
> 
> Foo, neither I do. :(
> 
> > BTW, it would be ok to export that from ide-dma.c instead of duplicating
> > it in ide-pmac.
> 
> Looking at it again, both ide_build_sglist and ide_raw_build_sglist do
> *almost* what we want.  If ide-pmac used hwif->sg_table instead of
> pmif->sg_table, and if ide_[raw_]build_sglist were exported and took
> the maximum number of entries as a parameter instead of using the
> PRD_ENTRIES constant, then ide-pmac wouldn't need to have its own
> versions of those routines.  Would those changes be OK?

Sounds like a perfectly fine change to me.

> Ben, any reason why we have to use pmif->sg_table rather than
> hwif->sg_table?

Looks identical to me. hwif->sg_table is kmalloc'ed sg list of
PRD_ENTRIES (256), pmif->sg_table is kmalloc'ed ditto of MAX_DCMDS (256)
entries.

-- 
Jens Axboe

