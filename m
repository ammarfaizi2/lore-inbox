Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWGFWav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWGFWav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWGFWav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:30:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55302 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750946AbWGFWav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:30:51 -0400
Date: Fri, 7 Jul 2006 00:30:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-ID: <20060706223050.GY26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

virt_to_bus/bus_to_virt are long deprecated, mark them as __deprecated 
on i386.

Without such warnings people will never update their code and fix 
the errors in PPC64 builds.

And yes, some of the drivers affected are maintained.

This also catches accidential additions of users for these functions 
like a usage of bus_to_virt() in the infiniband code that was added in 
2.6.17-rc1 (already removed).

This patch increases the number of warnings shown during builds, but it 
seems worth including it at least in -mm for making people aware of this 
issue.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jun 2006
- 27 Apr 2006
- 19 Apr 2006
- 6 Jan 2006
- 13 Dec 2005
- 23 Nov 2005
- 18 Nov 2005
- 12 Nov 2005

--- linux-2.6.14-mm2-full/include/asm-i386/io.h.old	2005-11-12 01:44:38.000000000 +0100
+++ linux-2.6.14-mm2-full/include/asm-i386/io.h	2005-11-12 01:45:58.000000000 +0100
@@ -144,8 +144,14 @@
  *
  * Allow them on x86 for legacy drivers, though.
  */
-#define virt_to_bus virt_to_phys
-#define bus_to_virt phys_to_virt
+static inline unsigned long __deprecated virt_to_bus(volatile void * address)
+{
+	return __pa(address);
+}
+static inline void * __deprecated bus_to_virt(unsigned long address)
+{
+	return __va(address);
+}
 
 /*
  * readX/writeX() are used to access memory mapped devices. On some

