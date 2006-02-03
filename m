Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWBCHSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWBCHSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 02:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWBCHSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 02:18:37 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:29365 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932487AbWBCHSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 02:18:37 -0500
Date: Fri, 3 Feb 2006 02:02:37 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch -mm4] i386: fall back to sensible CPU model name
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>
Message-ID: <200602030207_MC3-1-B773-7C81@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When vendor-specific i386 initialization code is unavailable
the kernel falls back to a default CPU model name. Make that
model name reflect the CPU family instead of an internal vendor
index.

Tested on Pentium II (family 6 model 5).

/proc/cpuinfo before:
        model name     : ff/05

after:
        model name     : 06/05

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/cpu/common.c
@@ -426,7 +426,7 @@ void __cpuinit identify_cpu(struct cpuin
 		else
 			/* Last resort... */
 			sprintf(c->x86_model_id, "%02x/%02x",
-				c->x86_vendor, c->x86_model);
+				c->x86, c->x86_model);
 	}
 
 	/* Now the feature flags better reflect actual CPU features! */
-- 
Chuck
