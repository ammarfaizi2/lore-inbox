Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754134AbWKGJQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbWKGJQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754133AbWKGJQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:16:31 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:32393 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1754134AbWKGJQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:16:30 -0500
Date: Tue, 7 Nov 2006 10:16:28 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061107091628.GA5399@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain> <20061106205825.GA26755@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com> <20061107080733.GB9910@elte.hu> <1162887935.4715.349.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162887935.4715.349.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 07, 2006 at 09:25:35AM +0100, Thomas Gleixner wrote:
> Andreas tested with the latest -mm1-hrt-dyntick patches, so he has all
> the checks already. The thing which worries me here is, that we detect
> the breakage and use the fallback path already, but it still has this
> weird effect on that system, while others just work fine. I'm cooking a
> more brute force fallback right now.

That's what I didn't understand all that time:
I do get the "C2 unusable, kills APIC timer" message, so I expected the code
to not use C2, but it seems it did use it (causing hangs) and I didn't
fully analyze the code whether it truly tried to prevent C2 here
(handling was a bit opaque to me, should have analyzed it
more thoroughly to get to know exactly what happens).

And like I said, brutally hard-wiring max_cstate to C1 already fixed
dynticks things for me, so it seems as if it still touched C2 before.

Andreas Mohr
