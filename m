Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUIBNWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUIBNWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIBNWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:22:12 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15024 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268301AbUIBNWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:22:08 -0400
Date: Thu, 2 Sep 2004 15:23:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Charbonnel <thomas@undata.org>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>,
       Mark_H_Johnson@raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Message-ID: <20040902132342.GA8677@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <1094130969.5652.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094130969.5652.13.camel@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Charbonnel <thomas@undata.org> wrote:

> With ACPI compiled in and booting with acpi=off (which again doesn't
> seem to be honoured), here's another weird one :

> 00010000 0.003ms (+0.000ms): timer_interrupt (generic_handle_IRQ_event)
> 00010001 0.003ms (+2.878ms): mark_offset_tsc (timer_interrupt)
> 00010001 2.882ms (+0.000ms): do_timer (timer_interrupt)

do you have the NMI watchdog enabled? That could help us debugging this. 
Enabling the APIC/IO_APIC and using nmi_watchdog=1 would be the ideal
solution - if that doesnt work then nmi_watchdog=2 would be fine too,
but remove this code from arch/i386/kernel/nmi.c:

	if (nmi_watchdog == NMI_LOCAL_APIC)
		nmi_hz = 1;

(otherwise nmi_watchdog=2 would result in one NMI per second, not enough
to shed light on the above 2.8 msec latency.)

	Ingo
