Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbTBBPTL>; Sun, 2 Feb 2003 10:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbTBBPTL>; Sun, 2 Feb 2003 10:19:11 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:8104 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S265351AbTBBPTK>; Sun, 2 Feb 2003 10:19:10 -0500
Message-Id: <200302012302.h11N2R3U001433@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: Your message of "Sat, 01 Feb 2003 14:49:57 +1100."
             <20030201041428.28F682C08C@lists.samba.org> 
Date: Sun, 02 Feb 2003 00:02:27 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:

[...]

> BTW, the reason for using the alias mechanism is that aliases are
> useful in themselves: consider you write a "new_foo" driver, you can
> do "MODULE_ALIAS("foo")" and so no userspace changes are neccessary.
> module-init-tools 0.9.8 already supported this.

May I respectfully disagree again?

This is fundamentally broken, as it takes away the possibility of me
(sysadmin) to load foo or old_foo. I end up with an (useless) foo, and a
new_foo that aliases for foo, and soon I'd have even_newer_foo masquerading
as foo too, and all hell breaks loose. The effect is bloat over just
deleting foo in the first place, as it can't be used at all now.

I remember a few cases of renamed modules (yes, annoying like hell) and
very few cases of old_foo and new_foo coexisting. In the last case the
_user_ had to decide if old_foo or new_foo worked better on their machine,
no amount of kbuild ESP would do, no distribution could set this up sanely.

The case where this might be useful are very far in between (if they even
exist), and the potential for subtle, invisible, breakage is just too high
IMVHO.

Please axe it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
