Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVC2WCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVC2WCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVC2WCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:02:18 -0500
Received: from smtp3.wanadoo.fr ([193.252.22.28]:20372 "EHLO smtp3.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261467AbVC2WCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:02:12 -0500
X-ME-UUID: 20050329220210807.C53661C00B22@mwinf0302.wanadoo.fr
Subject: Re: Clock 3x too fast on AMD64 laptop [WAS Re: Various issues
	after rebooting]
From: Olivier Fourdan <fourdan@xfce.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1112131714.14248.8.camel@shuttle>
References: <1112039799.6106.16.camel@shuttle>
	 <20050328192054.GV30052@alpha.home.local> <1112038226.6626.3.camel@shuttle>
	 <20050328193921.GW30052@alpha.home.local>
	 <1112131714.14248.8.camel@shuttle>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Wed, 30 Mar 2005 00:02:11 +0200
Message-Id: <1112133731.14248.14.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A quick look at the source shows that the error is triggered in
arch/i386/kernel/timers/timer_pm.c by the verify_pmtr_rate() function.

My guess is that the pmtmr timer is right and the pit is wrong in my
case. That would explain why the clock is wrong when being based on pit
(like when forced with "clock=pit")

Maybe, if I can prove my guesses, a fix could be to "trust" the pmtmr
clock when the user has passed a "clock=pmtmr" argument ? Does that make
any sense ?

TIA
Olivier.



On Tue, 2005-03-29 at 23:28 +0200, Olivier Fourdan wrote:
> Hi all
> 
> Following my own thread, I found the following error in dmesg:
> 
>     PM-Timer running at invalid rate: 33% of normal - aborting.
> 
> I found that interesting because 33% is 1/3 and the clock runs exactly
> 3x faster than normal...
> 
> A bit of search on google gave me several links to posts from other
> people with the exact same problem on similar hardware (AMD64 laptop)
> but I couldn't find neither the cause nor the fix of that issue (as I
> think it might be related to the other issues I observe when the clock
> goes too fast)
> 
> Does that PM-Timer message makes sense to someone knowledgeable?
> 
> Thanks in advance,
> 
> Cheers,
> Olivier.
> 
> On Mon, 2005-03-28 at 21:39 +0200, Willy Tarreau wrote:
> > On Mon, Mar 28, 2005 at 09:30:26PM +0200, Olivier Fourdan wrote:
> > > Hi Willy
> > > 
> > > On Mon, 2005-03-28 at 21:20 +0200, Willy Tarreau wrote:
> > > > Now I have a compaq (nc8000) which does not exhibit such buggy behaviour,
> > > > but you can try disabling the APIC too just in case it's a similar problem
> > > > (at least in 32 bits, I don't know if you can disable it in 64 bits mode).
> > > 
> > > Thanks for the hint, but unfortunately, it's one of the first things I
> > > tried, and that makes no difference.
> > 
> > Sorry, at first I only noticed ACPI in your mail, but after reading it
> > again, I also noticed APIC. So now, you can only try not to initialize
> > some peripherals (IDE, network, display, etc...) by removing their drivers
> > from the kernel. You may end up with a kernel panic, but that does not
> > matter is you boot it with "panic=5" so that it automatically reboots
> > 5 seconds after the panic. You should then finally identify the subsystem
> > which is responsible for your problems. Perhaps you'll even need to remove
> > PCI support :-(
> > 
> > Regards,
> > Willy
> > 
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


