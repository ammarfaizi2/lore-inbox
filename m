Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267419AbSLEUwQ>; Thu, 5 Dec 2002 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267420AbSLEUwQ>; Thu, 5 Dec 2002 15:52:16 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:60935 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267419AbSLEUwP>;
	Thu, 5 Dec 2002 15:52:15 -0500
Date: Thu, 5 Dec 2002 21:58:17 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
Message-ID: <20021205205817.GB21070@alpha.home.local>
References: <20021205190054.GE23877@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021205190054.GE23877@louise.pinerecords.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 08:00:54PM +0100, Tomas Szepe wrote:
 
> Suppose I have two IP addresses from the same subnet on the same
> interface, and this interface also happens to be what my default
> gateway is on, like so:
> 
> /sbin/ifconfig eth1   213.168.178.209 netmask 255.255.255.192 \
> 					broadcast 213.168.178.255
> /sbin/ifconfig eth1:0 213.168.178.210 netmask 255.255.255.192 \
> 					broadcast 213.168.178.255
> /sbin/route add default gw 213.168.178.193

Honnestly, the simplest way to deal with aliases and source addresses is to
forget ifconfig/route and replace them with iproute2 (ftp.inr.ac.ru), which
lets you specify the source address among many other settings. Really a
wonderful and cleanly coded tool.

In your case, you'd call it this way :

  ip addr add 213.168.178.209/26 dev eth0
  ip addr add 213.168.178.210/26 dev eth0
  ip route add default via 213.168.178.193

When several addresses can resolve for the source, the first one is used by
default, so in the above case, it will be .209. But it's easy to specify the
other one :

  ip route add default via 213.168.178.193 src 213.168.178.210

In fact, you can even set the source of another interface, which is very useful
on point-to-point connections above private networks.

I really don't understand why modern distros don't use it by default, and still
prefer prehistoric ifconfig and route. These ones are extremely limited
regarding what the kernel can do.

Cheers,
Willy

