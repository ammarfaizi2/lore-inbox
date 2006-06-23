Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932939AbWFWIbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbWFWIbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbWFWIbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:31:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:30647 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932939AbWFWIbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:31:09 -0400
Date: Fri, 23 Jun 2006 10:26:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@timesys.com>
Cc: Robert Hancock <hancockr@shaw.ca>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ -V4
Message-ID: <20060623082609.GB1040@elte.hu>
References: <fa.lKfxxA+pCJb5tSZbL1XnnrPzaeQ@ifi.uio.no> <449B60A9.2000809@shaw.ca> <1151051238.25491.223.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151051238.25491.223.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@timesys.com> wrote:

> > Disabling NO_HZ and high resolution timers due to timer broadcasting
> > 
> > Not sure exactly what this is indicating or what's triggered this, but 
> > I'm assuming the patch isn't doing much on this machine?
> 
> The system is configured for SMP, but this is an UP machine and the 
> APIC is disabled in the BIOS. Linux uses then the PIT and an IPI 
> mechanism to broadcast timer events. We need to do the event 
> reprogramming per CPU, so we switch off in that situation.

hm, we should update the message to be less cryptic. Something like:

  'Disabling NO_HZ and high resolution timers due to no APIC'

and in this particular case we should also finetune the condition a bit 
and make it conditional on the number of CPUs. I.e. if someone boots an 
SMP kernel on a UP box we should still allow the PIT. (there wont be any 
broadcasting done) [the only exception would be if CONFIG_HOTPLUG_CPU is 
specified - in that case we cannot be sure whether a new CPU will be 
plugged in or not]

	Ingo
