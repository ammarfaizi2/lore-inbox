Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269698AbTGJXZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269699AbTGJXZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:25:29 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:53889 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S269698AbTGJXZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:25:23 -0400
Date: Fri, 11 Jul 2003 09:39:31 +1000
From: CaT <cat@zip.com.au>
To: Mika Liljeberg <mika.liljeberg@welho.com>
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       pekkas@netcore.fi
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
Message-ID: <20030710233931.GG1722@zip.com.au>
References: <20030710154302.GE1722@zip.com.au> <1057854432.3588.2.camel@hades>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057854432.3588.2.camel@hades>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 07:27:13PM +0300, Mika Liljeberg wrote:
> On Thu, 2003-07-10 at 18:43, CaT wrote:
> > ip tunnel add sit1 mode sit remote 138.25.6.14
> > ip link set sit1 up
> > ip addr add 3ffe:8001:000c:ffff::37/127 dev sit1
> >  ip route add ::/0 via 3ffe:8001:000c:ffff::36 
> > RTNETLINK answers: Invalid argument
> 
> Try this:
> 
> ip route add ::/0 dev sit1

That didn't complain but pings to the ext gw were broken. Noticed the
route contained:

3ffe:8001:c:ffff::36/127 via :: dev sit1  proto kernel  metric 256  mtu 1480 adv
mss 1420

And having remembered /127 being mentioned as bad I changed the
interface config to a netmask of /64. Dropped it and brought it
up and it all works.

There's something fundamental about ipv6 netmasks that I just don't
understand...

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://www.toledoblade.com/apps/pbcs.dll/artikkel?SearchID=73139162287496&Avis=TO&Dato=20030624&Kategori=NEWS28&Lopenr=106240111&Ref=AR
