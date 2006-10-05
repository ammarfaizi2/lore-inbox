Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWJEVHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWJEVHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWJEVHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:07:05 -0400
Received: from www.osadl.org ([213.239.205.134]:21389 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751359AbWJEVHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:07:03 -0400
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
In-Reply-To: <p73fye2zdjf.fsf@verdi.suse.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
	 <20061005011608.b69e3461.akpm@osdl.org> <20061005081725.GA28877@elte.hu>
	 <p73fye2zdjf.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 23:11:56 +0200
Message-Id: <1160082716.9060.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 22:57 +0200, Andi Kleen wrote:
> > ah, that's still the VAIO, right? Do you get a 'slow' LOC count on 
> > /proc/interrupts even on a stock kernel? If yes then that's a 
> > fundamentally sick local APIC timer interrupt. Stock kernel should show 
> > sickness too, if for example you boot an SMP kernel on it - can you 
> > confirm that? (the UP-IOAPIC only relies for profiling on the lapic 
> > timer, so there the only sickness you should see on the stock kernel is 
> > a non-working readprofile)
> 
> When I was hacking on my old noidletick patch I ran into this
> problem on several machines too.
> 
> But usually the problem wasn't that it was too slow, but that
> it completely stopped in C2 or deeper. I don't think there
> is a way to work around that except for not using C2 or deeper
> (not an option) or using a different timer source.
> 
> If that is true then hitting space lots of time will make it 
> go faster.

If that's the case we can even autodetect it and stay with PIT and
ignore lapic all the way.

	tglx


