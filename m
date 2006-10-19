Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946394AbWJSTRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946394AbWJSTRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 15:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946392AbWJSTRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 15:17:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946389AbWJSTRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 15:17:14 -0400
Date: Thu, 19 Oct 2006 15:16:44 -0400
From: Dave Jones <davej@redhat.com>
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: SMP broken on pre-ACPI machine.
Message-ID: <20061019191644.GE26530@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Len Brown <lenb@kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org
References: <20061018222433.GA4770@redhat.com> <200610190133.40581.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610190133.40581.len.brown@intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:33:40AM -0400, Len Brown wrote:
 > On Wednesday 18 October 2006 18:24, Dave Jones wrote:
 > > I've been chasing a bug that got filed against the Fedora kernel
 > > a while back:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=199052
 > > This is a dual pentium pro from an era before we had ACPI, and
 > > it seems to be falling foul of this test in smpboot.c  ..
 > > 
 > >     if (!smp_found_config && !acpi_lapic) {
 > >         printk(KERN_NOTICE "SMP motherboard not detected.\n");
 > > 
 > > My initial reaction is that the !acpi_lapic test should be conditional
 > > on some variable that gets set if the ACPI parsing actually succeeded.
 > 
 > acpi_lapic isn't related to the problem at hand -- that  smp_found_config is not set.

Right, it just seemed odd to me when I was eyeballing this code.

 > That said, allowing acpi_lapic=1 to bail out of this check has the sole
 > function of allowing SMP/PIC configurations.  (smp_found_config
 > in ACPI mode is set if acpi_lapic and acpi_ioapic are set)
 > SMP/PIC configurations are not very interesting, except for debugging.
 > Indeed, MPS prohibits them by mandating an IOAPIC be present for SMP --
 > but ACPI has no such rule.

Why smp_found_config isn't set in that guys configuration is a mystery to me,
as his MPS tables look sane..

MP Table:
#	APIC ID	Version	State		Family	Model	Step	Flags
#	 0	 0x10	 BSP, usable	 6	 2	 1	 0x0381
#	 0	 0x10	 AP, usable	 6	 1	 7	 0xfbff

Hmm, wait, he has unpaired CPUs. I wonder if that's the reason.
I know *some* combinations of PPro's are valid to be paired, but I'll
need to dig out the old docs to be sure.

	Dave

-- 
http://www.codemonkey.org.uk
