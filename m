Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbUADO4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 09:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbUADO4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 09:56:30 -0500
Received: from gprs214-164.eurotel.cz ([160.218.214.164]:57472 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265693AbUADO43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 09:56:29 -0500
Date: Sun, 4 Jan 2004 15:57:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       manfred@colorfullife.com, rusty@au1.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: BUG in x86 do_page_fault?  [was Re: in_atomic doesn't count local_irq_disable?]
Message-ID: <20040104145736.GA11198@elf.ucw.cz>
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com> <20031231185959.A9041@in.ibm.com> <Pine.LNX.4.58.0312311104180.2065@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312311104180.2065@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	in_atomic() doesn't seem to return true
> > in code sections where IRQ's have been disabled (using 
> > local_irq_disable).
> > 
> > As a result, I think do_page_fault() on x86 needs to 
> > be updated to note this fact:
> 
> NO. 
> 
> Please don't do this, it will result in some _really_ nasty problems with 
> X and other programs that potentially disable interrupts in user
> space.

If user program causes page fault with interrupts disabled, it is
certainly buggy, right?

Either the user program does not really need irq disabled or it does
need that but page fault just broke its guarantees (=> severe problems
ahead).

In both cases there's user program that needs fixing.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
