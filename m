Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbTCHNxG>; Sat, 8 Mar 2003 08:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbTCHNxG>; Sat, 8 Mar 2003 08:53:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50866
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262015AbTCHNxF>; Sat, 8 Mar 2003 08:53:05 -0500
Subject: Re: [PATCH] register_blkdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>,
       hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303071708260.1796-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303071708260.1796-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 15:09:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-08 at 01:13, Linus Torvalds wrote:
> On Fri, 7 Mar 2003, Andrew Morton wrote:
> > 
> > Some time back Linus expressed a preference for a 2^20 major / 2^12 minor split.
> 
> Other way around. 12 bits for major, 20 bits for minor.
> 
> Minor numbers tend to get used up more quickly, as shown by the current 
> state of affairs, and also as trivially shown by things like pty-like 
> virtual devices that pretty much scale arbitrarily with memory and users.

20:12 is easier for the current behaviour. 12:20 with the ability to hand out
sections of space has great potential for lumping things like "disks", 
"serial ports" and so on together in more logical ways. 12:20 also makes the
compatibility logic easier since all of the legacy space falls in "major 0"
which becomes the remangler.

Is there any reason for not using CIDR like schemes as Al Viro proposed a long
time back (I think it was Al anyway). That also sorts out the auditing problem

