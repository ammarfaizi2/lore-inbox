Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUF1RsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUF1RsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUF1RsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 13:48:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63750 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265099AbUF1RsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 13:48:01 -0400
Date: Mon, 28 Jun 2004 18:47:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.6: IPv6 initialisation bug
Message-ID: <20040628184758.C9214@flint.arm.linux.org.uk>
Mail-Followup-To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20040628010200.A15067@flint.arm.linux.org.uk> <20040629.020627.76560474.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040629.020627.76560474.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Tue, Jun 29, 2004 at 02:06:27AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 02:06:27AM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <20040628010200.A15067@flint.arm.linux.org.uk> (at Mon, 28 Jun 2004 01:02:01 +0100), Russell King <rmk+lkml@arm.linux.org.uk> says:
> 
> > Ok, I've just tried 2.6.7 out on my root-NFS'd firewall with IPv6 built
> > in, and it doesn't work because of the problem I described below.
> :
> > What's the solution?
> 
> Bring lo up before bring others up.
> What does prevent you from doing this?
> (Do we need some bits to do this automatically?)

When you use root-NFS, the kernel itself brings up the interfaces,
and IPv6 immediately comes in and tries to configure itself to them,
trying to create the routes.

Unfortunately, the kernel doesn't bring up lo first because it
doesn't know to do that.

> > Is there a good reason why IPv6 uses the loopback device for local
> > routes?
> 
> IPv6 creates kernel routes for local addresses on lo to receive
> packets for local address.
> 
> Well, someone probably wants to have
> static local routes on ethX + temprary (cache) local routes on lo
> (as IPv4 does; correct me if I'm wrong.)

This would be preferable I think - it certainly would stop systems
exploding when you take lo down for whatever reason, even temporarily.
Currently, if you do that, all your IPv6 local routes die off and
you're left trying to forward your own local address out various
itnerfaces.

> But this won't work because IPv6 does DAD when we make some interface up.
> We need lo anyway.

Sorry, I don't understand how this has a bearing on which device the
local routes are attached to.

How come IPv4 can be happy having local routes attached to the
individual interface, yet IPv6 can't be?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
