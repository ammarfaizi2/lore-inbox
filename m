Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278470AbRKHVbU>; Thu, 8 Nov 2001 16:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278579AbRKHVbK>; Thu, 8 Nov 2001 16:31:10 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60403 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S278470AbRKHVay>; Thu, 8 Nov 2001 16:30:54 -0500
Message-ID: <3BEAF962.8E407C30@mvista.com>
Date: Thu, 08 Nov 2001 13:30:10 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Jonas Diemer <diemer@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: VIA 686 timer bugfix incomplete
In-Reply-To: <20011107211445.A2286@suse.cz> <Pine.LNX.4.05.10111080917140.19515-100000@marina.lowendale.com.au> <20011108090215.G3708@suse.cz> <20011108102124.31ca040f.diemer@gmx.de> <20011108210840.A6266@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Thu, Nov 08, 2001 at 10:21:24AM +0100, Jonas Diemer wrote:
> 
> > Well, then maybe Vojtech's suggestion is best: use RTC for timing, not the
> > chipset...
> > as to my knowledge, every i38 system has a standard RTC, so why not use this? or
> > even better: make an option in the config to choose whether use RTC or the
> > chipset.
> 
> There is a little problem with RTC, though:
> 
> While you can set it up to generate interrupts at say 1024 Hz, you can't
> read any value of how much time passed since last interrupt. You can do
> this on the PIT (i8253), and this is the part that is buggy.
> 
> TSC is perfect, precise and accurate, but not reliable in long term.
> Some CPUs do thermal throttling, notebooks play with CPU speed, etc,
> etc. And it's not synchronized to any interrupt source.
> 
> Ugly, ugly, ugly is the PC architecture.
> 
Me thinks the real solution is the ACPI pm timer.  3 times the
resolution of the PIT and you can not stop it.  The high-res-timers
patch will allow you to use this as the time keeper and just use the PIT
to generate interrupts.

Finding the ACPI pm timer, on the other hand, is MOST obscure and not
all x86 platforms have ACPI.  Still, we are almost there.

George
