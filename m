Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264702AbSLaTOl>; Tue, 31 Dec 2002 14:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLaTOl>; Tue, 31 Dec 2002 14:14:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60937 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264702AbSLaTOk>; Tue, 31 Dec 2002 14:14:40 -0500
Date: Tue, 31 Dec 2002 11:17:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: make gigabit ethernet into a real submenu
In-Reply-To: <20021231080146.GQ21097@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0212311107480.2697-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 31 Dec 2002, Tomas Szepe wrote:
> 
> The attached unidiff creates a parent entry for all gigabit ethernet
> interfaces, making the submenu consistent with that of 10/100.  Suggested
> by Robert P. J. Day.  Trivial patch against 2.5-bkcurrent.

Hmm.. Wouldn't it be nicer to instead of :

   ...
	 menu "Ethernet (1000 Mbit)"
	        depends on NETDEVICES
	 
	+config NET_GIGABIT_ETH
	+       bool "Ethernet (1000 Mbit)"
	+       ---help---
	+         Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
   ...

have

   ...
	+config NET_GIGABIT_ETH
        +       bool "Ethernet (1000 Mbit)"
	+	depends on NETDEVICES
        +       ---help---
        +         Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
	   ... 
	menu "Ethernet (1000 Mbit)" 
		depends on NET_GIGABIT_ETH
   ...

so that the you don't even see the things if you don't select for them?

Untested, but it would seem to be the more natural approach..

		Linus

