Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265580AbSKAIpW>; Fri, 1 Nov 2002 03:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265671AbSKAIpV>; Fri, 1 Nov 2002 03:45:21 -0500
Received: from dp.samba.org ([66.70.73.150]:38120 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265580AbSKAIpU>;
	Fri, 1 Nov 2002 03:45:20 -0500
Date: Fri, 1 Nov 2002 19:33:54 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: akpm@zip.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] kmalloc_percpu
Message-Id: <20021101193354.54367ba4.rusty@rustcorp.com.au>
In-Reply-To: <20021031213640.D2298@in.ibm.com>
References: <20021031213640.D2298@in.ibm.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002 21:36:40 +0530
Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:

> Here's  kmalloc_percpu interfaces ported (...mostly rediffed) to 
> 2.5.45.  (One last try for 2.6).

IMHO this is a "when we need it" patch.  Baby steps...

> +#define this_cpu_ptr(ptr) per_cpu_ptr(ptr, smp_processor_id())

Probably want a get_cpu_ptr() & put_cpu_ptr() using get_cpu() and put_cpu()
(and this would become __get_cpu_ptr()).

And probably move them all to linux/percpu.h.

> +extern void *kmalloc_percpu(size_t size, int flags);
> +extern void kfree_percpu(const void *);
> +extern int percpu_interlaced_alloc(struct percpu_data *, size_t, int);
> +extern void percpu_interlaced_free(struct percpu_data *);
> +extern void percpu_data_sys_init(void);

Hmm... It'd be nice to remove these three from the header so that the
interface is clear (which may mean exposing some slab.c internals so
you can access them in mm/percpu_data.c).

> +	if(!blklist->cachep)

A space between the "if" and the "(" is traditional.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
