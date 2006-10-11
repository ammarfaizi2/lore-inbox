Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWJKMmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWJKMmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWJKMmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:42:14 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22489 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751241AbWJKMmO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:42:14 -0400
Subject: Re: Potential fix for fdtable badness.
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Olof Johansson <olof@lixom.net>, Linas Vepstas <linas@austin.ibm.com>,
       Bryce Harrington <bryce@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610101908.18442.vlobanov@speakeasy.net>
References: <200610101908.18442.vlobanov@speakeasy.net>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 07:42:07 -0500
Message-Id: <1160570527.30819.1.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 19:08 -0700, Vadim Lobanov wrote:
> All,
> 
> Sorry about the recent fdtable badness that you all encountered. I'm working
> on getting a fix out there.
> 
> Dave, Olof, Linas, Bryce,
> 
> Could you please test the patch at the bottom of the email to see if it makes
> your computers happy again, if you have the time and inclination to do so?

The patch works for me.  Thanks!

Shaggy

> Andrew,
> 
> Would you prefer me to resend a fixed patch #4, or a new fix (#5) on top of
> what's in your tree?
> 
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
-- 
David Kleikamp
IBM Linux Technology Center

