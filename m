Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVACSBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVACSBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVACSAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:00:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51894 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261680AbVACSAQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:00:16 -0500
Message-ID: <41D9881B.4020000@pobox.com>
Date: Mon, 03 Jan 2005 12:59:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [3/8] kill gen_init_cpio.c printk() of size_t warning
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com>
In-Reply-To: <20050103172839.GE29332@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> The rest of gen_init_cpio.c seems to cast the result of strlen() to
> handle this situation, so this patch follows suit while killing off
> size_t -related printk() warnings.
> 
> Signed-off-by: William Irwin <wli@holomorphy.com>
> 
> Index: mm1-2.6.10/usr/gen_init_cpio.c
> ===================================================================
> --- mm1-2.6.10.orig/usr/gen_init_cpio.c	2005-01-03 06:45:53.000000000 -0800
> +++ mm1-2.6.10/usr/gen_init_cpio.c	2005-01-03 08:11:18.000000000 -0800
> @@ -86,7 +86,7 @@
>  		0,			/* minor */
>  		0,			/* rmajor */
>  		0,			/* rminor */
> -		(unsigned)strlen(name) + 1, /* namesize */
> +		(unsigned)strlen(name)+1, /* namesize */
>  		0);			/* chksum */
>  	push_hdr(s);
>  	push_rest(name);
> @@ -112,7 +112,7 @@
>  		(long) gid,		/* gid */
>  		1,			/* nlink */
>  		(long) mtime,		/* mtime */
> -		strlen(target) + 1,	/* filesize */
> +		(unsigned)strlen(target)+1, /* filesize */

This removes whitespace in the process, violating the file's chosen 
style (and typical lkml style).

	Jeff



