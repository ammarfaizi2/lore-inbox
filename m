Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTIKRr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbTIKRp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:45:59 -0400
Received: from 12-221-81-65.client.insightBB.com ([12.221.81.65]:63616 "HELO
	apathy.killer-robot.net") by vger.kernel.org with SMTP
	id S261448AbTIKRnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:43:33 -0400
Date: Thu, 11 Sep 2003 12:43:31 -0500
From: Maciej Babinski <maciej@killer-robot.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Maciej <maciej@apathy.killer-robot.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
Message-ID: <20030911174331.GA1678@apathy.black-flower>
References: <20030910191459.GA12099@apathy.black-flower> <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:55:03PM -0400, Zwane Mwaikambo wrote:
> On Wed, 10 Sep 2003, Maciej wrote:
> 
> > Since I upgraded from 2.6.0-test3, to 2.6.0-test5, I can't seem to
> > get the SMP irq affinity to change. I have a dual-proc PII-333 with
> > a 440LX chipset. On boot, the smp_affinity mask for each interrupt
> > is set to 00030000, and setting it to ffffffff doesn't change
> > anything.
> 
> That number looks highly suspect; see patch below
> 

This changes the mask to 00000003. Much more reasonable.

> > The interrupts on IRQ5/CPU1 arrive in bursts. All interrupts for IRQ5
> > will happen on CPU0 for an extended period, but after I leave the
> > thing alone for a few hours, I'll find that the count for CPU1 will
> > have increased by a few tens of thousands. The counts for CPU1 on irq
> > 0 and irq 9 are set this way as soon as I have a chance to log in,
> > and don't change afterwards.
> 
> Do you have the irqbalanced daemon running? You could also try booting 
> with the 'noirqbalance' kernel parameter.
> 

I didn't have irqbalanced running. After some investigation, setting
the mask to 00000002 gets interrupts to hit cpu 1. Setting it to
00000001 or 00000003 gets all interrupts to hit cpu 0. Setting
noirqbalance doesn't do anything to change this. 

                                 Maciej Babinski
