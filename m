Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUAEWyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUAEWyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:54:05 -0500
Received: from hell.org.pl ([212.244.218.42]:39177 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S265986AbUAEWxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:53:55 -0500
Date: Mon, 5 Jan 2004 23:54:00 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040105225400.GA5495@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <1073340716.15645.96.camel@cog.beaverton.ibm.com> <20040105221758.GA13727@hell.org.pl> <1073341969.15645.106.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1073341969.15645.106.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote john stultz:
> > > If the override boot option failed, its most likely your system doesn't
> > > have an ACPI PM time source.  Instead it seems your system is having
> > Well, I don't have the slightest idea on how to determine this, though I
> > read somewhere that all ACPI-compliant systems have those.
> More debug output is probably needed. 

I'll be happy to provide it :)

> > > trouble using the PIT as a time source (which seems not all that
> > > uncommon unfortunately). 
> > Perhaps, though bear in mind it behaves so only if clock=pmtmr has been
> > appended and works fine with clock=pit.
> Ah, I must have missed that point. Indeed that is very odd. When booting
> without the clock= what time source is used? Does booting w/
> "clock=crazy" also show the problem?

It depends -- generally either PIT (that's 2.4) or TSC, the latter switches
back to PIT once CPUFreq is used. I've never seen any problems with the
bogomips loop or /proc/cpuinfo, except when it could be directly attributed
to CPUFreq bugs.

I booted the following with clock=crazy:
1) 2.6.1-rc1-mm1 with Dmitry's patch: deadlock as before
2) 2.6.0-test11-almost vanilla (Nigel's swsusp patches): passed, results
   similar to -rc1-mm1 vanilla, i.e. cpuinfo shows 0 MHz and bogomips is
   miscalculated.

So it seems to be a more generic problem.
2.6.1-rc1 is on the way.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
