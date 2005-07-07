Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVGGPdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVGGPdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVGGPcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 11:32:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28343 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261369AbVGGPbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 11:31:44 -0400
Date: Thu, 7 Jul 2005 17:31:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-45
Message-ID: <20050707153103.GA22782@elte.hu>
References: <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org> <20050706100451.GA7336@elte.hu> <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507071047540.12711@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo,
> 
> I've just downloaded 51-09 and tried running it here on a normal intel 
> pentium4 box here at my customers site.  It included some hotplug PCI 
> modules (I don't know why since it's doesn't have hotplug devices) and 
> I got some init_MUTEX_LOCKED bugs on them.  Below you will find the 
> patch (I assume that compat_semaphore is still used).

thanks, i've applied it, and it's now in 51-11.

> Anyway, I also want to let you know that the e100 does not work.  It's 
> detected, but it wont bring up DHCP, and when I manually configued it, 
> it just froze (the process not the machine). But when I did a sysrq-t, 
> the machine froze up after it completed with some RT yeilding bug. 
> Here's what was last to spit out:

is PCI_MSI enabled by any chance? That is known to break level-triggered 
IOAPIC irqs and devices.

> NETDEV WATCHDOG: eth0: transmit timed out
> BUG: events/0:10 RT task yield()-ing!

i have replaced this yield() with msleep(1) in -51-11, but that's just 
fixing the symptom.

	Ingo
