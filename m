Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWFKVy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWFKVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWFKVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:54:28 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:49360 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750952AbWFKVy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:54:27 -0400
Date: Sun, 11 Jun 2006 23:54:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: rdunlap@xenotime.net, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during modpost
Message-ID: <20060611215404.GA27380@mars.ravnborg.org>
References: <200606111437.k5BEbVu5021415@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606111437.k5BEbVu5021415@harpo.it.uu.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2006 at 04:37:31PM +0200, Mikael Pettersson wrote:
> On Sat, 10 Jun 2006 22:38:00 +0200, Sam Ravnborg wrote:
> >> --- linux-2617-rc6.orig/drivers/net/ne.c
> >> +++ linux-2617-rc6/drivers/net/ne.c
> >> @@ -829,7 +829,7 @@ that the ne2k probe is the last 8390 bas
> >>  is at boot) and so the probe will get confused by any other 8390 cards.
> >>  ISA device autoprobes on a running machine are not recommended anyway. */
> >>  
> >> -int init_module(void)
> >> +int __init init_module(void)
> >>  {
> >>  	int this_dev, found = 0;
> >
> >When you anyway touches the driver I suggest to name the function
> ><module>_init, <module>_cleanup and use module_init(), module_cleanup().
> 
> Maybe not: in the ne.c driver init_module() is inside #ifdef MODULE,
> so conversion to ne_init() + module_init(ne_init) would be a no-op
> except for making the code larger. In the non-MODULE case Space.c
> calls ne_probe() directly.
The whole purpose of marking a function __init is to place in in a
section that can be discarded after init. This has the added advantage
that it kills off some ugly #ifdef MODULE / #endif as is the case for
ne.c

Even if not discarded then the code cleaniness is preferable to #ifdef /
#endif if purpose is only to save a few bytes.

Shifting to module_init(), module_cleanup() is the only right thing to
do - and the old behaviour is not even documented in LDD3 anymore.
[At least I did not find it last time I searched].

	Sam
