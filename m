Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUFJAwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUFJAwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUFJAwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:52:08 -0400
Received: from fmr06.intel.com ([134.134.136.7]:47796 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S266067AbUFJAwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:52:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: 2.6.7-rc3-mm1
Date: Wed, 9 Jun 2004 17:51:54 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024055CD986@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.7-rc3-mm1
Thread-Index: AcROgaPkZIFMkLt8R5agov7SJp87OAAALkxg
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 10 Jun 2004 00:51:55.0249 (UTC) FILETIME=[20490610:01C44E85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
On Wed, Jun 09, 2004 at 01:35:15PM -0300, Norberto Bensa wrote:
>Hello,
>
>Andrew Morton wrote:
>>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/
2.6
>>.7-rc3-mm1/
>
>  CC      drivers/pci/msi.o
>drivers/pci/msi.c: In function `msi_address_init':
>drivers/pci/msi.c:265: error: invalid operands to binary <<
>make[2]: *** [drivers/pci/msi.o] Error 1
>make[1]: *** [drivers/pci] Error 2
>make: *** [drivers] Error 2
>
>The offending line is:
>
>        msi_address->lo_address.value |= (MSI_TARGET_CPU <<
MSI_TARGET_CPU_SHIFT);

Somehow the change in TARGET_CPUS generated this error in UP
environment. Patch
below will fix it. 

Thanks,
Long

------------------------------------------------------------------------
-----------

diff -urN linux-2.6.7-rc3-mm1/include/asm-i386/msi.h
2.6.7-rc3-mm1-fix/include/asm-i386/msi.h
--- linux-2.6.7-rc3-mm1/include/asm-i386/msi.h	2004-05-09
22:32:52.000000000 -0400
+++ 2.6.7-rc3-mm1-fix/include/asm-i386/msi.h	2004-06-09
17:21:07.000000000 -0400
@@ -16,7 +16,7 @@
 #ifdef CONFIG_SMP
 #define MSI_TARGET_CPU		logical_smp_processor_id()
 #else
-#define MSI_TARGET_CPU		TARGET_CPUS
+#define MSI_TARGET_CPU	cpu_to_logical_apicid(first_cpu(cpu_online_map))
 #endif
 
 #endif /* ASM_MSI_H */

