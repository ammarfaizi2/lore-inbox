Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264816AbTFLLDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbTFLLDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:03:04 -0400
Received: from dp.samba.org ([66.70.73.150]:60313 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264816AbTFLLDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:03:00 -0400
Date: Thu, 12 Jun 2003 21:15:49 +1000
From: Anton Blanchard <anton@samba.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: irq consolidation
Message-ID: <20030612111549.GG1195@krispykreme>
References: <20030607040515.GB28914@krispykreme> <20030607044803.GE28914@krispykreme> <20030607101848.A22665@flint.arm.linux.org.uk> <Pine.LNX.4.50.0306070539200.8902-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0306070539200.8902-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Anton don't you have an NR_IRQS sized interrupt stub you have to deal 
> with on PPC64?
> 
> I was considering perhaps only statically allocating the 0-15 on i386 
> just to get it booting and then dynamically allocate the rest.

We usually have an 8259 but its wired up to the main interrupt
controller. Even if we statically allocated 0-15, we still need a higher
irq for that cascade.

Going all the way and removing NR_IRQS also catches problems like the
random driver where we would only add randomness on 8259 (ie < 16)
interrupts with a mixed static/dynamic scheme.

Anton
