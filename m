Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPEmH>; Fri, 15 Dec 2000 23:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLPEl6>; Fri, 15 Dec 2000 23:41:58 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:32019 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129228AbQLPElw>; Fri, 15 Dec 2000 23:41:52 -0500
Date: Fri, 15 Dec 2000 20:11:04 -0800 (PST)
From: ferret@phonewave.net
To: "J . A . Magallon" <jamagallon@able.es>
cc: Werner Almesberger <Werner.Almesberger@epfl.ch>, LA Walsh <law@sgi.com>,
        Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
In-Reply-To: <20001215234857.A689@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1001215200639.19208E-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, J . A . Magallon wrote:

> 
> On 2000/12/15 Werner Almesberger wrote:
> > LA Walsh wrote:
> > 
> > Exception: opaque types; there one would have to go via a __ identifier,
> > i.e.
> > 
> > <public>/foo.h defines  struct __foo ...;
> > <public>/bar.h includes <public>/foo.h
> >                and uses #define FOOSIZE sizeof(struct __foo)
> > <private>/foo.h either  typedef struct __foo foo_t;
> >                 or      #define foo __foo  /* ugly */
> > 
> 
> Easier: public kernel interfaces only work through pointers.
> <public>/foo.h typedef struct foo foo_t;
>                foo_t* foo_new();
> <private>/foo.h includes <public>/foo.h
>                struct foo { ............... };
>                and uses #define FOOSIZE sizeof(foo_t)
> 
> Drawback: public access is slow (always through foo_set_xxxx_field(foo_t*))
>           private access from kernel or modules is fast (foo_t->x = ...)
> Advantage: kernel can change, foo_t internals can change and it is binary
>           compatible. Even public headers can be kernel version
>           independent.

I think collectively we're mixing what should really be two seperate but
related issues: userland interface from /usr/include/linux; and exported
kernel header interface for third-party modules.

>From a first reading, your Drawback: appears to belong to the sphere of
kernel interface, and your Advantage: to the sphere of userland interface.
But on the second reading (after opening a bottle of Jones) I can see how
the Advantage: would apply to both spheres.

I'm just asking that people please try to be a little more precise with
the rather imprecise list language.

--Ferret


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
