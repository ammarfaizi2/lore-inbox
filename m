Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030771AbWKOSFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030771AbWKOSFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030787AbWKOSFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:05:04 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:8613 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030771AbWKOSFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:05:00 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Wed, 15 Nov 2006 19:05:04 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <20061115173252.GA24062@elte.hu> <455B557C.7020602@goop.org>
In-Reply-To: <455B557C.7020602@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151905.04712.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 18:59, Jeremy Fitzhardinge wrote:
> Ingo Molnar wrote:
> > i said this before: using segmentation tricks these days is /insane/.
> > Segmentation is not for free, and it's not going to be cheap in the
> > future. In fact, chances are that it will be /more/ expensive in the
> > future, because sane OSs just make no use of them besides the trivial
> > "they dont even exist" uses.
>
> Many, many systems use %fs/%gs to implement some kind of thread-local
> storage, and such usage is becoming more common; the PDA's use of it in
> the kernel is no different.  I would agree that using all the obscure
> corners of segmentation is just asking for trouble, but using %gs as an
> address offset seems like something that's going to be efficient on x86
> 32/64 processors indefinitely.
>
> > so /at a minimum/, as i suggested it before, the kernel's segment use
> > should not overlap that of glibc's. I.e. the kernel should use %fs, not
> > %gs.
>
> Last time you raised this I did a pretty comprehensive set of tests
> which showed there was flat out zero difference between using %fs and
> %gs.  There doesn't seem to be anything to the theory that reloading a
> null segment selector is in any way cheaper than loading a real
> selector.  Did you find a problem in my methodology?

I have the feeling (most probably wrong, but I prefer to speak than keeping 
this for myself) that the cost of segment load is delayed up to the first use 
of a segment selector. Sort of a lazy reload...

I had this crazy idea while looking at oprofile numbers

