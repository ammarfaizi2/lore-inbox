Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268182AbUI2EQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268182AbUI2EQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 00:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUI2EQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 00:16:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:5531 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268182AbUI2EQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 00:16:04 -0400
Subject: Re: [PATCH] Use msleep_interruptible for therm_adt7467.c kernel
	thread
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mdz@canonical.com, janitor@sternwelten.at
In-Reply-To: <20040929015827.GA26337@gondor.apana.org.au>
References: <20040927102552.GA19183@gondor.apana.org.au>
	 <1096289501.9930.19.camel@localhost.localdomain>
	 <20040929015827.GA26337@gondor.apana.org.au>
Content-Type: text/plain
Message-Id: <1096431194.17148.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 14:13:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 11:58, Herbert Xu wrote:
> On Mon, Sep 27, 2004 at 01:51:42PM +0100, Alan Cox wrote:
> > On Llu, 2004-09-27 at 11:25, Herbert Xu wrote:
> > > The continue is just paranoia in case something relies on the sleep
> > > to take 2 seconds or more.
> > 
> > If the signal occurs then you'll spin for 2 seconds because the signal
> > is still waiting to be serviced. This therefore looks broken
> 
> Yes you're right.  However I'd say that msleep_interruptible should
> mirror the behaviour of schedule_timeout and at least sleep once.

Mask all signals then, there is no need to get any signal in that
kernel thread anyway

> BTW, msleep_interruptible() is white-space damaged.  Can someone please
> fix it up?
> 
> > A more interesting question is why this isn't being driven off a
> > timer ?
> 
> It probably could if the stuff afterwards doesn't sleep.
> 
> Cheers,
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

