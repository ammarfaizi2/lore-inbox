Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937228AbWLFT3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937228AbWLFT3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937200AbWLFT3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:29:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:39867 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937167AbWLFT27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:28:59 -0500
Subject: Re: PMTMR running too fast
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Ian Campbell <ijc@hellion.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <200612061744.47249.ak@suse.de>
References: <1165153834.5499.40.camel@localhost.localdomain>
	 <1165259962.6152.5.camel@localhost.localdomain>
	 <200612061744.47249.ak@suse.de>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 11:28:48 -0800
Message-Id: <1165433328.6729.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-06 at 17:44 +0100, Andi Kleen wrote:
> >
> > > Is there a specific reason the check was removed (I couldn't see on in
> > > the archives) or was it simply overlooked? Without it I need to pass
> > > clocksource=tsc to have 2.6.18 work correctly on an older K6 system with
> > > an Aladdin chipset (will dig out the precise details if required). Would
> > > a patch to reintroduce the check be acceptable or would some sort of
> > > blacklist based solution be more acceptable?
> >
> > If I recall correctly, it was pulled because there was some question as
> > to if it was actually needed (x86_64 didn't need it) and it slows down
> > the boot time (although not by much).
> >
> > I'm fine just re-adding it. Although if the number of affected systems
> > are small we could just blacklist it (Ian, mind sending dmidecode
> > output?).
> >
> > Andi, your thoughts?
> 
> Doing a check at boot time is fine for me. Just I don't want the
> "read pmtmr three times at runtime" code anywhere near x86-64

:) This change fully disqualifies the ACPI PM if its running at the
wrong frequency, so no worries there.

> I don't think the boot time check needs DMI guarding

DMI guarding? I'm not following...

> But BTW the check is not necessarily enough -- there is at least one
> NF3 machine around where the PIT timer ticks at a wrong frequency.
> Safer would be probably to calibrate against RTC which is afaik used
> by Windows too (so it's likely to be ok)

Hmm.. I might lean towards pushing the patch closer to as it is, as
we're just restoring functionality that was there before in 2.6.17.  The
NF3 system already needs bits to correct for the PIT frequency, so it
seems that code could also correct the mach_countup() routines.

Even so, I do agree with you that moving to utilize more "widely tested"
hardware for calibration would be a good thing.

thanks
-john


