Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWACPnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWACPnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWACPm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:42:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:170 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751443AbWACPm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:42:59 -0500
Date: Tue, 3 Jan 2006 16:42:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 08/19] mutex subsystem, core
Message-ID: <20060103154244.GA6884@elte.hu>
References: <20060103100807.GH23289@elte.hu> <43BA78EC.7050603@yahoo.com.au> <20060103150554.GA1211@elte.hu> <Pine.LNX.4.64.0601030736531.3668@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601030736531.3668@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 3 Jan 2006, Ingo Molnar wrote:
> > > 
> > > Is this an interrupt deadlock, or do you not allow interrupt contexts 
> > > to even trylock a mutex?
> > 
> > correct, no irq contexts are allowed. This is also checked for if 
> > CONFIG_DEBUG_MUTEXES is enabled.
> 
> Note that semaphores are definitely used from interrupt context, and 
> as such you can't replace them with mutexes if you do this.
>
> The prime example is the console semaphore. See kernel/printk.c, look 
> for "down_trylock()", and realize that they are all about interrupts.

yeah, i know - and i'm not trying to replace _all_ semaphore uses.  
down_trylock() is used only 54 times in drivers/*, while down() is used 
2986 times. And even of those 54 cases, only a small minority does it 
from an IRQ context.

	Ingo
