Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbSJXRME>; Thu, 24 Oct 2002 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265560AbSJXRME>; Thu, 24 Oct 2002 13:12:04 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:12812 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265559AbSJXRMC>; Thu, 24 Oct 2002 13:12:02 -0400
Date: Thu, 24 Oct 2002 18:18:15 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
Message-ID: <20021024171815.GA6920@compsoc.man.ac.uk>
References: <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB81376.90403@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:36:22AM -0500, Corey Minyard wrote:

> Is there any way to detect if the nmi watchdog actually caused the 
> timeout?  I don't understand the hardware well enough to do it without 

You can check if the counter used overflowed :

#define CTR_OVERFLOWED(n) (!((n) & (1U<<31)))
#define CTRL_READ(l,h,msrs,c) do {rdmsr(MSR_P6_PERFCTR0, (l), (h));} while (0)

                CTR_READ(low, high, msrs, i);
                if (CTR_OVERFLOWED(low)) {
			... found

like oprofile does.

I've accidentally deleted your patch, but weren't you unconditionally
returning "break out of loop" from the watchdog ? I'm not very clear on
the difference between NOTIFY_DONE and NOTIFY_OK anyway...

> Plus, can't you get more than one cause of an NMI?  Shouldn't you check 
> them all?

Shouldn't the NMI stay asserted ? At least with perfctr, two counters
causes two interrupts (actually there's a bug in mainline oprofile on
that that I'll fix when Linus is back)

regards
john
-- 
"This is playing, not work, therefore it's not a waste of time."
	- Zath
