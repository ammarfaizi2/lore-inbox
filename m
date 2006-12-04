Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937173AbWLDTTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937173AbWLDTTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937316AbWLDTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:19:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:43221 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937173AbWLDTT2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:19:28 -0500
Subject: Re: PMTMR running too fast
From: john stultz <johnstul@us.ibm.com>
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
In-Reply-To: <1165153834.5499.40.camel@localhost.localdomain>
References: <1165153834.5499.40.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 11:19:22 -0800
Message-Id: <1165259962.6152.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-03 at 13:50 +0000, Ian Campbell wrote:
> In older kernels arch/i386/kernel/timers/timer_pm.c:verify_pmtmr_rate
> contained a check for sensible PMTMR rate and disabled that clocksource
> if it was found to be out of spec[0]. This check seems to have been lost
> in the transition to drivers/clocksource/acpi_pm.c, the removal is in
> 61743fe445213b87fb55a389c8d073785323ca3e "Time: i386 Conversion - part
> 4: Remove Old timer_opts Code"[1] and the check is not present in the
> replacement 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa "Time: i386
> Clocksource Drivers"[2].

Fedora has a bug covering this:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=211902


> Is there a specific reason the check was removed (I couldn't see on in
> the archives) or was it simply overlooked? Without it I need to pass
> clocksource=tsc to have 2.6.18 work correctly on an older K6 system with
> an Aladdin chipset (will dig out the precise details if required). Would
> a patch to reintroduce the check be acceptable or would some sort of
> blacklist based solution be more acceptable?

If I recall correctly, it was pulled because there was some question as
to if it was actually needed (x86_64 didn't need it) and it slows down
the boot time (although not by much). 

I'm fine just re-adding it. Although if the number of affected systems
are small we could just blacklist it (Ian, mind sending dmidecode
output?).

Andi, your thoughts?

thanks
-john


