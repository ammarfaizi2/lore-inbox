Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271672AbRHVP0J>; Wed, 22 Aug 2001 11:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272029AbRHVPZ7>; Wed, 22 Aug 2001 11:25:59 -0400
Received: from ns.suse.de ([213.95.15.193]:46093 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271672AbRHVPZs>;
	Wed, 22 Aug 2001 11:25:48 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no call to add_interrupt_randomness() on PPC?
In-Reply-To: <3B83C430.7E5F59C3@nortelnetworks.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2001 17:26:01 +0200
In-Reply-To: Chris Friesen's message of "22 Aug 2001 16:44:06 +0200"
Message-ID: <oupitfgnmk6.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> writes:

> With all the talk about randomness, I went to see where my current system
> (2.2.19 on PPC) was getting random numbers from.  I was kind of surprised to see
> that there is no call to add_interrupt_randomness() in arch/ppc/kernel/irq.c.
> 
> Does anyone know why this call is not present in ppc_irq_dispatch_handler()? 
> Would it be appropriate for me to make a patch for this?  Who would be the
> appropriate person to send this to?

Nobody except for a few really obscure drivers use SA_SAMPLE_RANDOM
with their interrupt handlers (none on ppc as far as I can see) On
i386 all the gathering is normally done via the keyboard/mouse drivers
and the blk interface. The reason e.g. Macs normally do not gather
entropy is that they're using the new input layer for keyboard and
mouse which for some reason doesn't feed its events into the entropy
pool. I believe Wojtech did a patch for it, but I don't know if it has
been merged into the ppc tree yet.

-Andi
