Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbTEALFk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbTEALFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:05:40 -0400
Received: from [211.167.76.68] ([211.167.76.68]:63928 "HELO soulinfo")
	by vger.kernel.org with SMTP id S261212AbTEALFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:05:38 -0400
Date: Thu, 1 May 2003 19:17:30 +0800
From: hugang <hugang@soulinfo.com>
To: Willy TARREAU <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030501191730.76b9d986.hugang@soulinfo.com>
In-Reply-To: <20030501102230.GA308@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
	<20030501131605.02066260.hugang@soulinfo.com>
	<20030501102230.GA308@pcw.home.local>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Willy TARREAU <willy@w.ods.org>
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003 12:22:30 +0200
Willy TARREAU <willy@w.ods.org> wrote:

> On Thu, May 01, 2003 at 01:16:05PM +0800, hugang wrote:
> 
> > Here is table version of the fls. Yes it fast than other.
> 
> Sorry, but this code returns wrong results. Test it with less
> iterations, it doesn't return the same result.
> 
> >         unsigned i = 0;
> > 
> >         do {
> >                 i++;
> >         } while (n <= fls_table[i].max && n > fls_table[i].min);
> 
> You never even compare with table[0] !
> 
> > --test log is here----
> 
> I recoded a table based on your idea, and it's clearly faster than others, and
> even faster than yours :
> 
> ============
> static unsigned tbl[33] = { 2147483648, 1073741824, 536870912, 268435456,
> 			    134217728, 67108864, 33554432, 16777216,
> 			    8388608, 4194304, 2097152, 1048576,
> 			    524288, 262144, 131072, 65536,
> 			    32768, 16384, 8192, 4096,
> 			    2048, 1024, 512, 256,
> 			    128, 64, 32, 16,
> 			    8, 4, 2, 1, 0 };
> 
> 
> static inline int fls_tbl_fls(unsigned n)
> {
>         unsigned i = 0;
> 
> 	while (n < tbl[i])
> 	    i++;
> 
>         return 32 - i;
> }
> ===========

Do see the mail by Andrew Morton? -----

From: Andrew Morton <akpm@digeo.com>
To: hugang <hugang@soulinfo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Date: Wed, 30 Apr 2003 22:11:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)

 hugang <hugang@soulinfo.com> wrote:
 >
 > Here is table version of the fls. Yes it fast than other.

 nooo..  That has a big cache footprint.  At the very least you should use
 a binary search.  gcc will do it for you:

 	switch (n) {
 	case 0 ... 1:
 		return 1;
 	case 2 ... 3:
 		return 2;
 	case 4 ... 7:
 		return 3;
 	case 8 ... 15:
 		return 4;

 etc.
----------
I agree him, The Lastest code my posted has works fine, Please check it.

-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
ICQ#         : 205800361
Registered Linux User : 204016
