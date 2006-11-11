Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966024AbWKKLMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966024AbWKKLMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966118AbWKKLMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:12:16 -0500
Received: from www.osadl.org ([213.239.205.134]:6308 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S966024AbWKKLMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:12:15 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200611101029.59251.ak@suse.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061110085728.GA14620@elte.hu> <20061110011336.008840cf.akpm@osdl.org>
	 <200611101029.59251.ak@suse.de>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 12:14:37 +0100
Message-Id: <1163243677.8335.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 10:29 +0100, Andi Kleen wrote:
> > But that's different.
> > 
> > We're limping along in a semi-OK fashion with the TSC.  But now Thomas is
> > proposing that we effectively kill it off for all x86 because of hrtimers.
> 
> I'm totally against that.

I'm working on that. The general disable is indeed overkill. All I need
to prevent is to switch over to highres/dyntick in case that there is no
fallback (e.g. pm_timer) available. Else I end up in a circular
dependency as the emulated tick depends on the monotonic clock.
 
> > And afaict the reason for that is that we're using jiffies to determine if
> > the TSC has gone bad, and that test is getting false positives.
> 
> The i386 clocksource had always trouble with that. e.g.  I have a box
> where the TSC works perfectly fine on a 64bit kernel, but since the new i386
> clocksource code is in it always insists on disabling it shortly after boot.
> My guess is that some of the checks in there are just broken and need
> to be fixed.

It's the unconditional mark_unstable call in ACPI C2 state. /me looks.

	tglx


