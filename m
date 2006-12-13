Return-Path: <linux-kernel-owner+w=401wt.eu-S1751650AbWLMWOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWLMWOw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWLMWOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:14:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:51399 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbWLMWOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:14:51 -0500
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
	 <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
	 <1166044471.11914.195.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612131323380.5718@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 09:14:41 +1100
Message-Id: <1166048081.11914.208.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No. The point really is that it fundamentally _cannot_ work. Not in the 
> real world.
> 
> It can only work in some alternate reality where you can always disable 
> interrupts per-device, and even in that alternate reality it would be 
> wrong to use that quoted interrupt handler: not only do you need to 
> disable the irq, you need to have an "acknowledge" phase too
> 
> So you'd actually have to fix things _architecturally_, not just add some 
> code to the irq handler.

Oh, it works well enough for non shared iqs if you are really anal about
it, but I agree that it sucks and I don't see the point of having it in
linux. The flow has to be different for level vs. edge and it's really
ugly but it works. I've seen people doing it in embedded space. But
again, I do agree it sucks big time :-)

the edge flow is easy. the level one is:

 - IRQ happens
 - kernel handler masks it and queue a msg for userland
 - later on, userland gets the message, talks to the device,
   (MMAP'ed mmio, acks the interrupt on the device itself) and
   does an ioctl/syscall/write/whatever to tell kernel it's done
 - kernel unmasks it.

But yeah, I hate it too, so let's not waste time talking about how to
make it work :-)

Ben.


