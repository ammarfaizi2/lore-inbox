Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUFJUr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUFJUr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUFJUrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 16:47:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:5331 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263015AbUFJUry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 16:47:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16584.51435.861827.302250@alkaid.it.uu.se>
Date: Thu, 10 Jun 2004 22:47:39 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1 problems (ACPI and others)
In-Reply-To: <Pine.LNX.4.58.0406102131360.18039@alpha.polcom.net>
References: <200406102045.i5AKjDJo017156@snoqualmie.dp.intel.com>
	<Pine.LNX.4.58.0406102131360.18039@alpha.polcom.net>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski writes:
 > Hi,
 > 
 > I have the following problems with 2.6.7-rc3-mm1:
...
 > 3. PERFCTR gives me compile time errors (see compiler messages). Do I need 
 > any special patches?
...
 >   CC      drivers/perfctr/x86.o
 > /usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c: In function 
 > `finalise_backpatching':
 > /usr/src/linux-2.6.7-rc3-mm1/drivers/perfctr/x86.c:1137: error: syntax 
 > error before '{' token

Perfctr is the victim of broken cpumask patches.
Apply the patch below.

diff -ruN linux-2.6.7-rc3-mm1/include/linux/cpumask.h linux-2.6.7-rc3-mm1.cpu_mask_none-fix/include/linux/cpumask.h
--- linux-2.6.7-rc3-mm1/include/linux/cpumask.h	2004-06-09 19:38:39.000000000 +0200
+++ linux-2.6.7-rc3-mm1.cpu_mask_none-fix/include/linux/cpumask.h	2004-06-09 22:01:28.470416000 +0200
@@ -248,9 +248,9 @@
 #endif
 
 #define CPU_MASK_NONE							\
-{ {									\
+((cpumask_t) { {							\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
-} }
+} })
 
 #define cpus_addr(src) ((src).bits)
 
