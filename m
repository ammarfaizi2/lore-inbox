Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWGJFqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWGJFqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 01:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWGJFqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 01:46:10 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:27142 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S1751344AbWGJFqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 01:46:09 -0400
Date: Mon, 10 Jul 2006 00:46:03 -0500 (CDT)
Message-Id: <200607100546.k6A5k3qU049783@sullivan.realtime.net>
To: Nathan Scott <nathans@sgi.com>, Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: readahead support
From: Milton Miller <miltonm@bga.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the commit 

Date: Thu, 6 Jul 2006 08:03:28 +0000 (+0200)
X-Git-Url: http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=40359ccb836866435b03a0cb57345002b587d875

> --- a/block/blktrace.c
> +++ b/block/blktrace.c
..
> @@ -79,6 +79,8 @@ static u32 bio_act[3] __read_mostly = { 
>  	(((rw) & (1 << BIO_RW_BARRIER)) >> (BIO_RW_BARRIER - 0))
>  #define trace_sync_bit(rw)	\
>  	(((rw) & (1 << BIO_RW_SYNC)) >> (BIO_RW_SYNC - 1))
> +#define trace_ahead_bit(rw)	\
> +	(((rw) & (1 << BIO_RW_AHEAD)) << (BIO_RW_AHEAD - 0))
>  
>  /*
>   * The worker for the various blk_add_trace*() types. Fills out a


Than doesn't make sense, we are using the bit position in the BIO_RW_
name space twice instead of factoring it out like the other uses.

Looking at  include/linux/bio.h line 147 we find
#define BIO_RW_AHEAD    1

So this is moving it from bit 1 (value 2) to bit 2 (value 4).

I think the shift should be << (2 - BIO_RW_AHEAD).

milton
