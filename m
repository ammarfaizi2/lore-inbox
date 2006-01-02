Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWABRDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWABRDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 12:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWABRDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 12:03:44 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:64745 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750888AbWABRDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 12:03:43 -0500
Date: Mon, 2 Jan 2006 18:03:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 05/19] mutex subsystem, add include/asm-x86_64/mutex.h
Message-ID: <20060102170326.GA5593@elte.hu>
References: <20060102163354.GF31501@elte.hu> <20060102164605.GB7222@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102164605.GB7222@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > +		: "rax", "rsi", "rdx", "rcx",				\
> > +		  "r8", "r9", "r10", "r11", "memory");			\
> 
> I think it would be still better if you used the stubs in 
> arch/x86_64/lib/thunk.S and not clobber all the registers. While it 
> won't make that much difference for the out of line mutexes it will 
> generate better code for inline mutexes, and if someone ever decides 
> they're a good idea the code will be ready.

i didnt want to add it to thunk.S because right now it would cause an 
unnecessary slowdown for the slowpath, by quite a number of 
instructions: due to the indiscriminate register-saving/restoring done 
in thunk.S.

even though it's a "slow path" relative to the fastpath, we shouldnt 
slow it down unnecessarily. So if someone wants to play with more 
inlining later on, this has to be done in context of that effort.

	Ingo
