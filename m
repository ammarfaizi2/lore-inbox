Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVLVO5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVLVO5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLVO5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:57:14 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:49637 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751007AbVLVO5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:57:13 -0500
Message-ID: <43AAD081.8F510F6B@tv-sign.ru>
Date: Thu, 22 Dec 2005 19:12:49 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 5/9] mutex subsystem, core
References: <20051222114233.GF18878@elte.hu> <43AAAC6F.17CC646@tv-sign.ru> <20051222144626.GA31939@elte.hu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> > This is a minor issue, but still I think it makes sense to optimize
> > for uncontended case:
> >
> >       old_val = atomic_xchg(&lock->count, 0); // no sleepers
> >
> >       if (old_val == 1) {
> >               // sleepers ?
> >               if (!list_empty(&lock->wait_list))
> >                       // need to wakeup them
> >                       atomic_set(&lock->count, -1);
> >               ...
> >       }
> >       [*]
> 
> but then we'd have to set it to -1 again, at [*], because we are now

Oh! You are right, thanks.

Oleg.
