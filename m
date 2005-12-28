Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbVL1OyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbVL1OyA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 09:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVL1OyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 09:54:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56805 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964831AbVL1Ox7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 09:53:59 -0500
Date: Wed, 28 Dec 2005 15:53:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 01/2] allow gcc4 to control inlining
Message-ID: <20051228145338.GA15711@elte.hu>
References: <20051228114653.GB3003@elte.hu> <adak6dpcml0.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adak6dpcml0.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roland Dreier <rdreier@cisco.com> wrote:

>  > -#define inline			inline		__attribute__((always_inline))
>  > -#define __inline__		__inline__	__attribute__((always_inline))
>  > -#define __inline		__inline	__attribute__((always_inline))
> 
> Why not just delete these lines?  This:
> 
>  > +#define inline			inline
>  > +#define __inline__		__inline__
>  > +#define __inline		__inline
> 
> seems pointless to me.

indeed. I thought they were redefined to a default if not defined, but 
that's only the case for __always_inline. Updated patch below.

	Ingo

--------
Subject: allow gcc4 to control inlining

allow gcc4 compilers to decide what to inline and what not - instead
of the kernel forcing gcc to inline all the time.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>
----

 include/linux/compiler-gcc4.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: linux/include/linux/compiler-gcc4.h
===================================================================
--- linux.orig/include/linux/compiler-gcc4.h
+++ linux/include/linux/compiler-gcc4.h
@@ -3,14 +3,12 @@
 /* These definitions are for GCC v4.x.  */
 #include <linux/compiler-gcc.h>
 
-#define inline			inline		__attribute__((always_inline))
-#define __inline__		__inline__	__attribute__((always_inline))
-#define __inline		__inline	__attribute__((always_inline))
 #define __deprecated		__attribute__((deprecated))
 #define __attribute_used__	__attribute__((__used__))
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
-#define  noinline		__attribute__((noinline))
+#define noinline		__attribute__((noinline))
+#define __always_inline		inline __attribute__((always_inline))
 #define __must_check 		__attribute__((warn_unused_result))
 #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
 
