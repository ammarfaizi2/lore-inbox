Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUHaR1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUHaR1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUHaRZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:25:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:54701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264954AbUHaRPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:15:35 -0400
Date: Tue, 31 Aug 2004 10:15:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Tom Vier <tmv@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1093949876.32682.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408311006340.2295@ppc970.osdl.org>
References: <20040825163225.4441cfdd.akpm@osdl.org>  <20040825233739.GP10907@legion.cup.hp.com>
  <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> 
 <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> 
 <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> 
 <20040826163234.GA9047@delft.aura.cs.cmu.edu>  <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
  <20040831033950.GA32404@zero>  <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
 <1093949876.32682.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Alan Cox wrote:
> 
> Several do TCP in user space. The only thing you need in kernel for
> TCP/IP is enough decode to decide who gets the packet.

Only thing? I don't think so. 

You also want to make sure that regular users cannot send "impossible" 
packets. Think about the old "ping of death" kind of thing, where a normal 
mis-behaving (and I'm not saying intentionally so: it might be a small bug 
that just overwrites some data) program should _not_ be able to cause 
problems on the network.

Admins absolutely _hate_ that. They will ban an OS if it sends out packets
that cause troublem. You should remember that - we used to do strange
things on the net (long long time ago), and we brought down servers by
mistake, and nobody ever considered it a server bug: it was a Linux bug
that it wouldn't do the right thing.

Things like not sending FIN-packets when a program suddenly goes away is 
NOT acceptable behaviour! Neither is it acceptable behaviour to allow user 
programs to make up their own packets.

> Even some non microkernel embedded OS's do this in order to keep kernel
> size down.

..and I'm not disagreeing that it doesn't happen. I explicitly mentioned 
PalmOS, I bet it happens in other cases too. But I'd strongly argue that 
it's a bug, not a feature.

It's a bug that people tend to accept in a "single-client" environment. 

NOTE! This is totally ignoring the fact that you can't be called "UNIX" 
any more. You _need_ to have sequence numbers etc be shared between 
multiple programs that all write to the stream. Again, that _does_ mean 
that you have another protection domain (aka "kernel" or "TCP deamon") 
that keeps track of the sequence number. 

		Linus
