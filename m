Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVDPSU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVDPSU7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 14:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVDPSU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 14:20:59 -0400
Received: from postel.suug.ch ([195.134.158.23]:15340 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S262715AbVDPSUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 14:20:54 -0400
Date: Sat, 16 Apr 2005 20:21:14 +0200
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Steven Rostedt <rostedt@goodmis.org>, netdev <netdev@oss.sgi.com>,
       Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>, kuznet@ms2.inr.ac.ru,
       devik@cdi.cz, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
Message-ID: <20050416182114.GL4114@postel.suug.ch>
References: <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain> <20050415225422.GF4114@postel.suug.ch> <20050416014906.GA3291@gondor.apana.org.au> <20050416110639.GI4114@postel.suug.ch> <20050416112329.GA31847@gondor.apana.org.au> <20050416113446.GJ4114@postel.suug.ch> <1113667447.7419.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113667447.7419.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* jamal <1113667447.7419.9.camel@localhost.localdomain> 2005-04-16 12:04
> The rule of "optimize for the common" fails miserably in this case
> because this is not a common case/usage of qdiscs.

I tend to agree. OTOH, I use exactly such setups... ;->

> I have a feeling though that the patch went in due to
> dude-optimizing-loopback as pointed by Herbert. 

I checked, it was in fact during the lockless loopback
optimizations.

> Maybe worth reverting to the earlier scheme if it is going to continue
> to be problematic.

Let me first check and see how the locking can be done at best, it
doesn't match the principles in sch_generic.c anyway at the moment
so once we know how to do the locking efficient and how to remove the
error proneess we can see if the optimization fits in without problems
and make a call.
