Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319462AbSILGyZ>; Thu, 12 Sep 2002 02:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319466AbSILGyZ>; Thu, 12 Sep 2002 02:54:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56808 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319462AbSILGyY>;
	Thu, 12 Sep 2002 02:54:24 -0400
Date: Thu, 12 Sep 2002 08:59:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
Message-ID: <20020912065903.GM30234@suse.de>
References: <20020911130209.GL1089@suse.de> <20020911185315.530@192.168.4.1> <20020911180502.GD1089@suse.de> <15744.14859.966809.289502@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15744.14859.966809.289502@argo.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12 2002, Paul Mackerras wrote:
> Jens Axboe writes:
> 
> > The above refers to ide_toggle_bounce() export, pmac_* variant is
> > exactly the same. Sorry if that wasn't clear.
> 
> Why does ide_toggle_bounce assume we can only do DMA to highmem if
> drive->media == ide_disk?  At the moment I can't see any reason why
> the ide-pmac interface can't do DMA to highmem for a cdrom, for
> instance.

Because it requires changes to the personality driver (ie ide-disk,
ide-cd, etc). I only did those changes to ide-disk, didn't figure it was
worthwhile to do for ide-cd for instance. It's not exactly a
high-performance media :-)

If the device is always in dma mode, no changes are needed. It's when
you drop to pio the problem arises, and all the interrupt handlers need
to be fixed.

-- 
Jens Axboe

