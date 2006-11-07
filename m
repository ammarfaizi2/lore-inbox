Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754139AbWKGJ0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbWKGJ0x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbWKGJ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:26:53 -0500
Received: from www.osadl.org ([213.239.205.134]:52894 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1754139AbWKGJ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:26:52 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107091628.GA5399@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162830033.4715.201.camel@localhost.localdomain>
	 <20061106205825.GA26755@rhlx01.hs-esslingen.de>
	 <200611070141.16593.len.brown@intel.com> <20061107080733.GB9910@elte.hu>
	 <1162887935.4715.349.camel@localhost.localdomain>
	 <20061107091628.GA5399@rhlx01.hs-esslingen.de>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 10:28:57 +0100
Message-Id: <1162891737.4715.354.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 10:16 +0100, Andreas Mohr wrote:
> Hi,
> 
> On Tue, Nov 07, 2006 at 09:25:35AM +0100, Thomas Gleixner wrote:
> > Andreas tested with the latest -mm1-hrt-dyntick patches, so he has all
> > the checks already. The thing which worries me here is, that we detect
> > the breakage and use the fallback path already, but it still has this
> > weird effect on that system, while others just work fine. I'm cooking a
> > more brute force fallback right now.
> 
> That's what I didn't understand all that time:
> I do get the "C2 unusable, kills APIC timer" message, so I expected the code
> to not use C2, but it seems it did use it (causing hangs) and I didn't
> fully analyze the code whether it truly tried to prevent C2 here
> (handling was a bit opaque to me, should have analyzed it
> more thoroughly to get to know exactly what happens).
> 
> And like I said, brutally hard-wiring max_cstate to C1 already fixed
> dynticks things for me, so it seems as if it still touched C2 before.

Yes, it leaves the C states untouched, it uses (should use) PIT instead
of the local APIC timer. I'm a bit confused, why this does not work on
your box.

	tglx


