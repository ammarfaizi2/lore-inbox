Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVHLSUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVHLSUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVHLSTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:19:45 -0400
Received: from fmr23.intel.com ([143.183.121.15]:50310 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750855AbVHLSTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:19:24 -0400
Date: Fri, 12 Aug 2005 11:19:16 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>,
       linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
Message-ID: <20050812111916.A15541@unix-os.sc.intel.com>
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel> <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com> <20050812133248.GN8974@wotan.suse.de> <42FCA97E.5010907@fujitsu-siemens.com> <42FCB86C.5040509@fujitsu-siemens.com> <20050812145725.GD922@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050812145725.GD922@wotan.suse.de>; from ak@suse.de on Fri, Aug 12, 2005 at 04:57:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 04:57:25PM +0200, Andi Kleen wrote:
> On Fri, Aug 12, 2005 at 04:55:40PM +0200, Martin Wilck wrote:
> > I wrote:
> > 
> > >>How so? The XAPIC version check should work there.
> > >
> > >ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
> > >Processor #33 15:4 APIC version 16
> > >ACPI: LAPIC (acpi_id[0x12] lapic_id[0x26] enabled)
> > >Processor #38 15:4 APIC version 16
> > 
> > Forget it. I have fallen prey to  this line:
> > 
> > 	processor.mpc_apicver = 0x10; /* TBD: lapic version */
> > 
> > in arch/x86_64/kernel/mpparse.c.
> > I am used to get correct answers from Linux :-)
> 
> Heh. Should probably fix that. Can you file a bug with the ACPI
> people on http://bugzilla.kernel.org ? (or do a patch?)

Here is the patch.

--
Fix the apic version that gets printed during boot. 

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.13-rc6/arch/x86_64/kernel/mpparse.c~	2005-08-12 10:19:07.037696416 -0700
+++ linux-2.6.13-rc6/arch/x86_64/kernel/mpparse.c	2005-08-12 10:19:38.098974384 -0700
@@ -707,7 +707,7 @@
 
 	processor.mpc_type = MP_PROCESSOR;
 	processor.mpc_apicid = id;
-	processor.mpc_apicver = 0x10; /* TBD: lapic version */
+	processor.mpc_apicver = GET_APIC_VERSION(apic_read(APIC_LVR));
 	processor.mpc_cpuflag = (enabled ? CPU_ENABLED : 0);
 	processor.mpc_cpuflag |= (boot_cpu ? CPU_BOOTPROCESSOR : 0);
 	processor.mpc_cpufeature = (boot_cpu_data.x86 << 8) | 
