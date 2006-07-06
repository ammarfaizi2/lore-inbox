Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWGFVII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWGFVII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 17:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWGFVII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 17:08:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44187 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWGFVIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 17:08:07 -0400
Date: Thu, 6 Jul 2006 14:07:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607062252350.10657@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0607061401100.3869@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607062132150.2809@yvahk01.tjqt.qr> <44AD71F7.6050204@goop.org>
 <Pine.LNX.4.61.0607062252350.10657@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Jan Engelhardt wrote:
> >
> > You need to exclude "asm volatile", which is a completely different thing.
> 
> 10077.

Yeah, way too many. 

That said, at least _some_ of them are:

 - casts to volatile inside arch-specific code serquences (ie the _good_ 
   kind of volatile - associated with _code_ rather than data). 

   See for example include/asm-i386/io.h for 100% valid examples of this
   kind of usage.

 - function argument values for functions that need to be able to take an 
   arbitrary pointer ("const volatile void *" is the most permissive 
   argument type - anything else the compiler can complain about you 
   dropping qualifiers)

   See include/asm-i386/bitops.h for examples of this kind of volatile.

So I'd expect that maybe one percent of them are actually valid ;)

And I suspect that a huge majority of the truly crapola ones are in 
drivers. Oh, well..

			Linus
