Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVDPQEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVDPQEk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVDPQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 12:04:40 -0400
Received: from mx03.cybersurf.com ([209.197.145.106]:34967 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S261785AbVDPQEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 12:04:25 -0400
Subject: Re: ACPI/HT or Packet Scheduler BUG?
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Thomas Graf <tgraf@suug.ch>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Steven Rostedt <rostedt@goodmis.org>, netdev <netdev@oss.sgi.com>,
       Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>, kuznet@ms2.inr.ac.ru,
       devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050416113446.GJ4114@postel.suug.ch>
References: <Pine.LNX.4.61.0504081225510.27991@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro>
	 <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro>
	 <1113601029.4294.80.camel@localhost.localdomain>
	 <1113601446.17859.36.camel@localhost.localdomain>
	 <1113602052.4294.89.camel@localhost.localdomain>
	 <20050415225422.GF4114@postel.suug.ch>
	 <20050416014906.GA3291@gondor.apana.org.au>
	 <20050416110639.GI4114@postel.suug.ch>
	 <20050416112329.GA31847@gondor.apana.org.au>
	 <20050416113446.GJ4114@postel.suug.ch>
Content-Type: text/plain
Organization: unknown
Date: Sat, 16 Apr 2005 12:04:07 -0400
Message-Id: <1113667447.7419.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-16-04 at 13:34 +0200, Thomas Graf wrote:
> * Herbert Xu <20050416112329.GA31847@gondor.apana.org.au> 2005-04-16 21:23
> > On Sat, Apr 16, 2005 at 01:06:39PM +0200, Thomas Graf wrote:
> > > 
> > > It's not completely useless, it speeds up the deletion classful
> > > qdiscs having some depth. However, it's not worth the locking
> > > troubles I guess.
> > 
> > RCU is meant to optimise the common reader path.  In this case
> > that's the packet transmission code.  Unfortunately it fails
> > miserably when judged by that criterion.
> 
> There is one case where it can do good for latency which is for
> per flow qdiscs or any other scenarios implying hundreds or
> thousands of leaf qdiscs where a destroyage of one such qdisc
> tree will take up quite some cpu to traverse all the classes
> under dev->queue_lock. I don't have any numbers on this, but
> I don't completely dislike the method of hiding the qdiscs under
> the lock and do the expensive traveling unlocked.

The rule of "optimize for the common" fails miserably in this case
because this is not a common case/usage of qdiscs.
I have a feeling though that the patch went in due to
dude-optimizing-loopback as pointed by Herbert. 
It could also be it was done because  RCU-is-so-cool. I dont recall.
Maybe worth reverting to the earlier scheme if it is going to continue
to be problematic.

cheers,
jamal

