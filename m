Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262713AbTCJEgL>; Sun, 9 Mar 2003 23:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262716AbTCJEgK>; Sun, 9 Mar 2003 23:36:10 -0500
Received: from waste.org ([209.173.204.2]:29899 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262713AbTCJEgK>;
	Sun, 9 Mar 2003 23:36:10 -0500
Date: Sun, 9 Mar 2003 22:46:17 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Greg KH <greg@kroah.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030310044617.GF910@waste.org>
References: <Pine.LNX.4.44.0303071708260.1796-100000@home.transmeta.com> <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047136177.25932.25.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 03:09:37PM +0000, Alan Cox wrote:
> On Sat, 2003-03-08 at 01:13, Linus Torvalds wrote:
> > On Fri, 7 Mar 2003, Andrew Morton wrote:
> > > 
> > > Some time back Linus expressed a preference for a 2^20 major / 2^12 minor split.
> > 
> > Other way around. 12 bits for major, 20 bits for minor.
> > 
> > Minor numbers tend to get used up more quickly, as shown by the current 
> > state of affairs, and also as trivially shown by things like pty-like 
> > virtual devices that pretty much scale arbitrarily with memory and users.
> 
> 20:12 is easier for the current behaviour. 12:20 with the ability to hand out
> sections of space has great potential for lumping things like "disks", 
> "serial ports" and so on together in more logical ways. 12:20 also makes the
> compatibility logic easier since all of the legacy space falls in "major 0"
> which becomes the remangler.
> 
> Is there any reason for not using CIDR like schemes as Al Viro proposed a long
> time back (I think it was Al anyway). That also sorts out the auditing problem

I think it was actually me, arguing with Viro. I was building a device
number registration layer on top of the new resource tree structure at
the time (now 3 years ago!). And in retrospect, I think 32:32
internally with an 8:8 legacy mangler is probably the sanest way to
go.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
