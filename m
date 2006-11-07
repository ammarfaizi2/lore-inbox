Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753256AbWKGW1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbWKGW1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbWKGW1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 17:27:14 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:25502 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1753256AbWKGW1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 17:27:13 -0500
Date: Tue, 7 Nov 2006 23:27:11 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061107222711.GA22612@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain> <20061106205825.GA26755@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com> <20061107080733.GB9910@elte.hu> <1162887935.4715.349.camel@localhost.localdomain> <20061107091628.GA5399@rhlx01.hs-esslingen.de> <1162891737.4715.354.camel@localhost.localdomain> <1162892758.4715.362.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162892758.4715.362.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 07, 2006 at 10:45:58AM +0100, Thomas Gleixner wrote:
> On Tue, 2006-11-07 at 10:28 +0100, Thomas Gleixner wrote:
> > Yes, it leaves the C states untouched, it uses (should use) PIT instead
> > of the local APIC timer. I'm a bit confused, why this does not work on
> > your box.
> 
> Can you try the patch below please ? I just noticed, that the local APIC
> gets reprogrammed before we switch back from PIT, which is perfectly
> fine, but maybe your box does not like that treatment. If this does not
> help, I'm going to do the never switch back from PIT hackery which I
> wanted to avoid for performance reasons.

I applied the patch, the changes *are* in the tree and I did create and
install a new image (with CONFIG_NO_HZ re-enabled and C1 hard-wiring removed),
but it failed again, completely. The usual hang during boot with
keyboard activity required, and then it didn't even manage to finish booting
(I probably was too slow in generating the necessary amount of events).

Let me think a bit about that stuff, maybe I'll be able to figure out what's
happening on my system. Or any other ideas?
(since I would like to somehow get this resolved without less than perfect
workarounds if possible)

Andreas Mohr
