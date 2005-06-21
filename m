Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVFUPSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVFUPSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVFUPRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:17:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3033 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262117AbVFUPPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:15:36 -0400
Message-Id: <200506211515.j5LFFMkJ026010@laptop11.inf.utfsm.cl>
To: Pavel Machek <pavel@suse.cz>
cc: domen@coderock.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/2] kernel/power/disk.c string fix and if-less iterator 
In-Reply-To: Message from Pavel Machek <pavel@suse.cz> 
   of "Tue, 21 Jun 2005 00:10:41 +0200." <20050620221041.GI2222@elf.ucw.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 21 Jun 2005 11:15:22 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 21 Jun 2005 11:15:17 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
> domen@coderock.org said:
> > The attached patch:

> > o  Fixes kernel/power/disk.c string declared as 'char *p = "...";' to be
> >    declared as 'char p[] = "...";', as pointed by Jeff Garzik.
> 
> ? Why was char *p ... wrong? Because you could not do sizeof() later?

Note also that this increases the stack usage of the function and slows it
down, as this means allocating an array and filling it in at call time.

> 
> > o  Replaces:
> > 	i++:
> > 	if (i > 3) i = 0;
> > 
> >    By:
> > 	i = (i + 1) % (sizeof(p) - 1);
> > 
> >    Which is if-less, and the adjust value is evaluated by the compiler in
> >    compile-time in case the string related to this loop is modified.
> 
> Well, why not...

Because for that it could be done with a #define of the string... and it is
not that this could change any time soon, so IMHO a constant 3 + comment
would be fine.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
