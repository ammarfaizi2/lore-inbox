Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVH2XVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVH2XVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 19:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVH2XVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 19:21:34 -0400
Received: from xenotime.net ([66.160.160.81]:63424 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751421AbVH2XVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 19:21:34 -0400
Date: Mon, 29 Aug 2005 16:21:30 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13 : __check_region is deprecated
In-Reply-To: <20050829231417.GB2736@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0508291619290.11117-100000@shark.he.net>
References: <20050829231417.GB2736@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Stephane Wirtel wrote:

> Hi,
>
> By compiling my kernel, I can see that the __check_region function (in
> kernel/resource.c) is deprecated.
>
> With a grep on the source code of the last release, I get this result.
>
> drivers/pnp/resource.c:255:             if (__check_region(&ioport_resource, *port, length(port,end)))
> include/linux/ioport.h:117:#define check_mem_region(start,n) __check_region(&iomem_resource, (start), (n))
> include/linux/ioport.h:120:extern int __check_region(struct resource *, unsigned long, unsigned long);
> include/linux/ioport.h:125:     return __check_region(&ioport_resource, s, n);
> kernel/resource.c:468:int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
> kernel/resource.c:481:EXPORT_SYMBOL(__check_region);
>
> Is there a function to replace this deprecated function ?

Just restructure the code to use request_region().

> Why is it deprecated ?

because it's racy.  I.e., it's normally used as:

	check_region();
	if (ok)
		request_region();

but between the check_region() and request_region(), the region
could have been allocated by something else.

-- 
~Randy
