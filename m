Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSHaIHL>; Sat, 31 Aug 2002 04:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSHaIHL>; Sat, 31 Aug 2002 04:07:11 -0400
Received: from AMarseille-201-1-5-96.abo.wanadoo.fr ([217.128.250.96]:3696
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316500AbSHaIHK>; Sat, 31 Aug 2002 04:07:10 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Date: Sat, 31 Aug 2002 10:09:42 +0200
Message-Id: <20020831080942.518@192.168.4.1>
In-Reply-To: <20020831022341.C926@jurassic.park.msu.ru>
References: <20020831022341.C926@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Your logic is so flawed that it's scary.
>
>Maybe.
>
>> Your logic is "I _can_ do it this way, thus everybody else must do it this
>> way". Where the _hell_ is the logic there?
>
>Well, I'm just too lazy and don't want to rewrite that setup-bus stuff
>once again. :-)
>Seriously, I see some implementation issues with "arbitrary number of
>resources" approach. By now I don't know how to deal with them.

Ok, well, you should have said that first ;)

Because what I'm asking (the change to pci_read_bridge_bases()) for
copying all transparent bridge resources will just not affect setup-bus,
so you shouldn't have a problem with it. Currently, setup-bus cannot deal
with my hosts already, copying all 4 resources won't make this worse ;)
If your arch can use setup-bus today, it won't be harmed as it won't
have anything in that 4th resource anyway.

Now, regarding improving setup-bus to deal with such weird cases and stop
relying on fixed resource layout, well... that will be my job or the
job for whoever wants to make it work on PPC (or other arch with similar
need). It's something I have on my long-term todolist, but no time to
dedicate to yet right now.

Ben.


