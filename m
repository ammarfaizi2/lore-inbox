Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbTI2O3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTI2O3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:29:38 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:42182 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263440AbTI2O3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:29:33 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030929141548.GS1039@conectiva.com.br>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de>
	 <20030929003229.GM1039@conectiva.com.br>
	 <1064826174.29569.13.camel@hades.cambridge.redhat.com>
	 <20030929141548.GS1039@conectiva.com.br>
Content-Type: text/plain
Message-Id: <1064845765.21551.13.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 29 Sep 2003 15:29:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-29 at 11:15 -0300, Arnaldo Carvalho de Melo wrote:
> > The underlying point being that your static kernel should not change if
> > you change an option from 'n' to 'm'.
> 
> But that will only happen if CONFIG_IPV6_SUPPORT is always enabled, no?

No. It (kernel changing according to 'm' options) happens at the moment,
and it's evil and broken. Adrian proposes that it should not happen at
all.

The suggestion is that if your kernel was built with
'CONFIG_ALLOW_IPV6_SUPPORT=y' then it has all the structures etc. of the
right size, and the tristate option 'CONFIG_IPV6' becomes available. If
you build with 'CONFIG_ALLOW_IPV6_SUPPORT=n' then you cannot build IPv6.

> > It should only affect the kernel image if you change options to/from 'y'.
> 
> That is a good goal, yes, so lets remove all the ifdefs around EXPORT_SYMBOL,
> etc, i.e.: add bloat for the simple case were I want a minimal kernel.

So build with CONFIG_MODULES=n.

> Humm, so the user will have, in this case, these choices:
> 
> 1. "I don't want IPV6 at all, not now, not ever":
> 	CONFIG_IPV6_SUPPORT=N
> 	CONFIG_IPV6=N  (this is implicit as this depends on
> 			CONFIG_IPV6_SUPPORT)
> 	
> 2. "I think I may well want it the future, who knows? but not now...":
> 	CONFIG_IPV6_SUPPORT=Y
> 	CONFIG_IPV6=N
> 	
> 3. "Nah, some of the users of this pre-compiled kernel will need it":
> 	CONFIG_IPV6_SUPPORT=Y
> 	CONFIG_IPV6=M
> 	
> 4. "Yeah, IPV6 is COOL, how can somebody not use this piece of art?":
> 	CONFIG_IPV6_SUPPORT=Y
> 	CONFIG_IPV6=Y
> 
> Isn't this confusing for the I-wanna-triple-my-kernel-performance-by-compiling-
> the-kernel-for-exactly-what-I-have hordes of users?

No. It's very clear. 

But the current situation is confusing, where you set 'CONFIG_IPV6=m'
and 'make modules' to build IPv6 support since it appears to be modular,
and then the module either doesn't load or loads and oopses due to
structures changing in size. 

-- 
dwmw2

