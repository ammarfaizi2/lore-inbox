Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318048AbSGLWju>; Fri, 12 Jul 2002 18:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSGLWjH>; Fri, 12 Jul 2002 18:39:07 -0400
Received: from holomorphy.com ([66.224.33.161]:38559 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318048AbSGLWi1>;
	Fri, 12 Jul 2002 18:38:27 -0400
Date: Fri, 12 Jul 2002 15:40:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: rml@tech9.net
Subject: NUMA-Q breakage 7/7 preempt vs. printk bootstrap ordering
Message-ID: <20020712224016.GE25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, rml@tech9.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPT creates a bootstrap ordering issue as some implicit
scheduling done in printk.c raises exceptions prior to the secondary
cpus being prepared to handle them (seen as no vm86_info: BAD).

The workaround, enclosed below is not to use preempt on NUMA-Q.


Cheers,
Bill


===== arch/i386/config.in 1.40 vs edited =====
--- 1.40/arch/i386/config.in	Mon Jun 17 07:03:16 2002
+++ edited/arch/i386/config.in	Fri Jul 12 01:12:25 2002
@@ -165,7 +165,9 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
-   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   if [ "$CONFIG_PREEMPT" != "y" ]; then
+      bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   fi
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
