Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTFZWyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTFZWy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:54:29 -0400
Received: from aneto.able.es ([212.97.163.22]:22933 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263338AbTFZWyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:54:13 -0400
Date: Fri, 27 Jun 2003 01:08:24 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix inlining with gcc3
Message-ID: <20030626230824.GM3827@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jun 27, 2003 at 00:03:02 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.27, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
> 

This fixes inlining (really, not-inlining) with gcc3. How about next -pre ?

--- 25/include/linux/compiler.h~gcc3-inline-fix	2003-03-06 03:02:43.000000000 -0800
+++ 25-akpm/include/linux/compiler.h	2003-03-06 03:11:42.000000000 -0800
@@ -1,6 +1,13 @@
 #ifndef __LINUX_COMPILER_H
 #define __LINUX_COMPILER_H
 
+#if __GNUC__ >= 3
+#define inline		__inline__ __attribute__((always_inline))
+#define inline__	__inline__ __attribute__((always_inline))
+#define __inline	__inline__ __attribute__((always_inline))
+#define __inline__	__inline__ __attribute__((always_inline))
+#endif
+
 /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
    a mechanism by which the user can annotate likely branch directions and
    expect the blocks to be reordered appropriately.  Define __builtin_expect



-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
