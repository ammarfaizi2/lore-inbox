Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313578AbSEPQ2n>; Thu, 16 May 2002 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313690AbSEPQ2m>; Thu, 16 May 2002 12:28:42 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:54753 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S313578AbSEPQ2m>; Thu, 16 May 2002 12:28:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ghozlane Toumi <ghoz@sympatico.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix BUG macro
Date: Thu, 16 May 2002 12:27:55 -0400
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E178GJX-0005J5-00@wagner.rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020516162841.PYWL19243.tomts15-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thursday 16 May 2002 04:08, Rusty Russell wrote:

>--- linux-2.5.15/include/asm-i386/page.h        Wed May 15 19:53:25 2002
>+++ working-2.5.15-rcu/include/asm-i386/page.h  Thu May 16 17:34:47 2002
>@@ -96,11 +96,16 @@
>  */
> 
> #if 1  /* Set to zero for a slightly smaller kernel */
>+#define __STRINGIZE2(x) #x
>+#define __STRINGIZE(x) __STRINGIZE2(x)
> #define BUG()                          \
>  __asm__ __volatile__( "ud2\n"         \
>                        "\t.word %c0\n" \
>                        "\t.long %c1\n" \
>-                        : : "i" (__LINE__), "i" (__FILE__))
>+                       "\t.long %c2\n" \
>+                        : : "i" (__LINE__), \
>+                       "i" (__STRINGIZE(KBUILD_BASENAME)), \
>+                       "i" (__FUNCTION__))
> #else
> #define BUG() __asm__ __volatile__("ud2\n")
> #endif

Minor nit : any reason why you don't use  __stringify from 
include/linux/stringify.h ?

Ghoz
