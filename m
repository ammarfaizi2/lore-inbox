Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTI2OKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbTI2OKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:10:31 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:50954 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262183AbTI2OK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:10:29 -0400
Date: Mon, 29 Sep 2003 11:15:48 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030929141548.GS1039@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	David Woodhouse <dwmw2@infradead.org>, Adrian Bunk <bunk@fs.tum.de>,
	netdev@oss.sgi.com, davem@redhat.com, pekkas@netcore.fi,
	lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de> <20030928233909.GG1039@conectiva.com.br> <20030929001439.GY15338@fs.tum.de> <20030929003229.GM1039@conectiva.com.br> <1064826174.29569.13.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064826174.29569.13.camel@hades.cambridge.redhat.com>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 29, 2003 at 10:02:55AM +0100, David Woodhouse escreveu:
> On Sun, 2003-09-28 at 21:32 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Sep 29, 2003 at 02:14:39AM +0200, Adrian Bunk escreveu:
> > > On Sun, Sep 28, 2003 at 08:39:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > > What about the following solution (the names and help texts for the
> > > config options might not be optimal, I hope you understand the
> > > intention):
> > > 
> > > config IPV6_SUPPORT
> > > 	bool "IPv6 support"
> > > 
> > > config IPV6_ENABLE
> > > 	tristate "enable IPv6"
> > > 	depends on IPV6_SUPPORT
> > > 
> > > IPV6_SUPPORT changes structs etc. and IPV6_ENABLE is responsible for 
> > > ipv6.o .
> > 
> > Humm, and the idea is? This seems confusing, could you elaborate on why such
> > scheme is a good thing?
> 
> The idea is that you then have ifdefs on CONFIG_IPV6_SUPPORT not on
> CONFIG_IPV6_MODULE.

That part I understood :)
 
> The underlying point being that your static kernel should not change if
> you change an option from 'n' to 'm'.

But that will only happen if CONFIG_IPV6_SUPPORT is always enabled, no?

> It should only affect the kernel image if you change options to/from 'y'.

That is a good goal, yes, so lets remove all the ifdefs around EXPORT_SYMBOL,
etc, i.e.: add bloat for the simple case were I want a minimal kernel.

Humm, so the user will have, in this case, these choices:

1. "I don't want IPV6 at all, not now, not ever":
	CONFIG_IPV6_SUPPORT=N
	CONFIG_IPV6=N  (this is implicit as this depends on
			CONFIG_IPV6_SUPPORT)
	
2. "I think I may well want it the future, who knows? but not now...":
	CONFIG_IPV6_SUPPORT=Y
	CONFIG_IPV6=N
	
3. "Nah, some of the users of this pre-compiled kernel will need it":
	CONFIG_IPV6_SUPPORT=Y
	CONFIG_IPV6=M
	
4. "Yeah, IPV6 is COOL, how can somebody not use this piece of art?":
	CONFIG_IPV6_SUPPORT=Y
	CONFIG_IPV6=Y

Isn't this confusing for the I-wanna-triple-my-kernel-performance-by-compiling-
the-kernel-for-exactly-what-I-have hordes of users?

- Arnaldo
