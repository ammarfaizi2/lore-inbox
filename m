Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316615AbSIAKwW>; Sun, 1 Sep 2002 06:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSIAKwW>; Sun, 1 Sep 2002 06:52:22 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:37897 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316615AbSIAKwV>; Sun, 1 Sep 2002 06:52:21 -0400
Date: Sun, 1 Sep 2002 12:56:43 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH] warnkill trivia 2/2
Message-ID: <20020901105643.GH32122@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 5 days, 8:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20-pre5: prevent sparc32's atomic_read() from possibly discarding
const qualifiers from pointers passed as its argument.


diff -urN linux-2.4.20-pre5/include/asm-sparc/atomic.h linux-2.4.20-pre5.n/include/asm-sparc/atomic.h
--- linux-2.4.20-pre5/include/asm-sparc/atomic.h	2001-11-08 17:42:19.000000000 +0100
+++ linux-2.4.20-pre5.n/include/asm-sparc/atomic.h	2002-09-01 12:29:36.000000000 +0200
@@ -35,7 +35,7 @@
 
 #define ATOMIC_INIT(i)	{ (i << 8) }
 
-static __inline__ int atomic_read(atomic_t *v)
+static __inline__ int atomic_read(const atomic_t *v)
 {
 	int ret = v->counter;
 
