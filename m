Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269759AbTGKBs5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 21:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269760AbTGKBs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 21:48:57 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:21893 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S269759AbTGKBsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 21:48:54 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <1057888154.26854.324.camel@localhost>
References: <20030710154302.GE1722@zip.com.au>
	 <1057854432.3588.2.camel@hades>  <20030710233931.GG1722@zip.com.au>
	 <1057881869.3588.10.camel@hades>  <1057888154.26854.324.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057889037.3589.42.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 05:03:57 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 04:49, Andre Tomt wrote:
> > Setting your tunnel prefix to /64 is certainly the right thing to do. 
> 
> If you don't have anything but one /64 for example.. I guess /126's
> would be ok as you could rule out the the anycast address? It will
> probably work with Linux - but is it wrong in any sense, other than
> "breaking" with EUI-64/autoconfiguration?

It doesn't really make sense to use a prefix longer then /64. The last
64 bits are generally reserved for interface ID.

What you can do, though, is not configure a link prefix for the tunnel
at all. I.e. you can add the local tunnel end-point as a /128. This
won't create an on-link route in the routing table, so you need to point
the default route to the interface rather than the peer end-point. For
example:

ifconfig sit0 add 3ffe:dead:beef::dead:beef/128
ip route add ::/0 dev sit0

Cheers,

	MikaL

