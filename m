Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbSJQEeg>; Thu, 17 Oct 2002 00:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261784AbSJQEef>; Thu, 17 Oct 2002 00:34:35 -0400
Received: from packet.digeo.com ([12.110.80.53]:24727 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261782AbSJQEed>;
	Thu, 17 Oct 2002 00:34:33 -0400
Message-ID: <3DAE3F38.11C9E4F1@digeo.com>
Date: Wed, 16 Oct 2002 21:40:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.43 IO-APIC bug and spinlock deadlock
References: <20021017033302.GP8159@redhat.com> <20021017042851.GQ8159@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 04:40:24.0533 (UTC) FILETIME=[4EFA4050:01C27597]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> On Wed, Oct 16, 2002 at 11:33:02PM -0400, Doug Ledford wrote:
> > IO-APIC bug: regular kernel, UP, no IO-APIC or APIC on UP enabled, compile
> > fails (does *everyone* run SMP or at least UP + APIC now?)
> 
> OK, this is real.
> 

Linus has merged a patch for this.  Does it work for you?  I don't
think you've sent us any error output.


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
