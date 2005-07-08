Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbVGHJqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVGHJqy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 05:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVGHJpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 05:45:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61156 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262406AbVGHJpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 05:45:45 -0400
Date: Fri, 8 Jul 2005 11:45:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-08
Message-ID: <20050708094531.GA5515@elte.hu>
References: <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507070120100.22287@echo.lysdexia.org> <20050708092343.GA32586@elte.hu> <20050708092928.GA4135@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708092928.GA4135@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > > -51-06 and -51-08 are looking stable on the UP Athlon box with the 
> > > following patch which causes edge triggered hardirqs to be masked when 
> > > pending _and/or_ disabled (instead of both pending _and_ disabled) and 
> > > backs out a change from -50-44 that prevents pending edge triggered 
> > > irqs from being unmasked:
> > 
> > ok, you are right, the edge case was mishandled - but i think it was 
> > already mishandled upstream, we just never (or rarely) triggered it.  
> > I've reworked this area based on your patch, could you check -51-15, 
> > does it work for you?
> 
> if it doesnt work, could you disable CONFIG_X86_IOAPIC_FAST?

or rather, please try -51-16. One of my testsystems produced weird 
interrupt storms, which were caused by the IOAPIC_POSTFLUSH 
optimization. In -51-16 i've turned that optimization off, globally.  
Maybe this explains some of the other lockups reported.

	Ingo
