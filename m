Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVLEICE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVLEICE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 03:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVLEICE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 03:02:04 -0500
Received: from straum.hexapodia.org ([64.81.70.185]:16980 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751350AbVLEICC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 03:02:02 -0500
Date: Mon, 5 Dec 2005 00:02:02 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp intermittent failures in 2.6.15-rc3-mm1
Message-ID: <20051205080202.GH22168@hexapodia.org>
References: <20051202183748.GA12584@hexapodia.org> <200512022302.48734.rjw@sisk.pl> <200512022354.43750.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512022354.43750.rjw@sisk.pl>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 11:54:43PM +0100, Rafael J. Wysocki wrote:
> Could you please apply the appended one and see if it fixes the issue?
> It's on top of the previous one.
> 
> It's been compile-tested, but I have no machine with highmem to really
> test it.
> 
> --- linux-2.6.15-rc3-mm1.orig/kernel/power/snapshot.c	2005-12-02 22:02:50.000000000 +0100
> +++ linux-2.6.15-rc3-mm1/kernel/power/snapshot.c	2005-12-02 23:45:13.000000000 +0100
> @@ -37,6 +37,12 @@
>  unsigned int nr_copy_pages;
>  
>  #ifdef CONFIG_HIGHMEM
> +struct highmem_page {
> +	char *data;
> +	struct page *page;
> +	struct highmem_page *next;
> +};
[snip]

Yep, this seems to fix the memory allocation failures at suspend.

Thanks!

(I have another separate issue with (I think) your swsusp changes, but
I'll start a new thread for it rather than extending this one.)

-andy
