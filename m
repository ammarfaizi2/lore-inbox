Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWFRQAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWFRQAI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWFRQAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:00:08 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:56716 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932146AbWFRQAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:00:07 -0400
Date: Sun, 18 Jun 2006 11:55:58 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 11/16] 2.6.17-rc6 perfmon2 patch for review: new
  i386 files
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606181158_MC3-1-C2CA-FA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606180724.08069.kevcorry@us.ibm.com>
References: <200606180724.08069.kevcorry@us.ibm.com>

[mailer forgot to copy l-k, resending just to there with updates]

On Sun, 18 Jun 2006 07:24:07 -0500, Kevin Corry wrote:

> > What do I pick for i386 kernel on Athlon64 hardware?  P6?  There's no help
> > for that (or Athlon/Sempron processors.)
> 
> P6 is only for Intel Pentium-Pro, Pentium-II, Pentium-III, and Pentium-M.
>
> See arch/x86_64/perfmon/Kconfig for the config options for AMD Athlon64 and 
> Intel EM64T.

What I want is K8 perfmon counters on i386 kernel.  This seems to
work.  (Can it be this easy?  The counters really do work.)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-rc6-32-pfmon.orig/arch/i386/perfmon/Kconfig
+++ 2.6.17-rc6-32-pfmon/arch/i386/perfmon/Kconfig
@@ -8,6 +8,15 @@ config PERFMON
  	  in the kernel. See <http://perfmon2.sf.net/> for
  	  more details. If you're unsure, say Y.
 
+config I386_PERFMON_K8
+	tristate "Support AMD X86-64/Sempron generic hardware performance counters"
+	depends on PERFMON
+	default m
+	help
+	Enables support for the generic AMD X86-64/Sempron hardware
+	performance counters.
+	If unsure, say m.
+
  config PERFMON_P6
 	tristate "Support for P6/Pentium M processor hardware performance counters"
 	depends on PERFMON
--- 2.6.17-rc6-32-pfmon.orig/arch/i386/perfmon/Makefile
+++ 2.6.17-rc6-32-pfmon/arch/i386/perfmon/Makefile
@@ -3,7 +3,10 @@
 # Contributed by Stephane Eranian <eranian@hpl.hp.com>
 #
 obj-$(CONFIG_PERFMON)		+= perfmon.o
+obj-$(CONFIG_I386_PERFMON_K8)	+= perfmon_amd.o
 obj-$(CONFIG_PERFMON_P6)	+= perfmon_p6.o
 obj-$(CONFIG_PERFMON_P4)	+= perfmon_p4.o
 obj-$(CONFIG_PERFMON_GEN_IA32)	+= perfmon_gen_ia32.o
 obj-$(CONFIG_PERFMON_P4_PEBS)	+= perfmon_p4_pebs_smpl.o
+
+perfmon_amd-$(subst m,y,$(CONFIG_I386_PERFMON_K8)) += ../../x86_64/perfmon/perfmon_amd.o
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
