Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWD1Jnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWD1Jnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 05:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWD1Jnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 05:43:33 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:3488 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030342AbWD1Jnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 05:43:32 -0400
Date: Fri, 28 Apr 2006 11:43:20 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, penberg@cs.helsinki.fi,
       ioe-lkml@rameria.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060428094320.GC30532@wohnheim.fh-wedel.de>
References: <20060428112225.418cadd9.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060428112225.418cadd9.holzheu@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 April 2006 11:22:25 +0200, Michael Holzheu wrote:
> +
> +static inline int info_blk_hdr__size(enum diag204_format type)
> +{
> +	if (type == INFO_SIMPLE)
> +		return sizeof(struct info_blk_hdr);
> +	else /* INFO_EXT */
> +		return sizeof(struct x_info_blk_hdr);
> +}
> +
> +static inline __u8 info_blk_hdr__npar(enum diag204_format type, void *hdr)
> +{
> +	if (type == INFO_SIMPLE)
> +		return ((struct info_blk_hdr *)hdr)->npar;
> +	else /* INFO_EXT */
> +		return ((struct x_info_blk_hdr *)hdr)->npar;
> +}
> +
> +static inline __u8 info_blk_hdr__flags(enum diag204_format type, void *hdr)
> +{
> +	if (type == INFO_SIMPLE)
> +		return ((struct info_blk_hdr *)hdr)->flags;
> +	else /* INFO_EXT */
> +		return ((struct x_info_blk_hdr *)hdr)->flags;
> +}
> +
> +static inline __u16 info_blk_hdr__pcpus(enum diag204_format type, void *hdr)
> +{
> +	if (type == INFO_SIMPLE)
> +		return ((struct info_blk_hdr *)hdr)->phys_cpus;
> +	else /* INFO_EXT */
> +		return ((struct x_info_blk_hdr *)hdr)->phys_cpus;
> +}

Hmm.  Another possible approach would be to create a small struct with
a couple of functions, have one function each for type==INFO_SIMPLE
and type==INFO_EXT and fill the struct either with one set of
functions or the other.

Whether that would make more sense than your current approach, I
cannot judge.  Iirc, function calls are still fairly expensive on
s390, so maybe not.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
