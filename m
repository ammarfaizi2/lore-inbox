Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266567AbUGKLur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbUGKLur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266573AbUGKLur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:50:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:55491 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266567AbUGKLup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:50:45 -0400
Date: Sun, 11 Jul 2004 13:50:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, aoliva@redhat.com, ncunningham@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040711115039.GD4701@fs.tum.de>
References: <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <orvfgvo8pr.fsf@livre.redhat.lsd.ic.unicamp.br> <20040711055352.GB87770@muc.de> <20040710235536.14718bae.akpm@osdl.org> <20040711082630.GA63148@muc.de> <20040711013218.414941ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711013218.414941ce.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 01:32:18AM -0700, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
>...
> > > b) If the programmer didn't say "inline" then don't inline it.
> > > 
> > > Surely it is not hard to add a new option to gcc to provide these semantics?
> > 
> > That option is -O2 -Dinline="__attribute__((always_inline))"
> > But for some reason it was turned off for 3.4/3.5.
> > 
> 
> Please tell me that was just a bug, and it will be fixed very soon.


It's a bug in compiler-gcc3.h, and I already sent the patch below in 
this thread.

I'm currently sending fixes for compile errors this causes with gcc 3.4 
(I've forgotten the exact number, but there were compile errors in at 
about 30 files in a full i386 compile).


<--  snip  -->


[patch] #define inline as __attribute__((always_inline)) also for gcc >= 3.4

Rationale:
- if gcc 3.4 can't inline a function marked as "inline" that's a
  strong hint that further investigation is required
- I strongly prefer a compile error over a potential runtime problem


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/include/linux/compiler-gcc3.h.old	2004-07-08 23:40:27.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/include/linux/compiler-gcc3.h	2004-07-08 23:40:37.000000000 +0200
@@ -3,7 +3,7 @@
 /* These definitions are for GCC v3.x.  */
 #include <linux/compiler-gcc.h>
 
-#if __GNUC_MINOR__ >= 1  && __GNUC_MINOR__ < 4
+#if __GNUC_MINOR__ >= 1
 # define inline		__inline__ __attribute__((always_inline))
 # define __inline__	__inline__ __attribute__((always_inline))
 # define __inline	__inline__ __attribute__((always_inline))

