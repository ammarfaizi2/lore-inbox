Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAJcu>; Fri, 1 Dec 2000 04:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129260AbQLAJck>; Fri, 1 Dec 2000 04:32:40 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:15634 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129183AbQLAJc0>;
	Fri, 1 Dec 2000 04:32:26 -0500
Date: Fri, 1 Dec 2000 10:01:24 +0100
From: Francois romieu <romieu@cogenit.fr>
To: Ivan Passos <lists@cyclades.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
Message-ID: <20001201100124.A4986@se1.cogenit.fr>
Reply-To: romieu@ensta.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10011301103320.4692-100000@main.cyclades.com>; from lists@cyclades.com on Thu, Nov 30, 2000 at 11:16:52AM -0800
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[netdev Cced]

The Thu, Nov 30, 2000 at 11:16:52AM -0800, Ivan Passos wrote :
[...]
> For synchronous network interfaces, besides configuring network parameters
> such as IP address, netmask, MTU, etc., the system should also configure
> parameters specific to these sync i/f's, such as media (e.g V.35, X.21,
> T1, E1), clock (internal or external, and value if int.), protocol (e.g
> PPP, HDLC, Frame Relay), etc.
> What I noticed was that each synchronous board in Linux provides a
> different way of doing this, and it would be good for users to have a
> single, standard interface (such as ifconfig) to do this type of
> configuration. Maybe even patch ifconfig itself, I don't know ...
> 
> Questions:
> - Is there any existing _standard_ interface to do that??

No.

> - If not, is there any existing _standard_ infrastructure (e.g. ioctls and
>   structures) so that I can write an application to do that over this 
>   standard structure?

x25 does things like this:
#define SIOCX25GSUBSCRIP        (SIOCPROTOPRIVATE + 0)
#define SIOCX25SSUBSCRIP        (SIOCPROTOPRIVATE + 1)
...
Thus one could use private ioctl behind SIOCDEVPRIVATE and SIOCPROTOPRIVATE as
defined in include/linux/sockios.h. Something under /proc(/sys ?) is 
possible too but I would ask for the policy that applies to /proc before
coding.

> - If not, where would be the right place in the kernel to change in order 
>   to implement such infrastructure?

net/* for the protocol handler. 
include/linux/if_arp.h
include/linux/if_ether.h

Some place may be updated too:
net/lapb/*
net/x25/*
net/wanrouter
drivers/char/n_hdlc.c
drivers/net/wan/*

> I'm interested in implementing this, but I don't want to reinvent the
> wheel (if such wheel exists ...).

Ditto.

--
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
