Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVLUUBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVLUUBn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVLUUBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:01:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39640 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964801AbVLUUBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:01:42 -0500
Date: Wed, 21 Dec 2005 21:01:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
Message-ID: <20051221200101.GA18565@elte.hu>
References: <20051221155442.GD7243@elte.hu> <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org> <Pine.LNX.4.64.0512211054450.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512211054450.4827@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> > Umm. This asm is broken. It doesn't mark %eax as changed, so this is only 
> > reliable if the function you call is
> > 
> >  - a "fastcall" one
> >  - always returns as its return value the pointer to the atomic count
> > 
> > which is not true (you verify that it's a fastcall, but it's of type 
> > "void").
> 
> Actually (and re-reading the email I sent that wasn't obvious at all), 
> my _preferred_ fix is to literally force the use of the above kind of 
> function: not save/restore %eax at all, but just say that any function 
> that is called by the magic "atomic_*_call_if()" needs to always 
> return the argument it gets as its return value too.
> 
> That allows the caller to not even have to care. And the callee 
> obviously already _has_ that value, so it might as well return it (and 
> in the best case it's not going to add any cost at all, either to the 
> caller or the callee).
> 
> So you might opt to keep the asm the same, just change the calling 
> conventions.

ok, i've added this fix, thanks. Right now we dont do anything after 
those functions (that's probably how the bug never showed up), but at 
least one interim stage i tried to use the call_if functions at other 
places too, so the potential is there.

	Ingo
