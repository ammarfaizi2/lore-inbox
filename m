Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUHQVFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUHQVFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266741AbUHQVFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:05:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19670 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268440AbUHQVBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:01:06 -0400
Date: Tue, 17 Aug 2004 23:00:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jakub Bogusz <qboosh@pld-linux.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.8.1 - unresolved xfrm symbols in ip6_tunnel
Message-ID: <20040817210058.GU1387@fs.tum.de>
References: <20040817203013.GA31993@satan.blackhosts>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817203013.GA31993@satan.blackhosts>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 10:30:13PM +0200, Jakub Bogusz wrote:

> I've just got:
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.8.1; fi
> WARNING: /lib/modules/2.6.8.1/kernel/net/ipv6/ip6_tunnel.ko needs unknown symbol xfrm6_tunnel_register
> WARNING: /lib/modules/2.6.8.1/kernel/net/ipv6/ip6_tunnel.ko needs unknown symbol xfrm6_tunnel_deregister
> 
> with
> CONFIG_IPV6_TUNNEL=m
> and no XFRM (it wasn't selected by IPV6_TUNNEL and it's not possible to
> select it standalone - XFRM is selected only by some options which
> I don't use).
> 
> So I think that IPV6_TUNNEL should select or depend on XFRM...
> or usage of the above symbols should depend on CONFIG_XFRM ||
> CONFIG_XFRM_MODULE?

Thanks for this report.

It's a known bug.

Below is the patch from -mm fixing this issue.

@Andrew:
Can you push fw-new-linux-268-rc4-mm1-ipv6-in-ipv6-undefined-references 
with the next updates to Linus?

> Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

cu
Adrian


<--  snip  -->


From: Herbert Xu <herbert@gondor.apana.org.au>

Fix bug #3200

*** Warning: "xfrm6_tunnel_deregister" [net/ipv6/ip6_tunnel.ko] undefined!
*** Warning: "xfrm6_tunnel_register" [net/ipv6/ip6_tunnel.ko] undefined!

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/net/ipv6/Kconfig |    1 +
 1 files changed, 1 insertion(+)

diff -puN net/ipv6/Kconfig~fw-new-linux-268-rc4-mm1-ipv6-in-ipv6-undefined-references net/ipv6/Kconfig
--- 25/net/ipv6/Kconfig~fw-new-linux-268-rc4-mm1-ipv6-in-ipv6-undefined-references	2004-08-15 17:33:34.718683088 -0700
+++ 25-akpm/net/ipv6/Kconfig	2004-08-15 17:33:34.721682632 -0700
@@ -59,6 +59,7 @@ config INET6_IPCOMP
 config IPV6_TUNNEL
 	tristate "IPv6: IPv6-in-IPv6 tunnel"
 	depends on IPV6
+	select XFRM
 	---help---
 	  Support for IPv6-in-IPv6 tunnels described in RFC 2473.
 
_
