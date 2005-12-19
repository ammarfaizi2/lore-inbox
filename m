Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVLSEQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVLSEQT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 23:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVLSEQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 23:16:19 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:34992 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030238AbVLSEQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 23:16:19 -0500
Subject: Re: [patch 05/15] Generic Mutex Subsystem, mutex-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013718.GA28038@elte.hu>
References: <20051219013718.GA28038@elte.hu>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 23:15:29 -0500
Message-Id: <1134965729.13138.222.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:37 +0100, Ingo Molnar wrote:
> +/*
> + * We can speed up the lock-acquire, if the architecture
> + * supports cmpxchg and if there's no debugging state
> + * to be set up (!DEBUG_MUTEXESS).
> + *
> + * trick: we can use cmpxchg on the release side too, if bit
> + * 0 of lock->owner is set if there is at least a single pending

I think you mean lock->count and not lock->owner (you're getting your
patches mixed up ;)


> + * task in the wait_list. This way the release atomic-fastpath
> + * can be a mirror image of the acquire path:
> + */
> +#if defined(__HAVE_ARCH_CMPXCHG) && !defined(CONFIG_DEBUG_MUTEXESS)
> +# define MUTEX_LOCKLESS_FASTPATH
> +#endif
> +

-- Steve


