Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbVITL5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVITL5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 07:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVITL5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 07:57:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20132 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964980AbVITL5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 07:57:09 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: p = kmalloc(sizeof(*p), )
Date: Tue, 20 Sep 2005 14:56:04 +0300
User-Agent: KMail/1.8.2
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <84144f0205092004187f86840c@mail.gmail.com> <20050920114003.GA31025@flint.arm.linux.org.uk>
In-Reply-To: <20050920114003.GA31025@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509201456.04851.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >         p = kmalloc(sizeof(*p), ...)
> > > 
> > >    is not grep-friendly, and can not be used to identify potential
> > >    initialisation sites.  However:
> > > 
> > >         p = kmalloc(sizeof(struct foo), ...)
> > > 
> > >    is grep-friendly, and will lead you to inspect each place where
> > >    such a structure is allocated for correct initialisation.
> > 
> > I would disagree on this one. You can still grep all the places where
> > the local variable is declared in. Furthermore, structs are not always
> > initialized where they're kmalloc'd so you need to manually inspect
> > anyway.
> 
> Think about it some more.  You've added a new member to struct foo.
> You want to fix up all the places which allocate struct foo to
> initialise this new member.  Grepping for 'struct foo' returns 100
> files.  Grepping for kmalloc in those 100 files returns 100 files.
> 
> Do you open all 100 in an editor and manually try and locate the five
> kmalloc instances of this structure, and end up missing some.
> 
> Or do you do the sane thing and use kmalloc(sizeof(struct foo), ...)
> and grep for "kmalloc[[:space:]]*(sizeof[[:space:]]*(struct foo)"
> which returns only the five files and fix those up with knowledge
> that you've found all the instances?

Both are inferior to Alans macro

p = typed_kmalloc(struct foo, ...);

which has greppable struct name, saves typing sizeof() and also
gives you typechecking (fails with "pointers to different types"
if p is not struct foo*).
--
vda
