Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbVLSQn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbVLSQn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVLSQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:43:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32712 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964857AbVLSQn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:43:56 -0500
Date: Mon, 19 Dec 2005 17:43:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
Message-ID: <20051219164319.GH8160@elte.hu>
References: <20051219013718.GA28038@elte.hu> <1134969166.13138.240.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134969166.13138.240.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> The unlikely below is only for the non MUTEX_LOCKLESS_FASTPATH case.
> Maybe have a define for the unlikely?
> 
> #ifdef MUTEX_LOCKLESS_FASTPATH
> #  define UNLIKELY_SLOW(x) x
> #else
> #  define UNLIKELY_SLOW(x) unlikely(x)
> #endif

> > +       if (unlikely(!list_empty(&lock->wait_list)))
> > +               __mutex_wakeup_waiter(lock __IP__);

i'll rather eliminate the unlikely().

	Ingo
