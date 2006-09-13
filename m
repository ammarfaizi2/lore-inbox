Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWIMIpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWIMIpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWIMIpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:45:23 -0400
Received: from www.osadl.org ([213.239.205.134]:63670 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750986AbWIMIpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:45:22 -0400
Subject: Re: [ltp] do I have to worry?
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060912144106.GT7767@gimli>
References: <20060912102844.GH7767@gimli>  <20060912144106.GT7767@gimli>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 10:46:00 +0200
Message-Id: <1158137160.5724.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 16:41 +0200, Martin Lorenz wrote:
> On Tue, Sep 12, 2006 at 12:28:44PM +0200, Dipl.-Ing. Martin Lorenz wrote:
> > Hi all,
> > 
> > I found another error in my dmesg:

Which kernel version ?

> > [50219.992000] e1000: eth0: e1000_watchdog: NIC Link is Down
> > [50225.266000] Trying to free already-free IRQ 201

free_irq() is called either twice or without a previous request_irq()

> > [50225.271000] bridge-eth0: disabling the bridge
> > [50225.274000] bridge-eth0: down
> > [50225.317000] IRQ handler type mismatch for IRQ 90

request_irq() is called for a shared interrupt, where one of the drivers
does not set the IRQF_SHARED flag.

Can you provide a full bootlog and "lspci -vvv" output please ?

	tglx


