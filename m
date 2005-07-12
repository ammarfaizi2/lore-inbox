Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVGLO2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVGLO2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVGLO0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:26:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32758 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261463AbVGLOZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:25:44 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050712140251.GB18296@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de>
	 <20050712140251.GB18296@elte.hu>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 07:25:38 -0700
Message-Id: <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:02 +0200, Ingo Molnar wrote:
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > Hi Ingo
> > 
> > I've refined io_apic.c a little more:
> 
> great. I've applied these changes and have released the -28 patch. (note 
> that the last chunk of your patch was malformed, have applied it by 
> hand.)
> 
> i'm wondering what your thoughts are about IOAPIC_POSTFLUSH - i had to 
> turn it on unconditionally again, to get rid of spurious interrupts and 
> outright interrupt storms (and resulting lockups) on some systems.  
> IOAPIC_POSTFLUSH is now causing much of the IO-APIC related IRQ handling 
> overhead.

I observed a situation on a dual xeon where IOAPIC_POSTFLUSH , if on,
would actually cause spurious interrupts. It was odd cause it's suppose
to stop them .. If there was a lot of interrupt traffic on one IRQ , it
would cause interrupt traffic on another IRQ. This would result in
"nobody cared" messages , and the storming IRQ line would get shutdown.

This would only happen in PREEMPT_RT .

Daniel

