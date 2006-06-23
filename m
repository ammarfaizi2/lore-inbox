Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWFWVRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWFWVRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbWFWVRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:17:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38836 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751965AbWFWVRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:17:13 -0400
Message-ID: <449C598B.7070803@redhat.com>
Date: Fri, 23 Jun 2006 17:13:47 -0400
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: perfmon@napali.hpl.hp.com, oprofile-list@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
Subject: Re: [perfmon] 2.6.17.1 new perfmon code base, libpfm, pfmon available
References: <20060621142447.GA29389@frankl.hpl.hp.com>
In-Reply-To: <20060621142447.GA29389@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

Some quick questions about the current perfmon code.


The athlon has very similar hw to the amd64 and there is now 32-bit
x86-64 support. Wouldn't it make sense to move perfmon_amd.c to i386
and have it work in the same way as perfmon_p4.c does currently for p4
and em64t?

Could the 32-bit and 64-bit code be combined in a manner similar to
oprofile and avoid duplication between perfmon_em64t_pebs.c and
perfmon_p4_pebs.c?  pfm_{p4|em64}_ds_area and
pfm_{p4|em64t}_pebs_sample_entry have differences due to the upgrade
from 32 to 64 bit values.

Why isn't Intel family 0xf model 3 not supported?
	Model 1,2, 4, and 5 are supported.
	Model 3 Pentium4 isn't that different is it?

Why the following patch in the code and array using this constant in
sys_pfm_write_pmcs and sys_pfm_write_pmds? The the p4/em64t certainly
has more registers than that.

--- linux-2.6.17.1.old/include/asm-i386/perfmon.h	2006-06-21 
05:19:04.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/perfmon.h	2006-06-21 
04:22:51.000000000 -0700
@@ -18,6 +18,14 @@

  #ifdef __KERNEL__

+#ifdef CONFIG_4KSTACKS
+#define PFM_ARCH_PMD_ARG	2
+#define PFM_ARCH_PMC_ARG	2
+#else
+#define PFM_ARCH_PMD_ARG	4
+#define PFM_ARCH_PMC_ARG	4
+#endif
+
  #include <asm/desc.h>
  #include <asm/apic.h>


What is the purpose of PFM_MAX_XTRA_PMCS and PFM_MAX_XTRA_PMDS? Are
they used for anything other than increasing the size of PFM_MAX_PMCS
and PFM_MAX_PMDS?


-Will
