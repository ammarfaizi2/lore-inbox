Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbSJPEfR>; Wed, 16 Oct 2002 00:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbSJPEfR>; Wed, 16 Oct 2002 00:35:17 -0400
Received: from packet.digeo.com ([12.110.80.53]:40178 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264918AbSJPEfP>;
	Wed, 16 Oct 2002 00:35:15 -0400
Message-ID: <3DACEDE0.7FB25F02@digeo.com>
Date: Tue, 15 Oct 2002 21:41:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 04:41:05.0302 (UTC) FILETIME=[3CDD5B60:01C274CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> A huge merging frenzy for the feature freeze,

Doesn't compile on ia32 uniprocessor.  The owner of
changeset 1.852 is hereby debited 31 CPUs.

Also, non-IO_APIC kernels have not been linking for some time.

Here is a quick fix for both problems.



 include/asm-i386/apic.h |    4 ++--
 include/asm-i386/smp.h  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- 2.5.43/include/asm-i386/smp.h~mpparse-fix	Tue Oct 15 21:26:18 2002
+++ 2.5.43-akpm/include/asm-i386/smp.h	Tue Oct 15 21:26:31 2002
@@ -37,6 +37,7 @@
  #endif /* CONFIG_CLUSTERED_APIC */
 #endif 
 
+#define BAD_APICID 0xFFu
 #ifdef CONFIG_SMP
 #ifndef __ASSEMBLY__
 
@@ -65,7 +66,6 @@ extern void zap_low_mappings (void);
  * the real APIC ID <-> CPU # mapping.
  */
 #define MAX_APICID 256
-#define BAD_APICID 0xFFu
 extern volatile int cpu_to_physical_apicid[NR_CPUS];
 extern volatile int physical_apicid_to_cpu[MAX_APICID];
 extern volatile int cpu_to_logical_apicid[NR_CPUS];
--- 2.5.43/include/asm-i386/apic.h~mpparse-fix	Tue Oct 15 21:34:03 2002
+++ 2.5.43-akpm/include/asm-i386/apic.h	Tue Oct 15 21:34:05 2002
@@ -7,8 +7,6 @@
 #include <asm/apicdef.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_X86_LOCAL_APIC
-
 #define APIC_DEBUG 0
 
 #if APIC_DEBUG
@@ -17,6 +15,8 @@
 #define Dprintk(x...)
 #endif
 
+#ifdef CONFIG_X86_LOCAL_APIC
+
 /*
  * Basic functions accessing APICs.
  */

.
