Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLANoz>; Fri, 1 Dec 2000 08:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129255AbQLANop>; Fri, 1 Dec 2000 08:44:45 -0500
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:35063 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S129248AbQLANoc>; Fri, 1 Dec 2000 08:44:32 -0500
Date: Fri, 1 Dec 2000 14:14:00 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@IWR.Uni-Heidelberg.De>
To: Chris Wedgwood <cw@f00f.org>
cc: <romieu@ensta.fr>, Ivan Passos <lists@cyclades.com>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [RFC] Configuring synchronous interfaces in Linux
In-Reply-To: <20001201233227.A9457@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.30.0012011359270.7367-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000, Chris Wedgwood wrote:

> Actually; Ethernet badly needs something like this too. I would kill
> to be able to do something like:
>
> 	ifconfig eth0 speed 100 duplex full

Even if you are thinking about Ethernet only, it's not easy to do it. Most
modern NICs have MII transceivers, where media setting is more or less
following a standard. All drivers written by Donald Becker and probably
everything derived from them support MII get/set operations from
user-space through ioctls, using mii-diag (from ftp.scyld.com).
But there are NICs which do not have MII transceivers and media
setting/selection is NIC-specific. Take a look at the media specific
module options for several drivers (e.g. 3c59x and tulip) and you'll see
what I'm talking about.

Moreover, with the proposed ifconfig interface, there is a problem: do you
want the media setting to be locked ? Quite a lot of NICs can do
NWAY autonegotiation or the driver can go through the available modes
trying to get one working. So if you say "I want to use this speed", do
you want to specifically use that speed or give it just as a starting
point for the driver which can decrease the speed in case it's not able to
get it ? (the example is Ethernet specific, but the ideea is not).

And finally (also Ethernet specific): some devices don't like forced
media settings when they support autonegotiation. Look at the tulip recent
archives for examples.

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
