Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTATSsd>; Mon, 20 Jan 2003 13:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbTATSsc>; Mon, 20 Jan 2003 13:48:32 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:7110 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266638AbTATSsb>; Mon, 20 Jan 2003 13:48:31 -0500
Message-Id: <200301201527.h0KFRgil001575@eeyore.valparaiso.cl>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable 
In-Reply-To: Your message of "Sat, 18 Jan 2003 20:14:39 PST."
             <200301190414.UAA10226@adam.yggdrasil.com> 
Date: Mon, 20 Jan 2003 16:27:42 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> said:
> 	To my knowledge, a goto in this case is not necessary for
> avoiding code duplication.  If there are a small number of failable
> steps that may need to be unwound, you could adopt the style of my patch
> (which shortened the code slightly):
> 
>        if (step1() == ok) {
> 		if (step2() == ok) {
> 			if (strep3() == ok)
> 				return OK;
> 			undo_step2();
> 		}
> 		undo_step1();
> 	}
> 	return failure;

The "undo_stepX()"'s pollute the CPU's cache, and (even much worse) the
gentle reader's.

> 	If the nesting gets any deeper than this, then a more
> understandable solution for readability than using goto would be to
> define a separate inline routine.

Can't be done (cleanly) in many cases due to function semantics in C,
polutes CPU cache as above, screws up or gives bad code due to compiler
bugs. Plus has the gentle reader who wants to check error handling chasing
all over the place.

> 	In general, I recommend using goto only when it is
> topologically necessary to avoid code duplication or due to some
> compiler quirk where you want to sqeeze a few more cycles out of code
> in a critical path.  That way, the use of goto basically flags these
> unusual cases for other programmers.

IMVHO, any general criterion that is not strictly based on code
understandability, possibly mitigated by a justified need of maximal speed,
is flawed. This might come close, but won't cut it for me.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
