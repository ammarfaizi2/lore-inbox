Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTEBAVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTEBAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:21:08 -0400
Received: from [211.167.76.68] ([211.167.76.68]:8892 "HELO soulinfo")
	by vger.kernel.org with SMTP id S262805AbTEBAVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:21:06 -0400
Date: Fri, 2 May 2003 08:33:01 +0800
From: hugang <hugang@soulinfo.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-Id: <20030502083301.58827934.hugang@soulinfo.com>
In-Reply-To: <200305011754.33233.schlicht@uni-mannheim.de>
References: <200304300446.24330.dphillips@sistina.com>
	<20030501135204.GC308@pcw.home.local>
	<20030501225321.6b30e8dc.hugang@soulinfo.com>
	<200305011754.33233.schlicht@uni-mannheim.de>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
 =?ISO-8859-1?Q?=CA=D5=BC=FE=C8=CB=A3=BA:?= Thomas Schlichter <schlicht@uni-mannheim.de>
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= willy@w.ods.org
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= linux-kernel@vger.kernel.org
 =?ISO-8859-1?Q?=B3=AD=CB=CD=A3=BA:?= akpm@digeo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003 17:54:28 +0200
Thomas Schlichter <schlicht@uni-mannheim.de> wrote:

> Hi,
> 
> On March 1, hugang wrote:
> > On Thu, 1 May 2003 15:52:04 +0200
> >
> > Willy TARREAU <willy@w.ods.org> wrote:
> > >  However, I have good news for you, the table code is 15% faster than my
> > > tree on an Alpha EV6 ;-)
> > >  It may be because gcc can use different tricks on this arch.
> > >
> > >  Cheers
> > >  Willy
> >
> > However, The most code changed has increase a little peformance, Do we
> > really need it?
> >
> > Here is test in my machine, The faster is still table.
> 
> I think the table version is so fast as a normal distribution of numbers is 
> tested. With this distribution half of the occuring values have the MSB set, 
> one quarter the next significant bit and so on...
> 
> The tree version is approximately equally fast for every number, but the table 
> version is fast if a very significant bit is set and slow if  a less 
> significant bit is set...
> 
> If small values occour more often than big ones the tree version should be 
> preferred, else following version may be very fast, too.
> 
> static inline int fls_shift(int x)
> {
> 	int bit = 32;
>  
> 	while(x > 0) {
> 		--bit;
> 		x <<= 1;
> 	}
> 
> 	return x ? bit : 0;
> }
> 

Yes, The shift is very faster than other. Here is a test in P4 1.6G.

model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
==== -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 ====
test_fls.c: In function `fls_tree_fls':
test_fls.c:85: warning: type defaults to `int' in declaration of `t'
4294967295 iterations of nil... checksum = 4294967295

real    0m21.698s
user    0m21.650s
sys     0m0.000s
4294967295 iterations of table... checksum = 4294967265

real    0m41.581s
user    0m41.500s
sys     0m0.000s
4294967295 iterations of tree... checksum = 4294967265

real    1m1.173s
user    1m1.040s
sys     0m0.000s
4294967295 iterations of shift... checksum = 4294967265

real    0m22.050s
user    0m22.000s
sys     0m0.010s



-- 
Hu Gang / Steve
Email        : huagng@soulinfo.com, steve@soulinfo.com
GPG FinePrint: 4099 3F1D AE01 1817 68F7  D499 A6C2 C418 86C8 610E
ICQ#         : 205800361
Registered Linux User : 204016
