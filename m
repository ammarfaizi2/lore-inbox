Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318280AbSGXIj0>; Wed, 24 Jul 2002 04:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSGXIj0>; Wed, 24 Jul 2002 04:39:26 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:10709 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318280AbSGXIjZ>;
	Wed, 24 Jul 2002 04:39:25 -0400
Date: Wed, 24 Jul 2002 14:40:18 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: martin@dalecki.de
Cc: dalecki@evision.ag, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27 spinlock
Message-Id: <20020724144018.6a92d80a.rusty@rustcorp.com.au>
In-Reply-To: <3D3BE36E.3090001@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
	<3D3BE36E.3090001@evision.ag>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002 12:50:22 +0200
Marcin Dalecki <dalecki@evision.ag> wrote:

> - Add missing _raw_write_trylock() definitions for the UP preemption case.
> 
> - Replace tons of georgeous macros for the UP preemption case with
> static inline  functions. Much nicer to look at and more adequate then
> ({ xxxx }) in this case.

Martin, this patch is wrong, obvious from casual reading:

> -#define spin_trylock_bh(lock)			({ int __r; local_bh_disable();\
> +#define spin_trylock_bh(lock)			do { int __r; local_bh_disable();\
>  						__r = spin_trylock(lock);      \
>  						if (!__r) local_bh_enable();   \
> -						__r; })
> +						__r; } while (0)

I know you're smarter than this Martin 8)

Rusty.
PS. If you want them re-xmitted to Linus, send to trivial@rustcorp.com.au...
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
