Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWGFO0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWGFO0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWGFO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:26:51 -0400
Received: from cantor2.suse.de ([195.135.220.15]:20438 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030291AbWGFO0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:26:49 -0400
From: Andreas Schwab <schwab@suse.de>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu>
	<20060705101059.66a762bf.akpm@osdl.org>
	<20060705193551.GA13070@elte.hu>
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
X-Yow: I'm having a MID-WEEK CRISIS!
Date: Thu, 06 Jul 2006 16:26:38 +0200
In-Reply-To: <20060706153955.0740b934@werewolf.auna.net> (J. A.
 =?iso-8859-1?Q?Magall=F3n's?=
	message of "Thu, 6 Jul 2006 15:39:55 +0200")
Message-ID: <jebqs2x10h.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallón" <jamagallon@ono.com> writes:

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
>
> register int tmp_a = *ina;
> register int tmp_b = *inb;
>
> for (int i=0; i<10; i++)
> {
> 	a[i] = tmp_a;
> 	b[i] = tmp_b;
> }
>
> because nor 'ina' nor 'inb' change under what the compiler sees inside
> the loop. 'volatile' prevents the compiler of do a high level cache of
> *ina or *inb.

Actually the compiler may not do any of these transformations because *ina
or *inb may alias any of a[i] or b[i].

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
