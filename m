Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSFJVef>; Mon, 10 Jun 2002 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSFJVee>; Mon, 10 Jun 2002 17:34:34 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:30105 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316355AbSFJVed>; Mon, 10 Jun 2002 17:34:33 -0400
Date: Mon, 10 Jun 2002 15:34:21 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Tom Rini <trini@kernel.crashing.org>
cc: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>,
        Thunder from the hill <thunder@ngforever.de>,
        Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <20020610211152.GQ14252@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0206101533540.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, Tom Rini wrote:
> Right.  Maybe it should even go in <linux/compiler.h> if it's not
> already there.

You want this?

Index: include/linux/compiler.h
===================================================================
RCS file: /var/cvs/thunder-2.5/include/linux/compiler.h,v
retrieving revision 1.1.1.1
diff -u -3 -p -r1.1.1.1 compiler.h
--- include/linux/compiler.h    10 Jun 2002 15:19:48 -0000      1.1.1.1
+++ include/linux/compiler.h    10 Jun 2002 21:33:38 -0000
@@ -8,7 +8,15 @@

 #if __GNUC__ == 2 && __GNUC_MINOR__ < 96
 #define __builtin_expect(x, expected_value) (x)
-#endif
+#endif /* GCC < 2.96 */
+
+/*
+ * There may or may not be a __func__. For GCC < 2.95, there is none, so 
we
+ * define it as __FUNCTION__ there, even though it's NOT equivalent.
+ */
+#if __GNUC__ == 2 && __GNUC_MINOR__ < 95
+#define __func__ __FUNCTION__
+#endif /* GCC < 2.95 */

 #define likely(x)      __builtin_expect((x),1)
 #define unlikely(x)    __builtin_expect((x),0)


Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

