Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRBMWSj>; Tue, 13 Feb 2001 17:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131144AbRBMWST>; Tue, 13 Feb 2001 17:18:19 -0500
Received: from colorfullife.com ([216.156.138.34]:32520 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130962AbRBMWSK>;
	Tue, 13 Feb 2001 17:18:10 -0500
Message-ID: <3A89B2A1.E188AF9A@colorfullife.com>
Date: Tue, 13 Feb 2001 23:18:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        Frank de Lange <frank@unternet.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> Hi,
> 
>  After performing various tests I came to the following workaround for
> APIC lockups which people observe under IRQ load, mostly for networking
> stuff.  I believe the test should work in all cases as it basically
> implements a manual replacement for EOI messages.  In my simulated
> environment I was unable to get a lockup with the code in place, even
> though I was getting about every other level-triggered IRQ misdelivered.
> 
>  Please test it extensively, as much as you can, before I submit it for
> inclusion.  If you ever get "Aieee!!!  Remote IRR still set after unlock!"
> message, please report it to me immediately -- it means the code failed.
>
No messages.

> There is also an additional debugging/statistics counter provided in
> /proc/cpuinfo that counts interrupts which got delivered with its trigger
> mode mismatched.  Check it out to find if you get any misdelivered
> interrupts at all.
> 
I'm running my default webserver load test, and I get ~40 /second, 92735
total.

bw_tcp says 1.13 MB/sec, that's wire speed.

tcpdump | grep 'sack ' doesn't show unusually many lost packets.

Look promising.

--
	Manfred
