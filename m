Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVAGKCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVAGKCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 05:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVAGKCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 05:02:50 -0500
Received: from miranda.se.axis.com ([193.13.178.2]:21473 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S261338AbVAGKCj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 05:02:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][3/4] let's kill verify_area - convert kernel/compat.c to access_ok()
Date: Fri, 7 Jan 2005 11:02:15 +0100
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB010400CA@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][3/4] let's kill verify_area - convert kernel/compat.c to access_ok()
Thread-Index: AcT0WXowBwoUM76tTXqVqFoBMqpfsQARSNkQ
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "Jesper Juhl" <juhl-lkml@dif.dk>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Jan 2005 10:02:15.0917 (UTC) FILETIME=[F74C59D0:01C4F49F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jesper Juhl
> Sent: Friday, January 07, 2005 02:19
> To: linux-kernel
> Cc: Andrew Morton
> Subject: [PATCH][3/4] let's kill verify_area - convert kernel/compat.c
to access_ok()
> 
> Here's a patch to convert verify_area to access_ok in kernel/compat.c
> 
> diff -up linux-2.6.10-bk9-orig/kernel/compat.c 
> linux-2.6.10-bk9/kernel/compat.c
> --- linux-2.6.10-bk9-orig/kernel/compat.c	2005-01-06
22:19:13.000000000 +0100
> +++ linux-2.6.10-bk9/kernel/compat.c	2005-01-07 02:06:00.000000000
+0100

[snip]

> @@ -612,7 +612,7 @@ long compat_get_bitmap(unsigned long *ma
>  	/* align bitmap up to nearest compat_long_t boundary */
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  
> -	if (verify_area(VERIFY_READ, umask, bitmap_size / 8))
> +	if (!access_ok(VERIFY_READ, umask, bitmap_size / 8) != 0)

Please do not use double negations (i.e., drop the '!= 0' test 
again).

>  		return -EFAULT;
>  
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
> @@ -653,7 +653,7 @@ long compat_put_bitmap(compat_ulong_t __
>  	/* align bitmap up to nearest compat_long_t boundary */
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  
> -	if (verify_area(VERIFY_WRITE, umask, bitmap_size / 8))
> +	if (!access_ok(VERIFY_WRITE, umask, bitmap_size / 8) != 0)
>  		return -EFAULT;
>  
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);

//Peter
