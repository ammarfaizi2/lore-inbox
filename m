Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTEAOsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTEAOsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:48:12 -0400
Received: from [211.167.76.68] ([211.167.76.68]:50363 "HELO soulinfo")
	by vger.kernel.org with SMTP id S261359AbTEAOsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:48:11 -0400
Date: Thu, 1 May 2003 22:53:21 +0800
From: hugang <hugang@soulinfo.com>
To: Willy TARREAU <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030501225321.6b30e8dc.hugang@soulinfo.com>
In-Reply-To: <20030501135204.GC308@pcw.home.local>
References: <200304300446.24330.dphillips@sistina.com>
	<20030430135512.6519eb53.akpm@digeo.com>
	<20030501130318.459a4776.hugang@soulinfo.com>
	<20030430221129.11595e2e.akpm@digeo.com>
	<20030501133307.158c7e10.hugang@soulinfo.com>
	<20030501150557.6dc913f7.hugang@soulinfo.com>
	<20030501135204.GC308@pcw.home.local>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Willy TARREAU <willy@w.ods.org>
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= linux-kernel@vger.kernel.org
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= akpm@digeo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003 15:52:04 +0200
Willy TARREAU <willy@w.ods.org> wrote:

>  However, I have good news for you, the table code is 15% faster than my tree
>  on an Alpha EV6 ;-)
>  It may be because gcc can use different tricks on this arch.
> 
>  Cheers
>  Willy

However, The most code changed has increase a little peformance, Do we really need it?

Here is test in my machine, The faster is still table.

==== -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 ====
test_fls.c: In function `fls_tree_fls':
test_fls.c:78: warning: type defaults to `int' in declaration of `t'
4294967295 iterations of nil... checksum = 4294967295

real    0m21.852s
user    0m21.500s
sys     0m0.300s
4294967295 iterations of old... checksum = 4294967265

real    0m45.206s
user    0m44.800s
sys     0m0.310s
4294967295 iterations of new... checksum = 4294967265

real    0m45.235s
user    0m44.720s
sys     0m0.420s
4294967295 iterations of new2... checksum = 4294967265

real    0m59.615s
user    0m58.960s
sys     0m0.540s
4294967295 iterations of table... checksum = 4294967265

real    0m41.784s
user    0m41.420s
sys     0m0.280s
4294967295 iterations of tree... checksum = 4294967265

real    0m44.874s
user    0m44.410s
sys     0m0.380s
------------------


-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
ICQ#         : 205800361
Registered Linux User : 204016
