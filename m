Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUC2HD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 02:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUC2HD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 02:03:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:21740 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262713AbUC2HDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 02:03:54 -0500
Date: Sun, 28 Mar 2004 23:03:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
Message-Id: <20040328230351.1a0d0e9c.akpm@osdl.org>
In-Reply-To: <1080541934.1210.5.camel@gaston>
References: <1080541934.1210.5.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>  sector_t depends on CONFIG_LBD but include/config.h may not be there
>  thus causing interesting breakage in some places...

Nasty.

>  Here's the fix for ppc32 (problem found by Roman Zippel, other archs
>  need a similar fix).

Three of them.

 25-akpm/include/asm-s390/types.h   |    2 ++
 25-akpm/include/asm-sh/types.h     |    2 ++
 25-akpm/include/asm-x86_64/types.h |    2 ++
 3 files changed, 6 insertions(+)

diff -puN include/asm-s390/types.h~types_h-needs-config_h include/asm-s390/types.h
--- 25/include/asm-s390/types.h~types_h-needs-config_h	2004-03-28 23:02:57.481365480 -0800
+++ 25-akpm/include/asm-s390/types.h	2004-03-28 23:02:57.486364720 -0800
@@ -50,6 +50,8 @@ typedef __signed__ long saddr_t;
  */
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 #ifndef __s390x__
 #define BITS_PER_LONG 32
 #else
diff -puN include/asm-sh/types.h~types_h-needs-config_h include/asm-sh/types.h
--- 25/include/asm-sh/types.h~types_h-needs-config_h	2004-03-28 23:02:57.482365328 -0800
+++ 25-akpm/include/asm-sh/types.h	2004-03-28 23:02:57.486364720 -0800
@@ -31,6 +31,8 @@ typedef unsigned long long __u64;
  */
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 #define BITS_PER_LONG 32
 
 #ifndef __ASSEMBLY__
diff -puN include/asm-x86_64/types.h~types_h-needs-config_h include/asm-x86_64/types.h
--- 25/include/asm-x86_64/types.h~types_h-needs-config_h	2004-03-28 23:02:57.484365024 -0800
+++ 25-akpm/include/asm-x86_64/types.h	2004-03-28 23:02:57.486364720 -0800
@@ -29,6 +29,8 @@ typedef unsigned long long  __u64;
  */
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 #define BITS_PER_LONG 64
 
 #ifndef __ASSEMBLY__

_

