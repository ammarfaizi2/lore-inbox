Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280666AbRKNPqu>; Wed, 14 Nov 2001 10:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280660AbRKNPqd>; Wed, 14 Nov 2001 10:46:33 -0500
Received: from hermes.toad.net ([162.33.130.251]:29086 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280665AbRKNPqO>;
	Wed, 14 Nov 2001 10:46:14 -0500
Subject: Re: [PATCH] parport_pc to use pnpbios_register_driver()
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <15273.1005733037@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111140935350.791-100000@vaio>  
	<15273.1005733037@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Nov 2001 10:46:30 -0500
Message-Id: <1005752791.8923.44.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the decision to compile in ISAPnP support is based
> upon CONFIG_ISAPNP{,_MODULE}.

Yes.

Keith's idea is to disallow integral compilation of
isapnp-capable drivers when isa-pnp is modular.  Want an
integral (e.g.) ne2000?  Make isa-pnp integral too, or
else disable it entirely.

The configurator does not currently enforce this, and as
you say, isapnp.h works around the problem by dummying
out isa-pnp functions in integral drivers when isa-pnp
is modular.  I agree that this is not ideal.

> No, if we don't change the config rules, of course it does
> not make sense to compile ISAPNP code into a built-in object
> when ISAPNP is selected as modular. However, that's what
> happening in most of the drivers today. It doesn't cause
> problems (unresolved symbols) because the isapnp.h header
> is smart, recognizes this case and replaces the isapnp_*
> functions with empty dummies. But as we've got the #ifdef
> in the driver anyway, we could as well be smart and just
> drop the calling code, as we do  the CONFIG_ISAPNP=n case.

Makes sense.  However ....

What I would rather do is write parport_pc consistently
with how all other drivers are written.  Then if we
decide to set all this up more intelligently in the
future we can make a global change.

> Looking at drivers/pnp/Config.in, it's apparent
> that CONFIG_PNPBIOS is actually a bool. After reading
> your patch, which has "defined(CONFIG_PNPBIOS_MODULE)",
> I assumed that it was a tristate. As it apparently is
> not, the problem above doesn't arise at all. (My point
> still stands with regard to ISAPNP, though)
> So for your driver, I would just say: delete the references to 
> CONFIG_PNPBIOS_MODULE, which is never set.

Someday the pnpbios code may be changed to allow 
compilation of the pnpbios driver as a module.

> Some further nitpicking w.r.t to your patch: why
> not just rename init_pnp040x() to parport_pc_pnbios_probe(),
> get rid of the wrapper and use the standard return values?

That's a good idea for a second patch.  Not doing
what you suggest makes my patch easier to understand.

Thanks a lot for your suggestions.  I'm learning stuff.
Thomas


