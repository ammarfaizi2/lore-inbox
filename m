Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVB1O6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVB1O6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 09:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVB1O6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 09:58:42 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:25546 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261623AbVB1O6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 09:58:13 -0500
Message-Id: <200502281457.j1SEvYMG029560@laptop11.inf.utfsm.cl>
To: colbuse@ensisun.imag.fr
cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/2] drivers/char/vt.c: remove unnecessary code 
In-Reply-To: Message from colbuse@ensisun.imag.fr 
   of "Mon, 28 Feb 2005 15:01:15 BST." <1109599275.4223242b6b560@webmail.imag.fr> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 28 Feb 2005 11:57:34 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 28 Feb 2005 11:57:35 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

colbuse@ensisun.imag.fr said:
> Surlignage Russell King <rmk+lkml@arm.linux.org.uk>:
> > On Mon, Feb 28, 2005 at 02:13:57PM +0100, colbuse@ensisun.imag.fr wrote:
> > > NPAR times :-). As I stated, npar is unsigned.

> > I think that's disgusting then - it isn't obvious what's going on, which
> > leads to mistakes.

> > For the sake of a micro-optimisation such as this, it's far more important
> > that the code be readable and easily understandable.
> > 
> > Others may disagree.

> I agree :) .

I agree too.

>              But, if we look to the code, we can notice that there is
> actually no reason for npar to be unsigned. What do you think of this
> version?

> 
> --- old/drivers/char/vt.c       2004-12-24 22:35:25.000000000 +0100
> +++ new/drivers/char/vt.c       2005-02-28 12:53:57.933256631 +0100
> @@ -1655,9 +1655,9 @@
>                         vc_state = ESnormal;
>                 return;
>         case ESsquare:
> -               for(npar = 0 ; npar < NPAR ; npar++)
> +               for(npar = NPAR - 1; npar >= 0; npar--)
>                         par[npar] = 0;
> +               npar++;

Completely unreadable. What do you think you might gain this way? I doesn't
matter in which order the par[i] are set to zero, does it?

Please stick to plain, down-to-earth, colloquial C unless there is a
/measurable/ advantage in not doing so, and it matters overall (i.e., the
code in question runs many times a second). Readability first, traded in
for efficiency only when it /really/ matters. Given today's gcc, you'll
probably just confuse it into generating bad code by using cute tricks, as
it has been tuned to the typical language usage. And gcc is a moving
target, what might be a good idea today could be the worst possible thing
to do in a year or so (or even today with a different architecture).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
