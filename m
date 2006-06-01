Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWFAIML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWFAIML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 04:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWFAIML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 04:12:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22205 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750781AbWFAIMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 04:12:09 -0400
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
From: Arjan van de Ven <arjan@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, pauldrynoff@gmail.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060601080913.GA26955@gondor.apana.org.au>
References: <20060530195417.e870b305.pauldrynoff@gmail.com>
	 <20060530132540.a2c98244.akpm@osdl.org>
	 <20060531181926.51c4f4c5.pauldrynoff@gmail.com>
	 <1149085739.3114.34.camel@laptopd505.fenrus.org>
	 <20060531102128.eb0020ad.akpm@osdl.org> <447DFE29.6040508@linux.intel.com>
	 <20060531142525.5a22f9f1.akpm@osdl.org> <447E097C.2020707@linux.intel.com>
	 <20060601080913.GA26955@gondor.apana.org.au>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 10:12:02 +0200
Message-Id: <1149149522.3115.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 18:09 +1000, Herbert Xu wrote:
> On Wed, May 31, 2006 at 09:24:12PM +0000, Arjan van de Ven wrote:
> > 
> > misrouted_irq() in kernel/irq/spurious.c
> > afaics that calls all handlers registered to the system regardless of what
> > irq number they are registered for.....
> > 
> > which breaks the disable_irq() locking trick... because your irq handler now
> > gets called anyway!
> 
> This is a serious bug in misrouted_irq().  disable_irq() is a software
> state and must be repsected.

no that is not correct.
The api is a mix kinda and broken; it really DOES mean "shut this irq
source off". That your handler won't get called is an assumption!
You do NOT disable your handler this way.
What we really need is a disable_irq_handler() api that does both!

(you may say I'm handwaving, but if disable_irq() would disable a
handler, it for sure would have taken a "handler" argument, which it
doesn't!)


