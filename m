Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSG2IpV>; Mon, 29 Jul 2002 04:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSG2IpV>; Mon, 29 Jul 2002 04:45:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:9232 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S313537AbSG2IpV>;
	Mon, 29 Jul 2002 04:45:21 -0400
Date: Mon, 29 Jul 2002 10:48:33 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Karthik Arumugham <kernel@karthik.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New connections stall with 20k+ open sockets
Message-ID: <20020729084833.GA6841@alpha.home.local>
References: <Pine.LNX.4.44.0207281510550.9012-100000@neural.psychosis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207281510550.9012-100000@neural.psychosis.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 03:37:47PM -0400, Karthik Arumugham wrote:
 
> I've been having an issue where when the server goes past 20k connections or
> so, it'll start ignoring syn packets on the most heavily used ports. I've
> experienced this under 2.4.18 and older 2.4 kernels, and I'm currently
> running 2.5.29. Distribution is Debian unstable (not that that should matter
> here). I'm using a Netgear GA620 gig-e card, x86 architecture.

I've had such a behaviour with an HTTP reverse proxy I wrote, until I
realized that when you have thousands of connections, the select() call
slows down a bit, and the accept() was not called often enough to catch
all the new connections. I simply solved the problem by calling as many
accept() as possible each time the listen socket wakes up. I'm pretty
sure you are in such a situation.

Cheers,
Willy

