Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWFYRg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWFYRg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWFYRg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:36:56 -0400
Received: from www.osadl.org ([213.239.205.134]:23976 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932420AbWFYRgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:36:55 -0400
Subject: Re: Problem with 2.6.17-mm2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ralf.Hildebrandt@charite.de, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060625103246.a309d67b.akpm@osdl.org>
References: <20060625103523.GY27143@charite.de>
	 <20060625034913.315755ae.akpm@osdl.org>
	 <1151256246.25491.398.camel@localhost.localdomain>
	 <20060625103246.a309d67b.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 19:38:42 +0200
Message-Id: <1151257123.25491.404.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 10:32 -0700, Andrew Morton wrote:
> > So in fact this just silently acks spurious interrupts which have an
> > hw_irq_controller assigned. If there is no action, then nothing has
> > called setup_irq/request_irq for this interrupt line and therefor it is
> > an spurious interrupt which should not happen.
> > 
> > 
> > genirq makes these visible and informs noisily about those events. 
> > 
> 
> hm, OK.  I guess we can let it ride for now.  Later we can decide whether
> we need to shut that warning up.  I suspect we should, if the machine's
> working OK.

We can make it once per IRQ. 

In fact I think the original behaviour is a BUG. You have no chance to
notice that your box gets flooded by such interrupts. With my willingly
asserted spurious interrupts the box simply stalls in a flood of
interrupts without any notice.

	tglx


