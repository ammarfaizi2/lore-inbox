Return-Path: <linux-kernel-owner+w=401wt.eu-S1751702AbWLMXIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWLMXIP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWLMXIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:08:14 -0500
Received: from www.osadl.org ([213.239.205.134]:46649 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751702AbWLMXIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:08:14 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1166049549.11914.218.camel@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	 <1166048081.11914.208.camel@localhost.localdomain>
	 <1166049055.29505.47.camel@localhost.localdomain>
	 <1166049549.11914.218.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 00:11:57 +0100
Message-Id: <1166051517.29505.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 09:39 +1100, Benjamin Herrenschmidt wrote:
> > No need for an ioctl. Neither for edge nor for level irqs.
> 
> Wait wait wait... your scenario implies that the kernel has knowledge of
> the chip to mask the irq in the chip in the first place.
> 
> If that is the case, then you have a chip specific kernel driver,
> yadada, the whole story is moot :-)
> 
> We were talking about the idea of having some "generic" reflector of
> irqs to userspace without device specific knowledge.

Which simply is not possible, especially for shared irqs.

Can you please elaborate why this effort is moot, instead of throwing
the usual flamewar arguments around ?

The concept of UIO divides the problem in two spaces:

- kernel interface, which controls interrupts and mapping
- user space restricted interface

I don't see why the necessarity of a kernel stub driver is a killer
argument. The chip internals, which companies might want to protect are
certainly not in the interrupt registers.

Aside of that there are huge performance gains for certain application /
driver scenarios and I really don't see an advantage that people are
doing excactly the same thing in out of tree hackeries with a lot of
inconsistent user land interfaces.

	tglx



