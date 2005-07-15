Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263362AbVGOSQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbVGOSQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVGOSOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:14:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261997AbVGOSM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:12:58 -0400
Date: Fri, 15 Jul 2005 11:12:50 -0700
From: Chris Wright <chrisw@osdl.org>
To: aq <aquynh@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] memparse bugfix
Message-ID: <20050715181250.GO9153@shell0.pdx.osdl.net>
References: <9cde8bff05071510307c7beb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cde8bff05071510307c7beb4@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* aq (aquynh@gmail.com) wrote:
> Function lib/cmdline.c:memparse() wrongly calculates the memory if the
> given string has K/M/G suffix. This patch (against 2.6.13-rc3) fixes
> the problem. Please apply.

Patch looks incorrect.

> --- 2.6.13-rc3/lib/cmdline.c	2005-04-30 10:31:37.000000000 +0900
> +++ 2.6.13-rc3/lib/cmdline-aq.c	2005-07-16 02:25:26.000000000 +0900
> @@ -100,10 +100,10 @@ unsigned long long memparse (char *ptr, 
>  	switch (**retptr) {
>  	case 'G':
>  	case 'g':
> -		ret <<= 10;
> +		ret <<= 30;
>  	case 'M':
>  	case 'm':
> -		ret <<= 10;
> +		ret <<= 20;
>  	case 'K':
>  	case 'k':
>  		ret <<= 10;

Now, G == ret << 80, M == ret << 30...  Notice the fall-thru cases.

thanks,
-chris
