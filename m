Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTBCIZ7>; Mon, 3 Feb 2003 03:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBCIZ7>; Mon, 3 Feb 2003 03:25:59 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:46212 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266120AbTBCIZ6>; Mon, 3 Feb 2003 03:25:58 -0500
Message-Id: <200302030831.h138VZ4p011397@eeyore.valparaiso.cl>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-Reply-To: Your message of "Mon, 03 Feb 2003 11:52:57 +1100."
             <20030203022709.83AA52C0A7@lists.samba.org> 
Date: Mon, 03 Feb 2003 09:31:35 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> said:
> Horst von Brand wrote:
> > Rusty Russell <rusty@rustcorp.com.au> said:

> > [...]
> > 
> > > BTW, the reason for using the alias mechanism is that aliases are
> > > useful in themselves: consider you write a "new_foo" driver, you can
> > > do "MODULE_ALIAS("foo")" and so no userspace changes are neccessary.
> > > module-init-tools 0.9.8 already supported this.
> > 
> > May I respectfully disagree again?
> 
> Hi Horst,
> 
> 	Thoughtful and respecful criticism?  I didn't think that was
> allowed on linux-kernel any more? 8)

Sorry about that. Won't happen again, I promise.

> > This is fundamentally broken, as it takes away the possibility of me
> > (sysadmin) to load foo or old_foo. I end up with an (useless) foo, and a
> > new_foo that aliases for foo, and soon I'd have even_newer_foo masquerading
> > as foo too, and all hell breaks loose. The effect is bloat over just
> > deleting foo in the first place, as it can't be used at all now.
> 
> Well, "modprobe foo" will only give you the "new_foo" driver if (1) the
> foo driver isn't found, and (2) the new driver author decides that
> it's a valid replacement.

So the alias only works if the original isn't found? Weird... I'd just
rename the dang thing and get over it. A distribution kernel won't be able
to use this anyway, as they'll either build both alternatives or just one
of them and adjust configuration to match.

> Whether (2) is ever justified, I'm happy leaving to the individual
> author (I know, that makes me a wimp).

Don't trust authors too much when it comes to guessing at random individual
installations... ;-)

> Consider another example: convenience aliases such as char-major-xxx.
> Now, I'm not convinced they're a great idea anyway, but if people are
> going to do this, I'd rather they did it in the kernel, rather than
> some random userspace program.

The module munging programs and their configuration are (logically) a part
of the kernel (configuration). So this goes against the current wave of
exporting as much as possible from the kernel. And IMHO it places policy
into the kernel, where it has no place. Plus it enlarges modules, which is
a consideration for installation/rescue media.

> I think the alias mechanism is valid, but you have a point about the
> dangers, too.
> 
> Thoughts?

Maybe I'm just being a bit too conservative here. But I still think this is
too dangerous for little (or even no) real gain.

Could you please provide examples of use in generic, distribution kernels?
Contrast with configuration in /etc/modules.conf and/or modprobe (I think
placing this stuff in modprobe is wrong, but that is the way it is today). 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
