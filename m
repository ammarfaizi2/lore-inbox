Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVG2PuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVG2PuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVG2PuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:50:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6887 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262607AbVG2PtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:49:18 -0400
Date: Fri, 29 Jul 2005 17:49:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050729154900.GA8919@elte.hu>
References: <20050729151804.28355.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729151804.28355.qmail@science.horizon.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* linux@horizon.com <linux@horizon.com> wrote:

> I think this pretty clearly points out the need for some arch-generic 
> infrastructure in Linux.  An awful lot of arch hooks are for one or 
> two architectures with some peculiarities, and the other 90% of the 
> implementations are identical.
> 
> For example, this is 22 repetitions of
> #define MIN_KERNEL_STACK_FOOTPRINT L1_CACHE_BYTES
> 
> with one different case.

this just primes all the architectures so that they build. Every 
architecture should then adjust these parameters. Also, since the 
patches are not final yet i didnt try to widen them too much.

> It would be awfully nice if there was a standard way to provide a 
> default implementation that was automatically picked up by any 
> architecture that didn't explicitly override it.

that used to be the ARCH_HAS_* flags & macros - but these days we prefer 
clean inline functions defined per arch, no ifdefs.

If there is something that is truly shared between all arches then an 
asm-generic/*.h file can be generated for it, and included from most 
arches. I dont think the changes i did will necessiate that.

	Ingo
