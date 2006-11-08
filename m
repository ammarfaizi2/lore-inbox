Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754571AbWKHM2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbWKHM2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbWKHM2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:28:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45025 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754565AbWKHM2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:28:53 -0500
Date: Wed, 8 Nov 2006 13:28:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: + i386-lapic-timer-calibration.patch added to -mm tree
Message-ID: <20061108122826.GA23268@elte.hu>
References: <200611012045.kA1KjM1p018949@shell0.pdx.osdl.net> <20061108120914.GB19843@elte.hu> <1162988830.8335.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162988830.8335.33.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2006-11-08 at 13:09 +0100, Ingo Molnar wrote:
> > one question:
> > 
> > > +	long tapic = apic_read(APIC_TMCCT);
> > > +	unsigned long pm = acpi_pm_read_early();
> > 
> > is this function call safe if the box has no pm-timer?
> 
> That's in the pm-timer-allow-early-access.patch:
> 
> Subject: pmtimer: Allow early access to pm timer
> 
> +static inline u32 acpi_pm_read_early(void)
> +{
> +       if (!pmtmr_ioport)
> +               return 0;
> +       /* mask the output to 24 bits */
> +       return acpi_pm_read_verified();
> +}
> 
> If pmtmr is not available, the function returns 0, so the resulting 
> delta is 0 and therefor ignored. Same applies, when PMTIMER is 
> disabled in the config.

ok, looks good.

	Ingo
