Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbSIWXcH>; Mon, 23 Sep 2002 19:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSIWXcG>; Mon, 23 Sep 2002 19:32:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45021 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261459AbSIWXcG>; Mon, 23 Sep 2002 19:32:06 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209232337.g8NNb8k11651@eng2.beaverton.ibm.com>
Subject: Re: Bug in last night's bk test
To: akpm@digeo.com (Andrew Morton)
Date: Mon, 23 Sep 2002 16:37:08 -0700 (PDT)
Cc: pbadari@us.ibm.com (Badari Pulavarty),
       plars@linuxtestproject.org (Paul Larson),
       linux-kernel@vger.kernel.org (lkml), lse-tech@lists.sourceforge.net
In-Reply-To: <3D8FA032.32193956@digeo.com> from "Andrew Morton" at Sep 23, 2002 03:13:54 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok !! Making direct-io code use bio_add_page() is little tricky.
We operate on the same page multiple times to update the length of
the IO (in case of raw device).  I will look at it closely.

Thanks,
Badari

> Current bitkeeper has 
> 
> #define BIO_MAX_PAGES           (256)
> 
> That's a megabyte.  It works fine with mpage.c.  But direct-io.c
> is still using BIO_MAX_PAGES.  It really is building 1 megabyte
> BIOs, which will break just about every device out there.
> 
> I think we just ask Linus to do the below until we get it fixed up?
> 
> 
> --- 2.5.38-bk2/fs/direct-io.c~direct-io-size	Mon Sep 23 16:12:25 2002
> +++ 2.5.38-bk2-akpm/fs/direct-io.c	Mon Sep 23 16:12:47 2002
> @@ -26,7 +26,7 @@
>   * The largest-sized BIO which this code will assemble, in bytes.  Set this
>   * to PAGE_SIZE if your drivers are broken.
>   */
> -#define DIO_BIO_MAX_SIZE BIO_MAX_SIZE
> +#define DIO_BIO_MAX_SIZE (16*1024)
>  
>  /*
>   * How many user pages to map in one call to get_user_pages().  This determines
> 
> .
