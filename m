Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVDCQTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVDCQTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 12:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDCQTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 12:19:32 -0400
Received: from fmr15.intel.com ([192.55.52.69]:44502 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S261813AbVDCQTX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 12:19:23 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] fix subarch breakage in intel_cacheinfo.c
Date: Sun, 3 Apr 2005 09:19:10 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB600462976E@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix subarch breakage in intel_cacheinfo.c
Thread-Index: AcU3r0BKLz2KdYXASmaMCbaTdDPMrQAuSNog
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Apr 2005 16:19:12.0409 (UTC) FILETIME=[DF4DA890:01C53868]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Errr. That was my oversight. I will compile-test the patches 
against all sub-archs in future. Thanks for catching this 
and sending the patch.  

Thanks,
Venki

>-----Original Message-----
>From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
>Sent: Saturday, April 02, 2005 10:10 AM
>To: Andrew Morton
>Cc: Pallipadi, Venkatesh; Linux Kernel
>Subject: [PATCH] fix subarch breakage in intel_cacheinfo.c
>
>Not all x86 subarchitectures have support for hyperthreading, so every
>piece you add for it has to be predicated on checks for CONFIG_X86_HT.
>
>The patch corrects this hyperthreading leakage problem in
>intel_cacheinfo.c
>
>Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
>
>===== arch/i386/kernel/cpu/intel_cacheinfo.c 1.3 vs edited =====
>--- 1.3/arch/i386/kernel/cpu/intel_cacheinfo.c	2005-03-31 
>05:06:44 -06:00
>+++ edited/arch/i386/kernel/cpu/intel_cacheinfo.c	
>2005-04-02 12:03:39 -06:00
>@@ -311,8 +311,10 @@
> 
> 	if (num_threads_sharing == 1)
> 		cpu_set(cpu, this_leaf->shared_cpu_map);
>+#ifdef CONFIG_X86_HT
> 	else if (num_threads_sharing == smp_num_siblings)
> 		this_leaf->shared_cpu_map = cpu_sibling_map[cpu];
>+#endif
> 	else
> 		printk(KERN_INFO "Number of CPUs sharing cache 
>didn't match "
> 				"any known set of CPUs\n");
>
>
>
