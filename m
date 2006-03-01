Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWCATcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWCATcJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWCATcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:32:08 -0500
Received: from fmr22.intel.com ([143.183.121.14]:57834 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750987AbWCATcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:32:07 -0500
Date: Wed, 1 Mar 2006 11:31:32 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, laurent.riffard@free.fr,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060301113132.A31349@unix-os.sc.intel.com>
References: <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com> <4404CE39.6000109@liberouter.org> <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com> <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org> <4405723E.5060606@free.fr> <20060301023235.735c8c47.akpm@osdl.org> <20060301032527.1b79fc7c.akpm@osdl.org> <20060301101419.A30674@unix-os.sc.intel.com> <20060301104822.622fe6c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060301104822.622fe6c3.akpm@osdl.org>; from akpm@osdl.org on Wed, Mar 01, 2006 at 10:48:22AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 10:48:22AM -0800, Andrew Morton wrote:
> > -static unsigned int __devinitdata num_processors;
> > +unsigned int __cpuinitdata num_processors;
> 
> We'll need more than that - the compile failed due to a missing declaration.



-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Need to make this non-static since we need in acpi_unmap_lsapic
shared function in arch/i386/kernel/acpi/boot.c

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------
 arch/i386/kernel/mpparse.c |    2 +-
 include/asm-i386/smp.h     |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.16-rc5-mm1/arch/i386/kernel/mpparse.c
===================================================================
--- linux-2.6.16-rc5-mm1.orig/arch/i386/kernel/mpparse.c
+++ linux-2.6.16-rc5-mm1/arch/i386/kernel/mpparse.c
@@ -75,7 +75,7 @@ unsigned int def_to_bigsmp = 0;
 /* Processor that is doing the boot up */
 unsigned int boot_cpu_physical_apicid = -1U;
 /* Internal processor count */
-static unsigned int __devinitdata num_processors;
+unsigned int __cpuinitdata num_processors;
 
 /* Bitmask of physically existing CPUs */
 physid_mask_t phys_cpu_present_map;
Index: linux-2.6.16-rc5-mm1/include/asm-i386/smp.h
===================================================================
--- linux-2.6.16-rc5-mm1.orig/include/asm-i386/smp.h
+++ linux-2.6.16-rc5-mm1/include/asm-i386/smp.h
@@ -92,6 +92,7 @@ static __inline int logical_smp_processo
 
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
+extern unsigned int num_processors;
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
