Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbTI1Xj7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTI1Xiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:38:51 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:2054 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262792AbTI1Xdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:33:42 -0400
Date: Sun, 28 Sep 2003 20:39:10 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: netdev@oss.sgi.com, davem@redhat.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030928233909.GG1039@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, netdev@oss.sgi.com, davem@redhat.com,
	pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928232403.GX15338@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 29, 2003 at 01:24:03AM +0200, Adrian Bunk escreveu:
> On Sun, Sep 28, 2003 at 08:18:42PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Sep 29, 2003 at 12:59:41AM +0200, Adrian Bunk escreveu:
> > > It seems modular IPv6 doesn't work 100% reliable, e.g. after looking at 
> > > the code it doesn't seem to be a good idea to compile a kernel without 
> > > IPv6 support and later build and install IPv6 modules. Is there a great 
> > > need for modular IPv6 or is the patch below to disallow modular IPv6 OK?
> > 
> > Please, don't... We're going in the all modules direction, not the other
> > way around, distro (general purpose) kernels would get big bloat in the
> > static kernel.
> 
> E.g. from include/net/tcp.h:
> 
> <--  snip  -->
> 
> ...
> struct tcp_skb_cb {
>         union {
>                 struct inet_skb_parm    h4;
> #if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
>                 struct inet6_skb_parm   h6;
> #endif
>         } header;       /* For incoming frames          */
> ...
> 
> <--  snip  -->
> 
> This is broken since it's legal to compile a module much later than the 
> kernel.
> 
> If modular IPv6 is allowed, the #if has to be removed, and the struct
> will be larger in the case IPv6 is never be used.

Its not just this, look at all the CONFIG_IPV6 related #ifdefs in the core
tcp/ip v4 code, the point is that this is a (currently) needed limitation to be
able to ship a kernel that can be used by both ipv6 users and people that
doesn't (yet) need ipv6.

Simply removing the ifdefs in the headers will not help, leaving it in the
kernel will bloat general purpose kernels, so can we live with this limitation
till we sort out the IPV6/IPV4 entanglement in a good way? I.e. lets leave ipv6
as a special case, perhaps just adding a big fat warning in relevant Kconfigs.

- Arnaldo
