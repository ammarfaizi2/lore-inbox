Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTKXJeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTKXJeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:34:15 -0500
Received: from gprs148-6.eurotel.cz ([160.218.148.6]:14464 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263691AbTKXJeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:34:13 -0500
Date: Mon, 24 Nov 2003 10:34:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Fix locking in input
Message-ID: <20031124093448.GA306@elf.ucw.cz>
References: <3FC13382.3060701@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC13382.3060701@colorfullife.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>input uses "volatile signed char" as a shared variable between normal
> >>and interrupt threads (look at _sendbyte()). Thats bad idea, this
> >>switches it to atomic_t.
> >
> >This change looks unnecessary to me - we aren't trying to increment or
> >decrement the variable, just set it and read it.  Reading and writing
> >individual bytes is atomic on any platform we care about.
> > 
> >
> I think one platform (early ARM?) cannot access bytes directly, and 
> implement the access with read 16-bit, change 8-bit, write back 16 bit. 
> Reading/writing pointers or longs is atomic.
> 
> Pavel: Do you know that atomic_set and atomic_read aren't memory barriers?
> I.e.
> 
> -	psmouse->ack = 0;
> +	atomic_set(&psmouse->ack, 0);
> 	psmouse->acking = 1;
> 
> It's not guaranteed that all cpus will see psmouse->ack=0 before 
> psmouse->acking=1. And adding the required memory barriers usually makes 
> the code completely unreadable, thus I usually give up and switch to a 
> spinlock.

Would simply adding mb() there fix it? It is not performance-critical
in any way...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
