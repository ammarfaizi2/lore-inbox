Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLQAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTLQAmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:42:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:458 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262598AbTLQAmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:42:06 -0500
Date: Tue, 16 Dec 2003 16:41:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jamie Lokier <jamie@shareable.org>, Nick Piggin <piggin@cyberone.com.au>,
       bill davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][RFC] HT scheduler
In-Reply-To: <Pine.LNX.4.44.0312161609050.16848-100000@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0312161638230.1599@home.osdl.org>
References: <Pine.LNX.4.44.0312161609050.16848-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Davide Libenzi wrote:
> > I bet it is. In a big way.
> >
> > The lock does two independent things:
> >  - it tells the core that it can't just crack up the load and store.
> >  - it also tells other memory ops that they can't re-order around it.
>
> You forgot the one where no HT knowledge can be used for optimizations.
>
> - Asserting the CPU's #LOCK pin to take control of the system bus. That in
>   MP system translate into the signaling CPU taking full control of the
>   system bus until the pin is deasserted.

I think this is historical and no longer true.

All modern CPU's do atomic accesses on a cache coherency (and write buffer
ordering) level, and it has nothing to do with the external bus any more.

I suspect locked accesses to memory-mapped IO _may_ still set an external
flag, but I seriously doubt anybody cares. I wouldn't be surprised if the
pin doesn't even exist any more.

			Linus
