Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbTIKWZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbTIKWZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:25:54 -0400
Received: from aneto.able.es ([212.97.163.22]:16875 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S261592AbTIKWZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:25:52 -0400
Date: Fri, 12 Sep 2003 00:25:48 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>, Jamie Lokier <jamie@shareable.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] kmalloc + memset(foo, 0, bar) = kmalloc0
Message-ID: <20030911222548.GC7221@werewolf.able.es>
References: <200309111540.58729@bilbo.math.uni-mannheim.de> <20030911134557.GV454@parcelfarce.linux.theplanet.co.uk> <20030911170944.GG29532@mail.jlokier.co.uk> <20030911215805.GA7221@werewolf.able.es> <1063318342.3886.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.12, Alan Cox wrote:
> On Iau, 2003-09-11 at 22:58, J.A. Magallon wrote:
> > On 09.11, Jamie Lokier wrote:
> > > viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > > Bad choice of name - too easy to confuse with kmalloc().
> > > 
> > > kmalloc_and_zero() would be much clearer.
> > > 
> > 
> > Why not kcalloc() ?
> 
> A kcalloc that also checked for maths overflows would probably
> help avoid various errors and checks against ~0/sizeof(n) in
> drivers we have now
> 

Some time ago when I tried to do some wrappers, I choosed something
like this (k-prefixed here for kernel...):

void* kalloc(size_t size)
void* kvalloc(size_t size,size_t num)
void* kallocz(size_t size) // or kalloc_z, clearer...
void* kvallocz(size_t size,size_t num) // kvalloc_z
void* kfree(void*)

And if you don't hate too much C++

#define knew(mytype) (mytype*)kalloc(sizeof(mytype))
#define kvnew(mytype,n) (mytype*)kvalloc(sizeof(mytype),n)

and so on...
I can tell for sure they clarify the code very much... and you
don't forget the NULL check anymore ;).

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
