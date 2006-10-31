Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423459AbWJaQa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423459AbWJaQa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423559AbWJaQa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:30:28 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:55457 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1423459AbWJaQa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:30:26 -0500
Date: Tue, 31 Oct 2006 17:30:02 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Holden Karau <holdenk@xandros.com>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, holden@pigscanfly.ca,
       holden.karau@gmail.com, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Message-ID: <20061031163002.GC23021@wohnheim.fh-wedel.de>
References: <454765AC.1050905@xandros.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <454765AC.1050905@xandros.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 October 2006 10:03:08 -0500, Holden Karau wrote:
> +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> +			       int nr_bhs , int wait)
>  {
>  	struct msdos_sb_info *sbi = MSDOS_SB(sb);
> -	struct buffer_head *c_bh;
> +	struct buffer_head *c_bh[nr_bhs*(sbi->fats)];

Variable-sized array on the kernel-stack?  That can easily explode in
your hands.  Unless you are _very_ sure about the bounds, you should
do an explicit kmalloc.  And if you were that sure, you could just as
well have an array with fixed size.

> +	if (sb->s_flags & MS_SYNCHRONOUS ) 
[...]
> +		}	
[...]
> +				 int nr_bhs ) 

Trailing whitespace in those lines.

Jörn

-- 
Prosperity makes friends, adversity tries them.
-- Publilius Syrus
