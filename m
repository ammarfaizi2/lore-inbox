Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWI3Tcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWI3Tcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 15:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbWI3Tcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 15:32:42 -0400
Received: from brick.kernel.dk ([62.242.22.158]:63299 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751458AbWI3Tcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 15:32:41 -0400
Date: Sat, 30 Sep 2006 21:31:59 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Zach Brown <zab@zabbo.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-ID: <20060930193158.GA5670@kernel.dk>
References: <20060929113814.db87b8d5.rdunlap@xenotime.net> <20060928185820.GB4759@julia.computer-surgery.co.uk> <20060929121157.0258883f.rdunlap@xenotime.net> <20060928191946.GC4759@julia.computer-surgery.co.uk> <20060929123737.ec613178.rdunlap@xenotime.net> <20060928195627.GD4759@julia.computer-surgery.co.uk> <20060929131730.0b733137.rdunlap@xenotime.net> <451D808A.9050005@zabbo.net> <20060929133205.19c318cb.rdunlap@xenotime.net> <20060929172558.GB4478@julia.computer-surgery.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929172558.GB4478@julia.computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29 2006, Roger Gammans wrote:
> On Fri, Sep 29, 2006 at 01:32:05PM -0700, Randy Dunlap wrote:
> > > How about adding kerneldoc for sector_t itself?
> > 
> > Good idea, but afaik it would have to be added for the entire
> > struct, not just one field.
> 
> sector_t 's a simple typedef from unsigned long or u64 depending on
> config rather than a struct - will kerneldoc still pick up the comments
> on theese?
> 
> Assuming it will I suggest the following. I've kept my shorter text in
> the bi_sector field as it is now more fully explained with sector_t.
> 
> 
> Signed-Off-By: Roger Gammans <rgammans@computer-surgery.co.uk>
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 76bdaea..77a8e6b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -70,7 +70,8 @@ typedef void (bio_destructor_t) (struct
>   * stacking drivers)
>   */
>  struct bio {
> -       sector_t                bi_sector;
> +       sector_t                bi_sector;      /* device address in 512 byte
> +                                                  sectors */
>         struct bio              *bi_next;       /* request queue link */
>         struct block_device     *bi_bdev;
>         unsigned long           bi_flags;       /* status, command, etc
> */
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 3f23566..0ddfa1a 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -127,8 +127,12 @@ #endif
>  /* this is a special 64bit data type that is 8-byte aligned */
>  #define aligned_u64 unsigned long long __attribute__((aligned(8)))
> 
> -/*
> +/**
>   * The type used for indexing onto a disc or disc partition.
> + *
> + * Linux always considers sectors to be 512 bytes long independently
> + * of the devices real block size.
> + *
>   * If required, asm/types.h can override it and define
>   * HAVE_SECTOR_T
>   */

Looks fine to me, I'll add it (although I tend to prefer disk :-)

-- 
Jens Axboe

