Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264722AbTGBFS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 01:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264728AbTGBFS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 01:18:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264722AbTGBFS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 01:18:56 -0400
Date: Tue, 1 Jul 2003 22:33:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove "cpu" arg to cpu_raise_softirq().
In-Reply-To: <20030701062315.5A2492C0B1@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0307012227020.2047-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Jul 2003, Rusty Russell wrote:
> 
> I didn't change the name, but I dislike the layering:

Agreed. Change the name too, since you're changing the calling convention.

> Better would be:
> 	raise_softirq(int nr): completely general
> 	__raise_softirq(int nr): must have interrupts off
> 	__raise_softirq_noksoftirqd(int nr): doesn't wake ksoftirqd

Actually, why not just make the irq thing more explicit, and use the "__" 
naming convention for the "internal use" version), ie more along the lines 
of

	raise_softirq(int nr): completely general
	raise_softirq_irqoff(int nr): interrupts off
	__raise_softirq_irqoff(int nr): interrupts off, don't wake

instead..

		Linus

