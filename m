Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUJaAMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUJaAMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 20:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUJaAMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 20:12:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32175 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261436AbUJaAMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 20:12:19 -0400
Subject: Re: free_irq problem in 2.6 kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: brian franklin <may26baf@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029220052.97805.qmail@web52601.mail.yahoo.com>
References: <20041029220052.97805.qmail@web52601.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099177770.25178.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 31 Oct 2004 00:09:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-29 at 23:00, brian franklin wrote:
> 2.6.8-1.528.2.10smp, I now have a problem when I call
> free_irq().  It
> now masks off the interrupt even though it is shared
> with another

free_irq only masks the interrupt line when the last user is
freeing that IRQ line.

> The syntax of my calls to these two functions are:
> status = request_irq(priv->irq , jnet_isr, SA_SHIRQ,
> name1, dev);
> and
> free_irq(priv->irq, dev);
> 
> Can anyone shed some light on what I might be doing
> wrong?

The calls look fine (providing you arent using "dev" as the cookie for
multiple "request_irq" functions on the same IRQ at the same time)

> kernel version that does configured the IOAPIC
> configuration registers
> correctly, and one that doesn't?  (In previous
> versions, the
> configuration register would have an interrupt vector
> of IRQ169 while
> the interrupt was really IRQ19.

It depends at runtime on the system, how the IRQ assignment is done and
sometimes on hardware "features". The official kernel internal policy is
that

a) "irq" is a cookie obtained for PCI devices by pdev->irq 
b) you pass the cookie to request_irq
c) it has no other guaranteed meaning at all

once you get off x86 this gets even more important.

