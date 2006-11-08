Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754564AbWKHMZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbWKHMZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754567AbWKHMZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:25:00 -0500
Received: from www.osadl.org ([213.239.205.134]:36306 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754564AbWKHMY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:24:59 -0500
Subject: Re: + i386-lapic-timer-calibration.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061108120914.GB19843@elte.hu>
References: <200611012045.kA1KjM1p018949@shell0.pdx.osdl.net>
	 <20061108120914.GB19843@elte.hu>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 13:27:10 +0100
Message-Id: <1162988830.8335.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 13:09 +0100, Ingo Molnar wrote:
> one question:
> 
> > +	long tapic = apic_read(APIC_TMCCT);
> > +	unsigned long pm = acpi_pm_read_early();
> 
> is this function call safe if the box has no pm-timer?

That's in the pm-timer-allow-early-access.patch:

Subject: pmtimer: Allow early access to pm timer

+static inline u32 acpi_pm_read_early(void)
+{
+       if (!pmtmr_ioport)
+               return 0;
+       /* mask the output to 24 bits */
+       return acpi_pm_read_verified();
+}

If pmtmr is not available, the function returns 0, so the resulting
delta is 0 and therefor ignored. Same applies, when PMTIMER is disabled
in the config.

	tglx


