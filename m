Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbTEWI0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263936AbTEWI0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:26:47 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:199 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263932AbTEWI0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:26:46 -0400
Subject: Re: [PATCH] PPC32 Fix warning with ndelay (with patch !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1053679084.1160.99.camel@gaston>
References: <1053679084.1160.99.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053679168.1159.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 10:39:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OOOps, here's the real one...

This patch fixes a warning with recent gcc's when using the new
ndelay() function, by properly defining a large constant as unsigned

===== include/asm-ppc/delay.h 1.5 vs edited =====
--- 1.5/include/asm-ppc/delay.h	Wed Feb 12 05:29:33 2003
+++ edited/include/asm-ppc/delay.h	Fri May 23 10:26:50 2003
@@ -30,8 +30,8 @@
  * (which corresponds to ~3800 bogomips at HZ = 100).
  *  -- paulus
  */
-#define __MAX_UDELAY	(226050910/HZ)	/* maximum udelay argument */
-#define __MAX_NDELAY	(4294967295/HZ)	/* maximum ndelay argument */
+#define __MAX_UDELAY	(226050910UL/HZ)	/* maximum udelay argument */
+#define __MAX_NDELAY	(4294967295UL/HZ)	/* maximum ndelay argument */
 
 extern __inline__ void __udelay(unsigned int x)
 {

