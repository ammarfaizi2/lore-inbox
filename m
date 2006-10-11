Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWJKCbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWJKCbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 22:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWJKCbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 22:31:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29836 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932386AbWJKCbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 22:31:20 -0400
Date: Tue, 10 Oct 2006 19:31:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, Olof Johansson <olof@lixom.net>,
       Linas Vepstas <linas@austin.ibm.com>, Bryce Harrington <bryce@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Potential fix for fdtable badness.
Message-Id: <20061010193111.82a15ece.akpm@osdl.org>
In-Reply-To: <200610101908.18442.vlobanov@speakeasy.net>
References: <200610101908.18442.vlobanov@speakeasy.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 19:08:18 -0700
Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> Would you prefer me to resend a fixed patch #4, or a new fix (#5) on top of
> what's in your tree?

Incremental updates are preferred.

> diff -Npru old/fs/file.c new/fs/file.c
> --- old/fs/file.c	2006-10-10 18:58:21.000000000 -0700
> +++ new/fs/file.c	2006-10-10 19:01:03.000000000 -0700
> @@ -164,9 +164,8 @@ static struct fdtable * alloc_fdtable(un
>  	 * the fdarray into page-sized chunks: starting at a quarter of a page,
>  	 * and growing in powers of two from there on.
>  	 */
> -	nr++;
>  	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
> -	nr = roundup_pow_of_two(nr);
> +	nr = roundup_pow_of_two(nr + 1);
>  	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
>  	if (nr > NR_OPEN)
>  		nr = NR_OPEN;

Like that.
