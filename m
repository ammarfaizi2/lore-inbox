Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbQLBTir>; Sat, 2 Dec 2000 14:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbQLBTih>; Sat, 2 Dec 2000 14:38:37 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:34680 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129700AbQLBTiY> convert rfc822-to-8bit; Sat, 2 Dec 2000 14:38:24 -0500
Date: Sat, 2 Dec 2000 13:07:29 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Donald Becker <becker@scyld.com>, Francois Romieu <romieu@cogenit.fr>,
        Russell King <rmk@arm.linux.org.uk>, Ivan Passos <lists@cyclades.com>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
In-Reply-To: <20001203075958.A1121@metastasis.f00f.org>
Message-ID: <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Dec 2000, Chris Wedgwood wrote:
>     > Russell King <rmk@arm.linux.org.uk> écrit :
>     > [...]
>     > > We already have a standard interface for this, but many drivers do not
>     > > support it.  Its called "ifconfig eth0 media xxx":

> Actually, I starteed work on adding this to the 3c59x code last
> night; I am now a little dispondent though as it wasn't as simple as
> I first thought it might be.

Does 'ifconfig eth0 media xxx' wind up calling dev->set_config?

If yes, my guess is correct, I think the proper solution is to:
* create a generic set_config, which does nothing but convert the calls'
semantics into ethtool semantics, and
* add ethtool support to the specific driver

And you might even go so far as to create a generic MII implementation
of ethtool support, so that existing drivers can simply plug in their
mdio_{read,write} functions to automatically get full ethtool support.
(disclaimer:  this is a spur-of-the-moment thought, creating a generic
MII module for ethtool support may not be feasible)

drivers/net/sis900.c implements set_config, if you want an example..

Finally, if you want to just use ethtool directly, grab the SRPM and
install it on your system.

	Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
