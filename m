Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTBDJqq>; Tue, 4 Feb 2003 04:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTBDJqq>; Tue, 4 Feb 2003 04:46:46 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:15044 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267204AbTBDJqp>; Tue, 4 Feb 2003 04:46:45 -0500
Message-Id: <200302040956.h149u8IR021827@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: Your message of "Mon, 03 Feb 2003 21:34:08 +1100."
             <20030203105342.0CE3B2C003@lists.samba.org> 
Date: Tue, 04 Feb 2003 10:56:07 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:
> "insmod foo" will *always* get foo.  The only exception is when "foo"
> doesn't exist, in which case modprobe looks for another module which
> explicitly says it can serve in the place of foo.

OK.

> This allows smooth transition when a driver is superceded, *if* the
> new author wants it.

I would't let this happen, ever. What if foo does exist and Aunt Tillie
just didn't compile it?

[...]

> Sure, but you cut the vital bit of my mail.  Currently we have (1)
> request_module() which is used in various cases to request a service,
> and (2) aliases like "char-major-36", which modprobe.conf (or the old
> modutils' builtin) says is "netlink".  If you introduce a new char
> major (or, say a new cypher, or new network family, etc), you currenly
> have to get everyone to include it in their configuration file.
> 
> Now, the netlink module *knows* it provides char-major-36: with
> MODULE_ALIAS() it can say so.

The "provides" is the missing clue... You are taking about "provides" (and
mixing it up with "alias", something I still can't agree on), I'm talking
about "alias". Maybe they should be separate? In your examples netlink
_provides_ char-major-36, xyz3000 _provides_ binfmt-754, eepro100 _aliases_
to eth0 here. First use is clearly in-kernel, second one is (or should
always be IMVHO) out-of-kernel. Sure, could use the same infrastructure for
simplicity.

Now, what if xyz and zyx both provide foo? This will be the case when a new
driver comes along...

[This is looking more and more like a task for rpm/apt...
 /me ducks and runs]

Thanks for your patience!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
