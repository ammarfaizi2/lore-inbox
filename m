Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVDHGFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVDHGFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbVDHGFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:05:55 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:43944
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262695AbVDHGFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:05:49 -0400
Date: Thu, 7 Apr 2005 23:02:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, guillaume.thouvenin@bull.net,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-Id: <20050407230222.3a76ba46.davem@davemloft.net>
In-Reply-To: <1112937579.28858.218.camel@uganda>
References: <20050408033246.GA31344@gondor.apana.org.au>
	<1112932354.28858.192.camel@uganda>
	<20050408035052.GA31451@gondor.apana.org.au>
	<1112932969.28858.194.camel@uganda>
	<20050408040237.GA31761@gondor.apana.org.au>
	<1112934088.28858.199.camel@uganda>
	<20050408041724.GA32243@gondor.apana.org.au>
	<1112936127.28858.206.camel@uganda>
	<20050408045302.GA32600@gondor.apana.org.au>
	<1112937116.28858.212.camel@uganda>
	<20050408050814.GA32722@gondor.apana.org.au>
	<1112937579.28858.218.camel@uganda>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2005 09:19:39 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> > I know, the same thing holds for most architectures, including i386.
> > However, this is not an issue for uni-processor kernels anywhere else,
> > so what's so special about MIPS?
> 
> Does i386 or ppc has cached and uncached memory?

Yes, they do.

> No, i386, ppc and others do not require sync on uncached memory access,
> and only instruction not data cache sync on SMP.

On MIPS, all the MIPS atomic operations will operate on cached memory.
And as far as a uniprocessor cpu is concerned, updating the cache is
all that matters.

In fact, this SYNC instruction seems unnecessary even on SMP.  If the
cache is updated, it is part of the coherent memory space and thus
MOESI main bus SMP cache coherency transactions will see the update
value.  When another processor does a "read-to-share" or "read-to-own"
request on the main bus, the processor which did the atomic OP will
provide the correct data from it's cache in response to that transaction.

So what you have to do is show me an example where the MIPS kernel can
do an atomic.h operation on uncached memory.  I even think that is
invalid, come to think of it.
