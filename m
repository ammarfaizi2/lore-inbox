Return-Path: <linux-kernel-owner+w=401wt.eu-S965164AbXASPD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbXASPD7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 10:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbXASPD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 10:03:59 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58632 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965164AbXASPD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 10:03:58 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 09:53:21 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Adrian Bunk <bunk@stusta.de>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
In-Reply-To: <20070119141355.GM9093@stusta.de>
Message-ID: <Pine.LNX.4.64.0701190948170.25843@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
 <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
 <20070119141355.GM9093@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Adrian Bunk wrote:

> With the current implementation in the kernel (and considering that
> CONFIG_FORCED_INLINING was implemented in a way that it never had
> any effect), __always_inline and inline are currently equivalent.

yes, that option was implemented in a half-assed sort of way.  if you
look at compiler-gcc4.h, at first glance the preprocessing looks like
it's doing the right thing for that config option:

==================================
#include <linux/compiler-gcc.h>

#ifdef CONFIG_FORCED_INLINING
# undef inline
# undef __inline__
# undef __inline
# define inline                 inline          __attribute__((always_inline))
# define __inline__             __inline__      __attribute__((always_inline))
# define __inline               __inline        __attribute__((always_inline))
#endif
==================================

  but it's too late for checking that kernel config option, since
compiler-gcc.h has already been included, which includes:

==================================
#define inline          inline          __attribute__((always_inline))
#define __inline__      __inline__      __attribute__((always_inline))
#define __inline        __inline        __attribute__((always_inline))
==================================

so, as you say, "__always_inline and inline are currently equivalent".
which is sort of confusing and might come as a nasty surprise to some
developers who weren't expecting that.

rday

