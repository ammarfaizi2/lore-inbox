Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWIFRnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWIFRnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWIFRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:43:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:30936 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751214AbWIFRnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:43:01 -0400
Subject: Re: [PATCH] ext3_getblk should handle HOLE correctly
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       ext4 <linux-ext4@vger.kernel.org>, Will Simoneau <simoneau@ele.uri.edu>,
       cmm@us.ibm.com
In-Reply-To: <1157564346.23501.49.camel@dyn9047017100.beaverton.ibm.com>
References: <1157564346.23501.49.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 12:42:55 -0500
Message-Id: <1157564575.8200.16.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 10:39 -0700, Badari Pulavarty wrote:

> Index: linux-2.6.18-rc5/fs/ext3/inode.c
> ===================================================================
> --- linux-2.6.18-rc5.orig/fs/ext3/inode.c	2006-08-27 20:41:48.000000000 -0700
> +++ linux-2.6.18-rc5/fs/ext3/inode.c	2006-09-05 15:32:57.000000000 -0700
> @@ -1009,11 +1009,12 @@ struct buffer_head *ext3_getblk(handle_t
>  	buffer_trace_init(&dummy.b_history);
>  	err = ext3_get_blocks_handle(handle, inode, block, 1,
>  					&dummy, create, 1);
> -	if (err == 1) {
> +	/*
> +	 * ext3_get_blocks_handle() returns number of blocks
> +	 * mapped. 0 in case of a HOLE.
> +	 */
> +	if (err > 0) {
>  		err = 0;
> -	} else if (err >= 0) {
> -		WARN_ON(1);
> -		err = -EIO;
>  	}

I'd get rid of the {} too.

>  	*errp = err;
>  	if (!err && buffer_mapped(&dummy)) {

-- 
David Kleikamp
IBM Linux Technology Center

