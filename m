Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754094AbWKGIIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbWKGIIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbWKGIIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:08:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:19884 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754094AbWKGIIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:08:30 -0500
Date: Tue, 7 Nov 2006 09:07:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Len Brown <lenb@kernel.org>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061107080733.GB9910@elte.hu>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain> <20061106205825.GA26755@rhlx01.hs-esslingen.de> <200611070141.16593.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611070141.16593.len.brown@intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Len Brown <len.brown@intel.com> wrote:

> So given that C3 on every known system that has shipped to date breaks 
> the LAPIC timer (and apparently this applies to C2 on these AMD 
> boxes), dynticks needs a solid story for co-existing with C3.

check out 2.6.19-rc4-mm2: it detects this breakage and works it around 
by using the PIT as a clock-events source. That did the trick on my 
laptop which has this problem too. I agree with you that degrading the 
powersaving mode is not an option.

we've got a question about HPET: it seems all recent hardware has it, 
but the BIOS rarely mentions it, so the Linux driver does not enable 
HPET. Is there any chance to enable HPET (in the chipset?) - this would 
probably be a higher-quality clock-events source than the PIT.

	Ingo
