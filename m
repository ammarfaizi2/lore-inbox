Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbVGFUtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVGFUtA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVGFUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:45:13 -0400
Received: from mx1.elte.hu ([157.181.1.137]:59088 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262514AbVGFUoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:44:44 -0400
Date: Wed, 6 Jul 2005 22:44:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706204429.GA1159@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706183836.GA31269@elte.hu> <20050706184121.GA31399@elte.hu> <200507062047.26855.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507062047.26855.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > here's an updated patch - it will print out all timestamps too. (you'll
> > have to revert all previous softlockup patches first, via patch -R.)
> 
> Yep, thanks, that fixed it. I don't know why it only shows up on my 
> configuration, but it was a bug, and this patch fixes it. I also took 
> the liberty of upgrading to -06 while I was doing it, so I think you 
> can probably release -07 with the specified changes.

great.

> So far no lockups, either, but I'm not convinced they're gone forever.  
> I'll let you know how it goes.

the ACPI-idle bug's primary effects were the missed wakeups, but they 
should not cause lockups, because timer interrupts should always occur 
and should eventually 'fix up' such missed wakeups.

but there's another side-effect of the ACPI-idle bug: the ACPI code was 
running with interrupts enabled and maybe the hardware locks up if 
interrupted in the wrong moment. ACPI sleeps are sensitive things and 
closely related to other IRQ hardware, which we all program with 
interrupts disabled. So i'd not be surprised if the lockups were caused 
by the ACPI-idle bug.

	Ingo
