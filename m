Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbUAJAiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUAJAiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:38:50 -0500
Received: from mail.gmx.de ([213.165.64.20]:42661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264534AbUAJAit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:38:49 -0500
X-Authenticated: #20450766
Date: Sat, 10 Jan 2004 01:38:00 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040109180054.GV1882@matchmail.com>
Message-ID: <Pine.LNX.4.44.0401100024210.676-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jan 2004, Mike Fedyk wrote:

> On Fri, Jan 09, 2004 at 11:08:29AM +0100, Guennadi Liakhovetski wrote:
> > On Wed, 7 Jan 2004, Mike Fedyk wrote:
> >
> > > Just post a few samples of the lines that differ.  Any files should be sent
> > > off-list.
> >
> > Ok, This is the problem:
> >
> > 10:38:30.867306 0:40:f4:23:ac:91 0:50:bf:a4:59:71 ip 590: tuxscreen.grange > poirot.grange: icmp: ip reassembly time exceeded [tos 0xc0]
>
> Find out how many packets are being dropped on your two hosts with 2.4 and
> 2.6.

So, I've run 2 tcpdumps - on server and on client. Woooo... Looks bad.

With 2.4 (_on the server_) the client reads about 8K at a time, which is
sent in 5 fragments 1500 (MTU) bytes each. And that works. Also
interesting, that fragments are sent in the reverse order.

With 2.6 (on the server, same client) the client reads about 16K at a
time, split into 11 fragments, and then packets number 9 and 10 get
lost... This all with a StrongARM client and a PCMCIA network-card. With a
PXA-client (400MHz compared to 200MHz SA) and an on-board eth smc91x, it
gets the first 5 fragments, and then misses every other fragment. Again -
in both cases I was copying files to RAM. Yes, 2.6 sends fragments in
direct order.

Thanks
Guennadi
---
Guennadi Liakhovetski



