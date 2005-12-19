Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVLSQlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVLSQlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVLSQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:41:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:4808 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964849AbVLSQlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:41:52 -0500
Date: Mon, 19 Dec 2005 17:41:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 10/15] Generic Mutex Subsystem, mutex-migration-helper-core.patch
Message-ID: <20051219164110.GG8160@elte.hu>
References: <20051219013837.GF28038@elte.hu> <1135002337.13138.255.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135002337.13138.255.camel@localhost.localdomain>
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

> On Mon, 2005-12-19 at 02:38 +0100, Ingo Molnar wrote:
> > Index: linux/include/linux/mutex.h
> > ===================================================================
> > --- linux.orig/include/linux/mutex.h
> > +++ linux/include/linux/mutex.h
> 
> Maybe this should be in its own mutex-debug.h file with a:
> 
> #ifndef __LIUNX_MUTEX_H
> # error Do not include this file directly, use mutex.h
> #endif

yeah.

> > +/*
> > + * Debugging variant of mutexes. The only difference is that they
> > accept
> 
> Also, add a comment here that mutex_debug should NOT be used directly. 
> This may seem obvious, but new Linux kernel programmers may just be 
> scanning the code for what they would like to use and add it.  At 
> least let them know (although it may seem obvious) that this is just a 
> temporary structure that will go away soon, and if they want to use 
> mutexes, then use mutex, and don't be tempted to have a mutex up/down.

well, it could surface temporarily, as in 'could you try this 
test-release, it also turns on mutexes, lets see whether it breaks' - 
without the subsystem maintainer having to do a big patch changing all 
the down()/up() calls to mutex_lock()/mutex_unlock() ...

	Ingo
