Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUADUoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 15:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbUADUoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 15:44:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:30165 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263637AbUADUoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 15:44:08 -0500
Date: Sun, 4 Jan 2004 12:43:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       manfred@colorfullife.com, rusty@au1.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: BUG in x86 do_page_fault?  [was Re: in_atomic doesn't count
 local_irq_disable?]
In-Reply-To: <20040104145736.GA11198@elf.ucw.cz>
Message-ID: <Pine.LNX.4.58.0401041241210.2162@home.osdl.org>
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com>
 <20031231185959.A9041@in.ibm.com> <Pine.LNX.4.58.0312311104180.2065@home.osdl.org>
 <20040104145736.GA11198@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Pavel Machek wrote:
> > 
> > Please don't do this, it will result in some _really_ nasty problems with 
> > X and other programs that potentially disable interrupts in user
> > space.
> 
> If user program causes page fault with interrupts disabled, it is
> certainly buggy, right?

No.

It may do a best-effort thing. It may also do a best-_performance_ thing, 
in leaving interrupts disabled over a piece of code that doesn't care, 
knowing that disabling interrupts is expensive.  Or it may just be a 
simple case of simplicity: disable interrupts over the whole region, 
knowing that only a part of it matters.

It by no means is automatically a bug. And it unquestionably _does_ 
happen. We used to warn about it. We stopped.

		Linus
