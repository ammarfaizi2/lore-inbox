Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319256AbSIKSAc>; Wed, 11 Sep 2002 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319255AbSIKSAb>; Wed, 11 Sep 2002 14:00:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7613 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319256AbSIKSAb>;
	Wed, 11 Sep 2002 14:00:31 -0400
Date: Wed, 11 Sep 2002 20:05:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Message-ID: <20020911180502.GD1089@suse.de>
References: <20020911130209.GL1089@suse.de> <20020911185315.530@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911185315.530@192.168.4.1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Benjamin Herrenschmidt wrote:
> >BTW, it would be ok to export that from ide-dma.c instead of duplicating
> >it in ide-pmac.
> 
> It isn't. ide-pmac doesn't use the sg_table & other DMA related
> fields in HWIF, but it's own copies in the "pmif" which is a
> parallel data structure.

The above refers to ide_toggle_bounce() export, pmac_* variant is
exactly the same. Sorry if that wasn't clear.

> It sucks, I know, but I have to do that with the current IDE code
> as the common code would make assumption about the format of these
> things and it's right to dispose them in ide_unregister.
> 
> Also, Jens is right, Paul, you never call pmac_ide_toggle_bounce()
> to actually enable high IOs. Add that to the ide_dma_on/check: case,
> with an if (drive->using_dma) (as enabling DMA may have failed)

Indeed

-- 
Jens Axboe

