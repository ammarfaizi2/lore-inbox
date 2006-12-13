Return-Path: <linux-kernel-owner+w=401wt.eu-S1751637AbWLMW1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWLMW1N (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWLMW1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:27:13 -0500
Received: from www.osadl.org ([213.239.205.134]:51952 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751636AbWLMW1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:27:12 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1166048081.11914.208.camel@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	 <1166048081.11914.208.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 23:30:55 +0100
Message-Id: <1166049055.29505.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 09:14 +1100, Benjamin Herrenschmidt wrote:
> the edge flow is easy. the level one is:
> 
>  - IRQ happens
>  - kernel handler masks it and queue a msg for userland
>  - later on, userland gets the message, talks to the device,
>    (MMAP'ed mmio, acks the interrupt on the device itself) and
>    does an ioctl/syscall/write/whatever to tell kernel it's done
>  - kernel unmasks it.

That's simply not true.

- IRQ happens
- kernel handler runs and masks the chip irq, which removes the IRQ
request
- user space message get queued or waiting reader woken
- kernel handler returns IRQ_HANDLED, which reenables the irq in the PIC
- user space handles the device
- user space reenables the device irq

No need for an ioctl. Neither for edge nor for level irqs.

	tglx


