Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUFPBRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUFPBRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 21:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUFPBRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 21:17:50 -0400
Received: from quechua.inka.de ([193.197.184.2]:5004 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266055AbUFPBRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 21:17:46 -0400
Date: Wed, 16 Jun 2004 03:17:43 +0200
From: Bernd Eckenfels <be-mail2004@lina.inka.de>
To: Trent Lloyd <lathiat@bur.st>
Cc: linux-net@vger.kernel.org
Subject: How to turn off IPV6 (link local)
Message-ID: <20040616011743.GA15385@lina.inka.de>
References: <20040614233215.GA10547@lina.inka.de> <20040615023022.GB24269@thump.bur.st> <20040615194657.GA7474@lina.inka.de> <20040616001630.GB24753@thump.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040616001630.GB24753@thump.bur.st>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 08:16:31AM +0800, Trent Lloyd wrote:
> Ahh, i see, however you would have to set autoconf to off then *remove*
> the link-local addresses, because they are setup before that variable is
> changed? [or is there an option for this in the kernel? afaik its just
> in proc (sysctl)]

you can set net.ipv6.conf.defaul.autoconf=0 and then up the interface. This
will prevent it from getting any  announced prefixes, but it wont prevent it
from getting linklocal prefix.

So my idea is, that autoconf=0 will prevent it from getting linklocal and
advertised adddresses and accept_ra=0 will prevent it from getting announced
prefixes.

> That said, the link-local addresses are *NOT* the issue here, and having
> them will not cause said problems, the problem here is the user has 4
> real world IPv6 addresses configured by a router on his network + user
> configuration (the 6to4 address).

Well, the user does not have them now anymore and Mozilla uses the
link-local. However I agree with you, that it might not help to remove
(prevent autoconfgration) because mozilla still might suceed in AF_INET6
binding and try the connect w/o failback.

> Check out http://www.sixlabs.org/talks/, in my IPv6 programming talk I
> have code showing how to use getaddrinfo() and try each address until
> one suceeds.

There is btw an additional issue with sending AAAA requests on a host which
is not fully configured for ipv6. In fact I think we should disable to
compile ipv6 into the kernel, its so painfull to turn the AF off.

Greetings
Bernd
-- 
  (OO)      -- Bernd_Eckenfels@Mörscher_Strasse_8.76185Karlsruhe.de --
 ( .. )      ecki@{inka.de,linux.de,debian.org}  http://www.eckes.org/
  o--o     1024D/E383CD7E  eckes@IRCNet  v:+497211603874  f:+497211606754
(O____O)  When cryptography is outlawed, bayl bhgynjf jvyy unir cevinpl!
