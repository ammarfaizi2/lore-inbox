Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUGMBDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUGMBDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUGMBDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:03:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57284 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264444AbUGMBCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:02:44 -0400
Date: Tue, 13 Jul 2004 03:02:40 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, aoliva@redhat.com,
       ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
Subject: [updated 2.6 patch] #define inline as __attribute__((always_inline)) also for gcc >= 3.4
Message-ID: <20040713010239.GG4701@fs.tum.de>
References: <2fG2F-4qK-3@gated-at.bofh.it> <20040711013218.414941ce.akpm@osdl.org> <20040711115039.GD4701@fs.tum.de> <200407111501.21769.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407111501.21769.arnd@arndb.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 03:01:18PM +0200, Arnd Bergmann wrote:
> On Sonntag, 11. Juli 2004 13:50, Adrian Bunk wrote:
> > -#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
> > +#if __GNUC_MINOR__ >= 1
> >  # define inline                __inline__ __attribute__((always_inline))
> >  # define __inline__    __inline__ __attribute__((always_inline))
> >  # define __inline      __inline__ __attribute__((always_inline))
> 
> While we're there, shouldn't this really be the following?
> 
> # define inline          inline   __attribute__((always_inline))
> # define __inline__    __inline__ __attribute__((always_inline))
> # define __inline      __inline   __attribute__((always_inline))
> 
> I find it somewhat annoying that the preprocessor expands every "inline"
> to "__inline__ __attribute__((always_inline)) __attribute__((always_inline))"
> in the current code.

Sounds like a good idea.

Updated patch below.

> 	Arnd <><

<--  snip  -->

[patch] #define inline as __attribute__((always_inline)) also for gcc >= 3.4


Rationale:
- if gcc 3.4 can't inline a function marked as "inline" that's a
  strong hint that further investigation is required
- I strongly prefer a compile error over a potential runtime problem


Additionally, it changes all #define's to expand to the correct
{,__}inline{,__} (suggested by Arnd Bergmann <arnd@arndb.de>).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/include/linux/compiler-gcc3.h.old	2004-07-13 02:56:53.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/include/linux/compiler-gcc3.h	2004-07-13 02:58:03.000000000 +0200
@@ -3,10 +3,10 @@
 /* These definitions are for GCC v3.x.  */
 #include <linux/compiler-gcc.h>
 
-#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
-# define inline		__inline__ __attribute__((always_inline))
-# define __inline__	__inline__ __attribute__((always_inline))
-# define __inline	__inline__ __attribute__((always_inline))
+#if __GNUC_MINOR__ >= 1
+# define inline		inline		__attribute__((always_inline))
+# define __inline__	__inline__	__attribute__((always_inline))
+# define __inline	__inline	__attribute__((always_inline))
 #endif
 
 #if __GNUC_MINOR__ > 0


