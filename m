Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVC3RLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVC3RLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVC3RLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 12:11:34 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:56237 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262346AbVC3RLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 12:11:15 -0500
Message-Id: <200503301709.j2UH9WsA008556@laptop11.inf.utfsm.cl>
To: "Jean Delvare" <khali@linux-fr.org>
cc: vonbrand@inf.utfsm.cl, "Andrew Morton" <akpm@osdl.org>,
       "Adrian Bunk" <bunk@stusta.de>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: Do not misuse Coverity please 
In-Reply-To: Message from "Jean Delvare" <khali@linux-fr.org> 
   of "Wed, 30 Mar 2005 09:53:03 +0200." <OofSaT76.1112169183.7124470.khali@localhost> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 30 Mar 2005 13:09:32 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 30 Mar 2005 13:09:35 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jean Delvare" <khali@linux-fr.org> said:
> > > > No, there is a third case: the pointer can be NULL, but the compiler
> > > > happened to move the dereference down to after the check.

> > > Wow. Great point. I completely missed that possibility. In fact I didn't
> > > know that the compiler could possibly alter the order of the
> > > instructions. For one thing, I thought it was simply not allowed to. For
> > > another, I didn't know that it had been made so aware that it could
> > > actually figure out how to do this kind of things. What a mess. Let's
> > > just hope that the gcc folks know their business :)

> > The compiler is most definitely /not/ allowed to change the results the
> > code gives.

> I think that Andrew's point was that the compiler could change the order
> of the instructions *when this doesn't change the result*, not just in
> the general case, of course. In our example, The instructions:
> 
>     v = p->field;
>     if (!p) return;
> 
> can be seen as equivalent to
> 
>     if (!p) return;
>     v = p->field;

They are not. If p == NULL, the first gives an exception (SIGSEGV), the
second one doesn't. Just as you can't "optimize" by switching:

    x = b / a;   
    if (a == 0) return;
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
