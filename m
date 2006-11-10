Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946015AbWKJIHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946015AbWKJIHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946019AbWKJIHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:07:49 -0500
Received: from www.osadl.org ([213.239.205.134]:56007 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1946015AbWKJIHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:07:48 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@suse.de>
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200611100610.13957.ak@suse.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.569684000@cruncher.tec.linutronix.de>
	 <1163121045.836.69.camel@localhost>  <200611100610.13957.ak@suse.de>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 09:10:06 +0100
Message-Id: <1163146206.8335.183.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 06:10 +0100, Andi Kleen wrote:
> > >  		verify_tsc_freq_timer.function = verify_tsc_freq;
> > >  		verify_tsc_freq_timer.expires =
> > 
> > 
> > Hmmm. I wish this patch was unnecessary, but I don't see an easy
> > solution. 
> 
> Very sad. This will make a lot of people unhappy, even to the point
> where they might prefer disabling noidlehz over super slow gettimeofday. 
> I assume you at least have a suitable command line option for that, right?

Yes it is sad. And the sadest part is that AMD and Intel have been asked
to fix that more than 5 years ago. They did not get their brain straight
and now we are the dimwits.

> Can we get a summary on which systems the TSC is considered unstable?
> Normally we assume if it's stable enough for gettimeofday it should
> be stable enough for longer delays too.

TSC is simply a nightmare:

- Frequency changes with CPU clock
- Unsynced across CPUs
- Stops in C3, which makes it completely unusable

Once you take away periodic interrupts it is simply broken. AMD and
Intel can run in circels, it does not get better.

	tglx




