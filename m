Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268483AbTBOBCR>; Fri, 14 Feb 2003 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268490AbTBOBCQ>; Fri, 14 Feb 2003 20:02:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37650 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268483AbTBOBCQ>; Fri, 14 Feb 2003 20:02:16 -0500
Date: Fri, 14 Feb 2003 17:08:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <20030215000628.GB1073@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0302141704280.1296-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Feb 2003, Matti Aarnio wrote:
> 
> Somehow all this idea has a feeling of long established
> Linux kernel facility called:  netlink

Several people have said that, and it's completely NOT TRUE.

The thing about sigfd() has _nothing_ to do with sending packets, and 
everything to do with the fact that you _associate_ signals with the thing 
that you get the packets from.

Sure, the code could associate signals with a netlink fd instead. But 
netlink is not actually a very good abstraction in my opinion - it has 
another layer of code (the network layer) between it and the user, which 
dos not add any value.

> Do we need new syscall(s) ?  Could it all be done with netlink ?

We'd need the same new system call - the one to associate signals of this 
process with the netlink thing.

(Yeah, the "system call" could be an ioctl entry, but quite frankly, 
that's much WORSE than adding a system call. It's just system calls 
without type checking).

			Linus

