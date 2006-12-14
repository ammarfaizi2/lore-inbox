Return-Path: <linux-kernel-owner+w=401wt.eu-S932111AbWLNJL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWLNJL6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWLNJL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:11:58 -0500
Received: from www.osadl.org ([213.239.205.134]:37673 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932111AbWLNJL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:11:57 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061213235601.2a565229@localhost.localdomain>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
	 <1166048081.11914.208.camel@localhost.localdomain>
	 <1166049055.29505.47.camel@localhost.localdomain>
	 <20061213235601.2a565229@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 10:15:41 +0100
Message-Id: <1166087742.29505.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 23:56 +0000, Alan wrote:
> On Wed, 13 Dec 2006 23:30:55 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > - IRQ happens
> > - kernel handler runs and masks the chip irq, which removes the IRQ
> > request
> 
> IRQ is shared with the disk driver, box dead.

Err ? 

IRQ happens

IRQ is disabled by the generic handling code

Handler is invoked and checks, whether the irq is from the device or
not. 
 - If not, it returns IRQ_NONE, so the next driver (e.g. disk) is
invoked.
 - If yes, it masks the chip on the device, which disables the chip
interrupt line and returns IRQ_HANDLED.

In both cases the IRQ gets reenabled from the generic irq handling code
on return, so why is the box dead ?

	tglx


