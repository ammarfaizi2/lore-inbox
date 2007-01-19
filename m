Return-Path: <linux-kernel-owner+w=401wt.eu-S964927AbXASOvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbXASOvu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXASOvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:51:50 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56549 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964927AbXASOvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:51:49 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 09:44:59 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Adrian Bunk <bunk@stusta.de>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
In-Reply-To: <20070119141355.GM9093@stusta.de>
Message-ID: <Pine.LNX.4.64.0701190939470.25798@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
 <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
 <20070119141355.GM9093@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Adrian Bunk wrote:

> On Fri, Jan 19, 2007 at 03:01:44PM +0200, Pekka Enberg wrote:
> > On 1/19/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> > >is there a simple explanation for how to *properly* define inline
> > >routines in the kernel?  and maybe this can be added to the
> > >CodingStyle guide (he mused, wistfully).
> >
> > AFAIK __always_inline is the only reliable way to force inlining where
> > it matters for correctness (for example, when playing tricks with
> > __builtin_return_address like we do in the slab).
> >
> > Anything else is just a hint to the compiler that might be ignored if
> > the optimizer thinks it knows better.
>
> With the current implementation in the kernel (and considering that
> CONFIG_FORCED_INLINING was implemented in a way that it never had
> any effect), __always_inline and inline are currently equivalent.

right, and that last part explains that snippet i previously posted
from include/asm-alpha/compiler.h

========================
#ifdef __KERNEL__
/* Some idiots over in <linux/compiler.h> thought inline should imply
   always_inline.  This breaks stuff.  We'll include this file whenever
   we run into such problems.  */
========================

  which is a result of this from include/linux/compiler.h:

========================

#define inline          inline          __attribute__((always_inline))
#define __inline__      __inline__      __attribute__((always_inline))
#define __inline        __inline        __attribute__((always_inline))

which certainly seems to suggest that *ever* explicitly stating
"always inline" is redundant, no?  maybe i'm missing something
critical here but this just seems wrong.

> __always_inline is mostly an annotation that really bad things might
> happen if the code doesn't get inlined.

and that makes sense.  it has no effect, it's more for just
commenting.  but it's still kind of misleading.

rday
