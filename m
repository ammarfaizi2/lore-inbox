Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUI2EPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUI2EPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 00:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUI2EPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 00:15:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:4507 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268180AbUI2EPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 00:15:48 -0400
Subject: Re: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel
	thread
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mdz@canonical.com, janitor@sternwelten.at
In-Reply-To: <1096421071.14637.6.camel@localhost.localdomain>
References: <20040927102552.GA19183@gondor.apana.org.au>
	 <1096289501.9930.19.camel@localhost.localdomain>
	 <20040929015827.GA26337@gondor.apana.org.au>
	 <1096421071.14637.6.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1096431162.17114.10.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 14:12:43 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 11:24, Alan Cox wrote:
> On Mer, 2004-09-29 at 02:58, Herbert Xu wrote:
> > > A more interesting question is why this isn't being driven off a
> > > timer ?
> > 
> > It probably could if the stuff afterwards doesn't sleep.
> 
> schedule_work() ?

I don't like that. I wrote the g5 therm driver (from which this one is
derivated) as a kernel thread because, at least on the g5, I do a lot of
i2c accesses. If I were to do that in schedule_work, I would "hog" keventd
a very long time each time, which is bad.

schedule_work() is always way too much abused in this way, thus beeing
a source of latencies.

Creating my own work queue would have been silly since (at least back
then), it would have meant creating one additional kernel thread on every
CPU... so I decided just to create my own kernel thread and be done with
it.

Now, using a timer and waiting on it would eventually work too, but the
way it is now just works so ...

Ben.


