Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSIALYf>; Sun, 1 Sep 2002 07:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSIALYf>; Sun, 1 Sep 2002 07:24:35 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:47113 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316674AbSIALYe>; Sun, 1 Sep 2002 07:24:34 -0400
Date: Sun, 1 Sep 2002 13:28:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
Message-ID: <20020901112856.GL32122@louise.pinerecords.com>
References: <20020901105643.GH32122@louise.pinerecords.com> <20020901.035749.37156689.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901.035749.37156689.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 5 days, 8:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Sun, 1 Sep 2002 12:56:43 +0200
> 
>    2.4.20-pre5: prevent sparc32's atomic_read() from possibly discarding
>    const qualifiers from pointers passed as its argument.
>    
>    -static __inline__ int atomic_read(atomic_t *v)
>    +static __inline__ int atomic_read(const atomic_t *v)
> 
> So the atomic_t is const is it?  That's news to me.
> 
> I think you mean something like "atomic_t const * v" which means the
> pointer is constant, not the value.

Precisely.


diff -u linux-2.4.20-pre5/include/asm-sparc/atomic.h linux-2.4.20-pre5.n/include/asm-sparc/atomic.h
--- linux-2.4.20-pre5/include/asm-sparc/atomic.h	2001-11-08 17:42:19.000000000 +0100
+++ linux-2.4.20-pre5.n/include/asm-sparc/atomic.h	2002-09-01 12:29:36.000000000 +0200
@@ -35,7 +35,7 @@
 
 #define ATOMIC_INIT(i)	{ (i << 8) }
 
-static __inline__ int atomic_read(atomic_t *v)
+static __inline__ int atomic_read(atomic_t const *v)
 {
 	int ret = v->counter;
 
