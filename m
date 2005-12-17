Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVLQBBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVLQBBA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVLQBA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 20:00:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964912AbVLQBA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 20:00:59 -0500
Date: Fri, 16 Dec 2005 17:00:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
cc: Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
In-Reply-To: <20051217002929.GA7151@tsunami.ccur.com>
Message-ID: <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512150945410.3292@g5.osdl.org>
 <20051215112115.7c4bfbea.akpm@osdl.org> <1134678532.13138.44.camel@localhost.localdomain>
 <Pine.LNX.4.62.0512152130390.16426@pademelon.sonytel.be>
 <1134769269.2806.17.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org>
 <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org>
 <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org>
 <20051217002929.GA7151@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, Joe Korty wrote:
> 
> The Mars Pathfinder incident is sufficient proof that some solution to
> the priority inversion problem is required in real systems.

Ehh. 

The Mars Pathfinder is just about the worst case "real system", and if I 
recall correctly, the reason it was able to continue was _not_ because it 
handled priority inversion, but because it reset itself every 24 hours or 
something like that, and had debugging facilities..

The _real_ lesson you should take away from it is not that priority 
inheritance is a good solution to priority inversion, but that having a 
failsafe switch when everthing goes wrong is critical. You don't know 
_what_ bug you'll encounter.

The bug itself could have been solved without priority inheritance, 
although I think in this case enabling that in VxWorks was the particular 
solution to the problem as being the least invasive.

Personally, I don't care what user space does. If some app wants to use 
priority inheritance to solve its bugs, that's fine. But it's like 
recursive locks: it's generally a _bandaid_ for bad locking. I definitely 
don't want the kernel depending on either.

So put a watchdog on your critical systems, and make sure you can debug 
them. Especially if they're on Mars.

			Linus
