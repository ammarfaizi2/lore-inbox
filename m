Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUFBNgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUFBNgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262866AbUFBNgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:36:51 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15565 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262802AbUFBNgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:36:42 -0400
Date: Wed, 2 Jun 2004 15:36:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Yury Umanets <torque@ukrpost.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 buffer.c: bio_alloc() check
Message-ID: <20040602133606.GW28915@suse.de>
References: <1086182887.2898.89.camel@firefly.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086182887.2898.89.camel@firefly.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02 2004, Yury Umanets wrote:
> [PATCH] 2.6.6 buffer.c: adds bio_alloc() check and error handling in
> fs/buffer.c.
> 
> Signed-off-by: Yury Umanets <torque@ukrpost.net>
> 
>  buffer.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+)
> 
> diff -rupN ./linux-2.6.6/fs/buffer.c ./linux-2.6.6-modified/fs/buffer.c
> --- ./linux-2.6.6/fs/buffer.c	Mon May 10 05:32:38 2004
> +++ ./linux-2.6.6-modified/fs/buffer.c	Wed Jun  2 15:21:47 2004
> @@ -2712,6 +2712,31 @@ void submit_bh(int rw, struct buffer_hea
>  	 * submit_bio -> generic_make_request may further map this bio around
>  	 */
>  	bio = bio_alloc(GFP_NOIO, 1);
> +	if (bio == NULL) {

This is wrong, bio_alloc() never fails if it's called with __GFP_WAIT in
the gfp mask.

-- 
Jens Axboe

