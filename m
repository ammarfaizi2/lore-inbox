Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVITTmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVITTmy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 15:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVITTmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 15:42:54 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:31126 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965101AbVITTmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 15:42:53 -0400
Message-Id: <200509201941.j8KJf6hO002742@laptop11.inf.utfsm.cl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       penberg@cs.Helsinki.FI, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: p = kmalloc(sizeof(*p), ) 
In-Reply-To: Message from Alan Cox <alan@lxorguk.ukuu.org.uk> 
   of "Tue, 20 Sep 2005 19:02:41 +0100." <1127239361.7763.3.camel@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 20 Sep 2005 15:41:06 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 20 Sep 2005 15:41:06 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2005-09-20 at 10:11 -0700, Andrew Morton wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >  Since some of the other major contributors to the kernel appear to
> > >  also disagree with the statement, I think that the entry in
> > >  CodingStyle must be removed.

> > Nobody has put forward a decent reason for doing so.  

> I've seen five decent reasons so far. Which of the reasons on the thread
> do you disagree with and why ?

Not sure that I'm following the logic here, so...

For one, I leaned towards "p = malloc(sizeof(*p))" before, but the reasons
given for "p = malloc(sizeof struct foo))" (or even "p = (struct foo *)
malloc(sizeof(struct foo))", wrapped in a macro) did convince me.

The gains for a reader/maintainer/code auditor I see:

- It is easier to find it later
- Initialization of *p should be nearby, finding it by type name is useful
  for checking/updating
- It forces you to think a bit before typing it in, this should make making
  mistakes somewhat harder

The loss for a code writer are:

- (Marginally) more typing
- Have to know the type of *p [but if you don't, better don't touch it...]

If the writer has got the type wrong, she will initialize wrongly (and the
compile will blow up), so I don't see any advantage. The only other case
would be something like:

   p = malloc(sizeof(...));
   memset(p, v, sizeof(...));

As v is more often than not 0, this should really be:

   p = calloc(1, sizeof(...));

and perhaps in this case (with /no/ further initialization) it could be
called a tie. For uniformity's sake I'd prefer "sizeof(struct foo)"
everywhere.

In any case, give me help in finding bugs and updating code over (minor)
initial coding convenience everyday.

In any case, as the parallel flamewars conclusively demonstrate, writing it
down in CodingStyle won't make everybody agree on using it anyway, so I'd
vote for including the "sizeof(struct foo)" version there as recommended
practice.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
