Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSA1Rcg>; Mon, 28 Jan 2002 12:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289287AbSA1RcZ>; Mon, 28 Jan 2002 12:32:25 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46097 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289290AbSA1RcK>;
	Mon, 28 Jan 2002 12:32:10 -0500
Date: Mon, 28 Jan 2002 18:31:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sd-many for 2.4.18-pre7 (uses devfs)
Message-ID: <20020128183148.B5588@suse.de>
In-Reply-To: <200201280326.g0S3QTt27080@vindaloo.ras.ucalgary.ca> <20020128101035.B8894@suse.de> <200201281645.g0SGjZp02300@vindaloo.ras.ucalgary.ca> <20020128180142.A5588@suse.de> <200201281725.g0SHP6F03224@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201281725.g0SHP6F03224@vindaloo.ras.ucalgary.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28 2002, Richard Gooch wrote:
> Jens Axboe writes:
> > On Mon, Jan 28 2002, Richard Gooch wrote:
> > > Jens Axboe writes:
> > > > On Sun, Jan 27 2002, Richard Gooch wrote:
> > > > >   Hi, all. Appended is my sd-many patch. It supports up to 2080
> > > > > SD's. This patch is against 2.4.18-pre7, and is essentially the same
> > > > > as earlier versions of this patch, just compensating for kernel drift.
> > > > 
> > > > Could you please at least try to follow the style in sd? To me, this
> > > > alone is reason enough why the patch should not be applied.
> > > 
> > > ??? I *have* followed the style. Or at least I've tried to. Where did
> > > I not?
> > 
> > Are you serious?! You use

> +#ifdef CONFIG_SD_MANY
> +static inline int sd_devnum_to_index(int devnum)
> +{
> +	int i, major = MAJOR (devnum);
> +
> +	for (i = 0; i < sd_template.num_majors; ++i) {
> +	    if (sd_template.majors[i] != major)
> +		continue;
> +	    return (i << 4) | (MINOR (devnum) >> 4);
> +	}
> +	return -ENODEV;
> +}
> +#endif

Apart from this one hunk, yeah it looks consistent and much better now.

-- 
Jens Axboe

