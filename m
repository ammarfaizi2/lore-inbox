Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVLUUcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVLUUcz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLUUcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:32:55 -0500
Received: from nevyn.them.org ([66.93.172.17]:21438 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932497AbVLUUcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:32:54 -0500
Date: Wed, 21 Dec 2005 15:32:43 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
Message-ID: <20051221203243.GA19082@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
References: <20051221155442.GD7243@elte.hu> <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org> <Pine.LNX.4.64.0512211054450.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512211054450.4827@g5.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:57:40AM -0800, Linus Torvalds wrote:
> Actually (and re-reading the email I sent that wasn't obvious at all), my 
> _preferred_ fix is to literally force the use of the above kind of 
> function: not save/restore %eax at all, but just say that any function 
> that is called by the magic "atomic_*_call_if()" needs to always return 
> the argument it gets as its return value too.
> 
> That allows the caller to not even have to care. And the callee obviously 
> already _has_ that value, so it might as well return it (and in the best 
> case it's not going to add any cost at all, either to the caller or the 
> callee).
> 
> So you might opt to keep the asm the same, just change the calling 
> conventions.

This new macro is only going to be used in x86-specific files, right? 
There's no practical way to implement this on lots of other
architectures.

Embedding a call in asm("") can break other things too - for instance,
unwind tables could become inaccurate.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
