Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUDQSPt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 14:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDQSPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 14:15:49 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:30336
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S264002AbUDQSPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 14:15:47 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082225747.2580.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 11:15:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 09:44, Matthias Urlichs wrote:
> Hi, Trond Myklebust wrote:
> 
> > As for blanket statements like the above: I have seen no evidence yet
> > that they are any more warranted in 2.6.x than they were in 2.4.x.
> 
> Oh, I saw the problem too: a slow client couldn't do full-size reads from
> a fast server because the buffer on the client's network card was just 8k.

Right, and this has always been a problem. I had the same issues when
doing 8k reads on one of my 75MHz Pentiums some 10 years ago. The thing
would more or less lock up and just pump out a constant stream of "time
exceeded" ICMP messages.

The NFS/RPC layer knows nothing about the existence of network cards or
their buffer sizes. Only about sockets and how to read from/write to
them.
This sort of issue is precisely why I'd prefer to see people use TCP by
default. UDP with it's dependency on fragmentation works fine on fast
setups with homogeneous lossless networks. It sucks as soon as you break
one of those conditions.

Cheers,
  Trond
