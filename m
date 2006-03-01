Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWCASUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWCASUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWCASUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:20:18 -0500
Received: from fmr21.intel.com ([143.183.121.13]:5299 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750734AbWCASUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:20:17 -0500
Date: Wed, 1 Mar 2006 10:14:20 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060301101419.A30674@unix-os.sc.intel.com>
References: <20060228042439.43e6ef41.akpm@osdl.org> <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com> <4404CE39.6000109@liberouter.org> <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com> <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org> <4405723E.5060606@free.fr> <20060301023235.735c8c47.akpm@osdl.org> <20060301032527.1b79fc7c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060301032527.1b79fc7c.akpm@osdl.org>; from akpm@osdl.org on Wed, Mar 01, 2006 at 03:25:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 03:25:27AM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > If you have (even more) time you could test
> >  http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
> 
> err, don't enable CONFIG_ACPI_HOTPLUG_CPU.
> 
> Ashok, x86_64 and i386 share a lot of code.  Please always perform good
> regression testing against one when developing for the other.
> 
> arch/i386/kernel/acpi/boot.c: In function `acpi_unmap_lsapic':
> arch/i386/kernel/acpi/boot.c:583: `num_processors' undeclared (first use in this function)

Sorry,

here is one to make it non-static for i386 as well. 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


Need to make "num_processors" non-static since we need in acpi_unmap_lsapic
shared function in arch/i386/kernel/acpi/boot.c. Also needs to be __cpuinitdata
now.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
--------------------------------------------------------
 arch/i386/kernel/mpparse.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

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
