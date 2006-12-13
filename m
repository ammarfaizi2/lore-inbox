Return-Path: <linux-kernel-owner+w=401wt.eu-S965151AbWLMUMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWLMUMN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWLMUMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:12:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37170 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965151AbWLMUMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:12:10 -0500
Date: Wed, 13 Dec 2006 12:12:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <20061213195226.GA6736@kroah.com>
Message-ID: <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2006, Greg KH wrote:
>
> 	- userspace io driver interface added.  This allows the ability
> 	  to write userspace drivers for some types of hardware much
> 	  easier than before, going through a simple interface to get
> 	  accesses to irqs and memory regions.  A small kernel portion
> 	  is still needed to handle the irq properly, but that is it.

Ok, what kind of ass-hat idiotic thing is this?

	irqreturn_t uio_irq_handler(int irq, void *dev_id)
	{
	        return IRQ_HANDLED;
	}

exactly what is the point here? No way will I pull this kind of crap. You 
just seem to have guaranteed a dead machine if the irq is level-triggered, 
since it will keep on happening forever.

Please remove.

YOU CANNOT DO IRQ'S BY LETTING USER SPACE SORT IT OUT!

It's really that easy. The irq handler has to be _entirely_ in kernel 
space. No user-space ass-hattery here.

And I don't care one whit if it happens to work on parport with an old 
legacy ISA interrupt that is edge-triggered. That's not even the 
interesting case. Never will be.

NAK NAK NAK NAK.

		Linus
