Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267172AbSKMLjG>; Wed, 13 Nov 2002 06:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267173AbSKMLjG>; Wed, 13 Nov 2002 06:39:06 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:9903 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267172AbSKMLjF>; Wed, 13 Nov 2002 06:39:05 -0500
X-Face: "iUeUu$b*W_"w?tV83Y3*r:`rh&dRv}$YnZ3,LVeCZSYVuf[Gpo*5%_=/\_!gc_,SS}[~xZ
 wY77I-M)xHIx:2f56g%/`SOw"Dx%4Xq0&f\Tj~>|QR|vGlU}TBYhiG(K:2<T^
To: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/asm-ARCH/page.h:get_order() Reorganize and optimize
References: <E18BmqO-0000Za-00@milikk>
From: Falk Hueffner <falk.hueffner@student.uni-tuebingen.de>
Date: 13 Nov 2002 12:45:33 +0100
In-Reply-To: <E18BmqO-0000Za-00@milikk>
Message-ID: <87y97xhew2.fsf@student.uni-tuebingen.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.5 (broccoli)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com> writes:

>     s = --s >> PAGE_SHIFT;

This code has undefined behaviour.

>     if (likely (s) < s)

What is that supposed to do?

BTW, I just noticed

#define likely(x)       __builtin_expect((x),1)

I think this should rather be

#define likely(x)       __builtin_expect((x)!=0,1)

So people can write

if (likely(pointer))

and indeed some people seem to assume that already.

--- linux-2.5.47/include/linux/compiler.h~      2002-11-11 04:28:25.000000000 +0100
+++ linux-2.5.47/include/linux/compiler.h       2002-11-13 12:44:05.000000000 +0100
@@ -10,7 +10,7 @@
 #define __builtin_expect(x, expected_value) (x)
 #endif
 
-#define likely(x)      __builtin_expect((x),1)
+#define likely(x)      __builtin_expect((x)!=0,1)
 #define unlikely(x)    __builtin_expect((x),0)
 
 /* This macro obfuscates arithmetic on a variable address so that gcc

-- 
	Falk
