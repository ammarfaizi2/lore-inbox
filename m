Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbWACPjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbWACPjv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWACPjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:39:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751435AbWACPju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:39:50 -0500
Date: Tue, 3 Jan 2006 07:38:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 08/19] mutex subsystem, core
In-Reply-To: <20060103150554.GA1211@elte.hu>
Message-ID: <Pine.LNX.4.64.0601030736531.3668@g5.osdl.org>
References: <20060103100807.GH23289@elte.hu> <43BA78EC.7050603@yahoo.com.au>
 <20060103150554.GA1211@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 3 Jan 2006, Ingo Molnar wrote:
> > 
> > Is this an interrupt deadlock, or do you not allow interrupt contexts 
> > to even trylock a mutex?
> 
> correct, no irq contexts are allowed. This is also checked for if 
> CONFIG_DEBUG_MUTEXES is enabled.

Note that semaphores are definitely used from interrupt context, and as 
such you can't replace them with mutexes if you do this.

The prime example is the console semaphore. See kernel/printk.c, look for 
"down_trylock()", and realize that they are all about interrupts.

			Linus
