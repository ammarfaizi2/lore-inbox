Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264347AbUADVBC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUADVBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:01:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:56800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264347AbUADVBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:01:00 -0500
Date: Sun, 4 Jan 2004 13:00:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Erik Hensema <erik@hensema.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: something is leaking memory
In-Reply-To: <slrnbvgohn.1pb.erik@dexter.hensema.net>
Message-ID: <Pine.LNX.4.58.0401041257290.2162@home.osdl.org>
References: <slrnbvgohn.1pb.erik@dexter.hensema.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Erik Hensema wrote:
> 
> The leak can be most easily seen in my rrdtool graphs of memory
> usage: http://dexter.hensema.net/~erik/stats/mem-mon.gif and
> http://dexter.hensema.net/~erik/stats/mem-year.gif - try to guess
> when I switched to 2.6.0-test11 ;-)
> 
> At Dec 31 I upgraded to 2.6.0-final.
> 
> Output from ps aux, /proc/vmstat and /proc/meminfo, are attached.
> My .config isn't compiled in and I haven't got it at hand
> currently. If anyone is interested I can post it tomorrow.

Can you do /proc/slabinfo too?

Clearly the memory leak isn't in the page cache, so the most likely source 
is network buffers, and most likely in iptables connection tracking or 
similar. If you actually _use_ IPv6, then that is also more likely to have 
leaks just due to less testing.

David & co fixed a number of leaks just before 2.6.0-final, but that 
doesn't mean that they are all gone - rather it means that there 
definitely were still leaks around just a few weeks ago.


		Linus
