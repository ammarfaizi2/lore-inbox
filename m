Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWGFNnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWGFNnW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWGFNnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:43:22 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7345 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030264AbWGFNnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:43:21 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: "J.A." =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060706153955.0740b934@werewolf.auna.net>
References: <20060705114630.GA3134@elte.hu>
	 <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu>
	 <20060705131824.52fa20ec.akpm@osdl.org>
	 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org>
	 <20060705204727.GA16615@elte.hu>
	 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org>
	 <20060705214502.GA27597@elte.hu>
	 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org>
	 <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
	 <20060706081639.GA24179@elte.hu>
	 <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
	 <1152187268.3084.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0607060816110.8320@chaos.analogic.com>
	 <1152189583.3084.32.camel@laptopd505.fenrus.org>
	 <20060706153955.0740b934@werewolf.auna.net>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 15:43:14 +0200
Message-Id: <1152193394.3084.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I did not talk about memory barriers. In fact, barrier() is NOT a memory
> > barrier. It's a compiler optimization barrier!
> > 
> 
> // Read 10 samples from 2 A/D converters.
> 
> int*	ina;
> int	a[10];
> int*	inb;
> int	b[10];
> 
> for (int i=0; i<10; i++)
> {
> 	a[i] = *ina;
> 	barrier();
> 	b[i] = *inb;
> }
> 
> The barrier prevents the compiler of translating this to:
> 
> for (int i=0; i<10; i++)
> {
> 	b[i] = *inb;
> 	a[i] = *ina;
> }
> 
> or even to:
> 
> for (int i=0; i<10; i++)
> 	a[i] = *ina;
> for (int i=0; i<10; i++)
> 	b[i] = *inb;
> 
> but does not prevent it to do this:

yes it does. It's a full optimization barrier; the compiler assumes all
register and memory content has changed from before the barrier(), and
it will start "fresh".


