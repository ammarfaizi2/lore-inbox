Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272362AbTHIOEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272363AbTHIOEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:04:55 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:28632
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S272362AbTHIOEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:04:53 -0400
Date: Sat, 9 Aug 2003 10:04:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: PATCH 2.6: fix X86_VENDOR_ID offset in head.S
Message-ID: <20030809140452.GA5268@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing my 2.4 backport of the 2.6 cpu capabilities (including
the Via RNG support), Mikael Pettersson noticed a bug in both my
backport, and 2.6:  when NCAPINTS (x86_capability array size) is
increased, one must adjust the offset in arch/i386/kernel/head.S also.

Contributed by Mikael Pettersson.


===== arch/i386/kernel/head.S 1.27 vs edited =====
--- 1.27/arch/i386/kernel/head.S	Mon May 12 21:59:20 2003
+++ edited/arch/i386/kernel/head.S	Sat Aug  9 09:59:50 2003
@@ -35,7 +35,7 @@
 #define X86_HARD_MATH	CPU_PARAMS+6
 #define X86_CPUID	CPU_PARAMS+8
 #define X86_CAPABILITY	CPU_PARAMS+12
-#define X86_VENDOR_ID	CPU_PARAMS+28
+#define X86_VENDOR_ID	CPU_PARAMS+36
 
 /*
  * Initialize page tables

