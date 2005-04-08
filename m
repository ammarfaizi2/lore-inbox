Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVDHNPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVDHNPi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVDHNOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:14:43 -0400
Received: from nevyn.them.org ([66.93.172.17]:26523 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262828AbVDHNLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:11:43 -0400
Date: Fri, 8 Apr 2005 09:11:06 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: johnpol@2ka.mipt.ru, herbert@gondor.apana.org.au, akpm@osdl.org,
       guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-ID: <20050408131106.GB32099@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	johnpol@2ka.mipt.ru, herbert@gondor.apana.org.au, akpm@osdl.org,
	guillaume.thouvenin@bull.net, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <1112932969.28858.194.camel@uganda> <20050408040237.GA31761@gondor.apana.org.au> <1112934088.28858.199.camel@uganda> <20050408041724.GA32243@gondor.apana.org.au> <1112936127.28858.206.camel@uganda> <20050408045302.GA32600@gondor.apana.org.au> <1112937116.28858.212.camel@uganda> <20050408050814.GA32722@gondor.apana.org.au> <1112937579.28858.218.camel@uganda> <20050407230222.3a76ba46.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407230222.3a76ba46.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:02:22PM -0700, David S. Miller wrote:
> On Fri, 08 Apr 2005 09:19:39 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > > I know, the same thing holds for most architectures, including i386.
> > > However, this is not an issue for uni-processor kernels anywhere else,
> > > so what's so special about MIPS?
> > 
> > Does i386 or ppc has cached and uncached memory?
> 
> Yes, they do.
> 
> > No, i386, ppc and others do not require sync on uncached memory access,
> > and only instruction not data cache sync on SMP.
> 
> On MIPS, all the MIPS atomic operations will operate on cached memory.
> And as far as a uniprocessor cpu is concerned, updating the cache is
> all that matters.
> 
> In fact, this SYNC instruction seems unnecessary even on SMP.  If the
> cache is updated, it is part of the coherent memory space and thus
> MOESI main bus SMP cache coherency transactions will see the update
> value.  When another processor does a "read-to-share" or "read-to-own"
> request on the main bus, the processor which did the atomic OP will
> provide the correct data from it's cache in response to that transaction.
> 
> So what you have to do is show me an example where the MIPS kernel can
> do an atomic.h operation on uncached memory.  I even think that is
> invalid, come to think of it.

It better be...

My impression is that the MIPS story isn't so simple, because the
architecture only offers very weak coherency guarantees.  Most of the
SMP implementations offer strong coherency in practice, but at least
one (RM9000) doesn't.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
