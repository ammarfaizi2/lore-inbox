Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTI1XYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 19:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTI1XYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 19:24:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63445 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262739AbTI1XYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 19:24:06 -0400
Date: Mon, 29 Sep 2003 01:24:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, netdev@oss.sgi.com,
       davem@redhat.com, pekkas@netcore.fi,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
Message-ID: <20030928232403.GX15338@fs.tum.de>
References: <20030928225941.GW15338@fs.tum.de> <20030928231842.GE1039@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928231842.GE1039@conectiva.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 08:18:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Sep 29, 2003 at 12:59:41AM +0200, Adrian Bunk escreveu:
> > It seems modular IPv6 doesn't work 100% reliable, e.g. after looking at 
> > the code it doesn't seem to be a good idea to compile a kernel without 
> > IPv6 support and later build and install IPv6 modules. Is there a great 
> > need for modular IPv6 or is the patch below to disallow modular IPv6 OK?
> 
> Please, don't... We're going in the all modules direction, not the other
> way around, distro (general purpose) kernels would get big bloat in the
> static kernel.

E.g. from include/net/tcp.h:

<--  snip  -->

...
struct tcp_skb_cb {
        union {
                struct inet_skb_parm    h4;
#if defined(CONFIG_IPV6) || defined (CONFIG_IPV6_MODULE)
                struct inet6_skb_parm   h6;
#endif
        } header;       /* For incoming frames          */
...

<--  snip  -->

This is broken since it's legal to compile a module much later than the 
kernel.

If modular IPv6 is allowed, the #if has to be removed, and the struct
will be larger in the case IPv6 is never be used.

> - Arnaldo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

