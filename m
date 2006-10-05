Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWJEU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWJEU6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWJEU6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:58:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:31116 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750996AbWJEU57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:57:59 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
	<20061005011608.b69e3461.akpm@osdl.org>
	<20061005081725.GA28877@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 05 Oct 2006 22:57:24 +0200
In-Reply-To: <20061005081725.GA28877@elte.hu>
Message-ID: <p73fye2zdjf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > With CONFIG_HIGH_RES_TIMERS=y, CONFIG_NO_HZ=n it's pretty sick.  It 
> > pauses for several seconds after "input: AlpsPS/2 ALPS GlidePoint as 
> > /class/input/input2" (printk-time claims 2 seconds, but it was longer 
> > than that).
> > 
> > It's been stuck for a minute or more at the 12.980000 time, seems to 
> > have hung.  The cursor is flashing extremely slowly.
> 
> ah, that's still the VAIO, right? Do you get a 'slow' LOC count on 
> /proc/interrupts even on a stock kernel? If yes then that's a 
> fundamentally sick local APIC timer interrupt. Stock kernel should show 
> sickness too, if for example you boot an SMP kernel on it - can you 
> confirm that? (the UP-IOAPIC only relies for profiling on the lapic 
> timer, so there the only sickness you should see on the stock kernel is 
> a non-working readprofile)

When I was hacking on my old noidletick patch I ran into this
problem on several machines too.

But usually the problem wasn't that it was too slow, but that
it completely stopped in C2 or deeper. I don't think there
is a way to work around that except for not using C2 or deeper
(not an option) or using a different timer source.

If that is true then hitting space lots of time will make it 
go faster.

-andi
