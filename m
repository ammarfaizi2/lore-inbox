Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318042AbSGLWhr>; Fri, 12 Jul 2002 18:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318043AbSGLWhq>; Fri, 12 Jul 2002 18:37:46 -0400
Received: from holomorphy.com ([66.224.33.161]:34975 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318042AbSGLWhp>;
	Fri, 12 Jul 2002 18:37:45 -0400
Date: Fri, 12 Jul 2002 15:39:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: Martin.Bligh@us.ibm.com
Subject: NUMA-Q breakage 1/7 MAX_IO_APICS too small
Message-ID: <20020712223934.GY25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_IO_APICS is not large enough for NUMA-Q systems. This panics
before console_init().

Fix below.


Cheers,
Bill


===== include/asm-i386/apicdef.h 1.3 vs edited =====
--- 1.3/include/asm-i386/apicdef.h	Wed Mar 27 16:05:30 2002
+++ edited/include/asm-i386/apicdef.h	Fri Jul 12 00:38:00 2002
@@ -108,7 +108,11 @@
 
 #define APIC_BASE (fix_to_virt(FIX_APIC_BASE))
 
+#ifndef CONFIG_MULTIQUAD
 #define MAX_IO_APICS 8
+#else
+#define MAX_IO_APICS 1024
+#endif /* CONFIG_MULTIQUAD */
 
 /*
  * the local APIC register structure, memory mapped. Not terribly well
