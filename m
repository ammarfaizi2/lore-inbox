Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLOXUB>; Fri, 15 Dec 2000 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129896AbQLOXTl>; Fri, 15 Dec 2000 18:19:41 -0500
Received: from jalon.able.es ([212.97.163.2]:43445 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129823AbQLOXTb>;
	Fri, 15 Dec 2000 18:19:31 -0500
Date: Fri, 15 Dec 2000 23:48:57 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: LA Walsh <law@sgi.com>, Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001215234857.A689@werewolf.able.es>
In-Reply-To: <20001215152137.K599@almesberger.net> <NBBBJGOOMDFADJDGDCPHAENMCJAA.law@sgi.com> <20001215222117.S573@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001215222117.S573@almesberger.net>; from Werner.Almesberger@epfl.ch on Fri, Dec 15, 2000 at 22:21:17 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2000/12/15 Werner Almesberger wrote:
> LA Walsh wrote:
> 
> Exception: opaque types; there one would have to go via a __ identifier,
> i.e.
> 
> <public>/foo.h defines  struct __foo ...;
> <public>/bar.h includes <public>/foo.h
>                and uses #define FOOSIZE sizeof(struct __foo)
> <private>/foo.h either  typedef struct __foo foo_t;
>                 or      #define foo __foo  /* ugly */
> 

Easier: public kernel interfaces only work through pointers.
<public>/foo.h typedef struct foo foo_t;
               foo_t* foo_new();
<private>/foo.h includes <public>/foo.h
               struct foo { ............... };
               and uses #define FOOSIZE sizeof(foo_t)

Drawback: public access is slow (always through foo_set_xxxx_field(foo_t*))
          private access from kernel or modules is fast (foo_t->x = ...)
Advantage: kernel can change, foo_t internals can change and it is binary
          compatible. Even public headers can be kernel version
          independent.

Too kind-of-classroom-not-real-world-useless-thing ?
All depends on public access needing full fast paths...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.19-pre1 #1 SMP Fri Dec 15 22:25:20 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
