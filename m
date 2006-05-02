Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWEBUx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWEBUx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWEBUx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 16:53:59 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:41765 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964906AbWEBUx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 16:53:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ZnV5ArETFS5ZvCqwA8RhMoAAmS/3hZwVOJxSxCAr3gp/0iqydyT8mVqgcPUg086ZQLXx1qIw5ldif90D6XPUkIFbhY5tz0pX5H8d5aPO9z2d/CkqCqChav3yJ5Jz+ItpFvPtAXqLlv3oE6UnvQ+zwFXd0XwP1Buvht76Tv9DJLc=
Date: Tue, 2 May 2006 22:54:06 +0200
From: Luca <kronos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: "Petri T. Koistinen" <petri.koistinen@iki.fi>, xfs-masters@oss.sgi.com,
       nathans@sgi.com
Subject: Re: [PATCH] fs/xfs/xfs_bmap.c: initialize variable, remove warning
Message-ID: <20060502205406.GA9633@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605020015230.5245@joo>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri T. Koistinen <petri.koistinen@iki.fi> ha scritto:
> From: Petri T. Koistinen <petri.koistinen@iki.fi>
> 
> Remove warning by initializing uninitialized variable.
> 
> Warning:
>  CC      fs/xfs/xfs_bmap.o
> fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
> fs/xfs/xfs_bmap.c:2498: warning: 'rtx' is used uninitialized in this function
> 
> Signed-off-by: Petri T. Koistinen <petri.koistinen@iki.fi>
> ---
> fs/xfs/xfs_bmap.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> ---
> diff --git a/fs/xfs/xfs_bmap.c b/fs/xfs/xfs_bmap.c
> index 26939d3..35bad7b 100644
> --- a/fs/xfs/xfs_bmap.c
> +++ b/fs/xfs/xfs_bmap.c
> @@ -2453,7 +2453,7 @@ xfs_bmap_rtalloc(
> 	xfs_extlen_t	prod = 0;	/* product factor for allocators */
> 	xfs_extlen_t	ralen = 0;	/* realtime allocation length */
> 	xfs_extlen_t	align;		/* minimum allocation alignment */
> -	xfs_rtblock_t	rtx;		/* realtime extent number */
> +	xfs_rtblock_t	rtx = 0;	/* realtime extent number */
> 	xfs_rtblock_t	rtb;
> 
> 	mp = ap->ip->i_mount;


Dump compiler ;)

rtx is initialized by xfs_rtpick_extent(); if xfs_rtpick_extent succedes
then rtx is initialized, if it fails then rtx is never used.

I also see the warning, and I'm compiling without CONFIG_XFS_RT; in this
case xfs_rtpick_extent() is a noop (ENOSYS), gcc really should see that
rtx won't be used. Funny.

Luca
-- 
Home: http://kronoz.cjb.net
Il piu` bel momento dell'amore e` quando ci si illude che duri per 
sempre; il piu` brutto, quando ci si accorge che dura da troppo.
