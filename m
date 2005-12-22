Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbVLVXzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVLVXzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVLVXzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:55:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53946 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751094AbVLVXzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:55:12 -0500
Date: Thu, 22 Dec 2005 18:55:08 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, -V6
In-reply-to: <20051222230438.GA13302@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221846470.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222230438.GA13302@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, Ingo Molnar wrote:

> this release picks up Arjan's asm/mutex.h implementation, which adds 
> asm-generic/mutex-dec.h, asm-generic/mutex-xchg.h for architectures to 
> pick up. i386 and x86_64 use their own optimized version already, the 
> other architectures default to mutex-xchg.h.

Great, this is in substance what I've been proposing for a while.

> Architectures specify the 
> following functions:
> 
>  -------------------------------------------------------------------
>  *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
>  *  @count: pointer of type atomic_t
>  *  @fn: function to call if the original value was not 1
>  -------------------------------------------------------------------
The above should read "function to call if the original value was not 0".

> and __mutex_slowpath_needs_to_unlock(), to specify whether the fastpath 
> has touched the count or not.

Note that, in most cases (but not necessarily all of them) the count is 
always touched.  It should rather be "has set the count to 1 or not" to 
be precise..

> Nico, Christoph, does this approach work for you? Nico, you might want 
> to try an ARM-specific mutex.h implementation.

Yes, I'm happy.  And the ARM version will be sent your way soon.


Nicolas
