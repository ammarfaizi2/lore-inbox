Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVDGNx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVDGNx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVDGNx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:53:28 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:16514 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262462AbVDGNxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:53:24 -0400
Message-Id: <200504070238.j372cGQN005597@laptop11.inf.utfsm.cl>
To: AsterixTheGaul <asterixthegaul@gmail.com>
cc: Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] disable built-in modules V2 
In-Reply-To: Message from AsterixTheGaul <asterixthegaul@gmail.com> 
   of "Thu, 07 Apr 2005 07:02:53 +0530." <54b5dbf505040618324186678a@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 06 Apr 2005 22:38:16 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 07 Apr 2005 09:52:52 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AsterixTheGaul <asterixthegaul@gmail.com> said:
> > -#define module_init(x) __initcall(x);
> > +#define module_init(x) __initcall(x); __module_init_disable(x);
> 
> It would be better if there is brackets around them... like
> 
> #define module_init(x) { __initcall(x); __module_init_disable(x); }
> 
> then we know it wont break some code like
> 
> if (..)
>  module_init(x);

But happily break:

   if (...)
    module_init(x);
   else
    ...

This should be:

#define module_init(x)  do {__initcall(x); __module_init_disable(x);}while(0)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
