Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVLSO0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVLSO0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVLSO0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:26:04 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:12962 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750968AbVLSO0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:26:02 -0500
Subject: Re: [patch 10/15] Generic Mutex Subsystem,
	mutex-migration-helper-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013837.GF28038@elte.hu>
References: <20051219013837.GF28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:25:37 -0500
Message-Id: <1135002337.13138.255.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:38 +0100, Ingo Molnar wrote:
> Index: linux/include/linux/mutex.h
> ===================================================================
> --- linux.orig/include/linux/mutex.h
> +++ linux/include/linux/mutex.h

Maybe this should be in its own mutex-debug.h file with a:

#ifndef __LIUNX_MUTEX_H
# error Do not include this file directly, use mutex.h
#endif


> @@ -99,4 +99,120 @@ extern int FASTCALL(mutex_trylock(struct
>  extern void FASTCALL(mutex_unlock(struct mutex *lock));
>  extern int FASTCALL(mutex_is_locked(struct mutex *lock));
>  
> +/*
> + * Debugging variant of mutexes. The only difference is that they
> accept

Also, add a comment here that mutex_debug should NOT be used directly.
This may seem obvious, but new Linux kernel programmers may just be
scanning the code for what they would like to use and add it.  At least
let them know (although it may seem obvious) that this is just a
temporary structure that will go away soon, and if they want to use
mutexes, then use mutex, and don't be tempted to have a mutex up/down.

OK, I'm watching out for the idiots, but since I'm one every so often, I
hope someone watches out for me ;-)

-- Steve

> + * the semaphore APIs too:
> + */
> +struct mutex_debug {
> +       struct mutex lock;
> +};
> +
> +#define DEFINE_MUTEX_DEBUG(mutexname) \
> +       struct mutex_debug mutexname = \
> +               { .lock = __MUTEX_INITIALIZER(mutexname.lock) }
> +

