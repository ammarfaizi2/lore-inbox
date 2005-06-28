Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVF1NuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVF1NuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVF1Nrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:47:39 -0400
Received: from alog0218.analogic.com ([208.224.220.233]:57986 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261685AbVF1Nqi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:46:38 -0400
Date: Tue, 28 Jun 2005 09:45:53 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: cigarette Chan <benbenshi@gmail.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: route trouble with kernel
In-Reply-To: <dc849d8505062805573a73ec99@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0506280942330.12415@chaos.analogic.com>
References: <dc849d8505062805573a73ec99@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It could be argued that if `iptables` retains its
parameters after its only interface has been shut
down it's a bug.

The fact that no routes remain after a network
interface has been shut down is both logical
and in conformance with de facto Unix standards.
This is partially as a result of route's manipulating
flags (the UP flag would be wrong if the interface
was down).

I can't imagine that you have so many routes
that it takes a significant amount of time to
reset them using a script. If so, you probably
have a configuration error where you are
not properly using netmasks. Certainly, you
shouldn't have to establish a host-route for
every host on your network. You only need a
network route (out the interface) and a
default route that goes to some router to get
out of your LAN. Even if you __are__ a router,
the network setup remains about the same,
only the user-mode software changes, which
may dynamically alter the routing tables.

On Tue, 28 Jun 2005, cigarette Chan wrote:

> i add a route to the kernel
> eg: # route add -net XXX.XXX.XXX.XXX/24 gw XXX.XXX.XXX.XXX dev eth1
>
> but after i restart eth1
>
> #ifdown eth1
> #ifup eth1
>
> the route disappear,this make me a lot of troubles.i have several
> interfaces,and i have to
> re-add all of these routes...
>
> Is there any way or patches to make route work like iptables,after i
> restart the interface,
> rules  are still there.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
