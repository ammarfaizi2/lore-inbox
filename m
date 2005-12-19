Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVLSOBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVLSOBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVLSOBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:01:07 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:25787 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750702AbVLSOBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:01:06 -0500
Subject: Re: [patch 07/15] Generic Mutex Subsystem, mutex-debug-more.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013807.GC28038@elte.hu>
References: <20051219013807.GC28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:00:29 -0500
Message-Id: <1135000829.13138.245.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:38 +0100, Ingo Molnar wrote:
> Index: linux/lib/spinlock_debug.c
> ===================================================================
> --- linux.orig/lib/spinlock_debug.c
> +++ linux/lib/spinlock_debug.c
> @@ -20,7 +20,8 @@ static void spin_bug(spinlock_t *lock, c
>                 if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
>                         owner = lock->owner;
>                 printk("BUG: spinlock %s on CPU#%d, %s/%d\n",
> -                       msg, smp_processor_id(), current->comm,
> current->pid);
> +                       msg, raw_smp_processor_id(),
> +                       current->comm, current->pid);
>                 printk(" lock: %p, .magic: %08x, .owner: %s/%
> d, .owner_cpu: %d\n",
>                         lock, lock->magic,
>                         owner ? owner->comm : "<none>",
> @@ -78,8 +79,8 @@ static void __spin_lock_debug(spinlock_t
>                 if (print_once) {
>                         print_once = 0;
>                         printk("BUG: spinlock lockup on CPU#%d, %s/%d,
> %p\n",
> -                               smp_processor_id(), current->comm,
> current->pid,
> -                                       lock);
> +                               raw_smp_processor_id(), current->comm,
> +                               current->pid, lock);
>                         dump_stack();
>                 }
>         }

The changes here from smp_processor_id to raw_smp_processor_id seem to
be more clean up and not part of the mutex patch.  Should these be sent
separately?

-- Steve


