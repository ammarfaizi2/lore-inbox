Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261897AbTCHBFK>; Fri, 7 Mar 2003 20:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbTCHBFK>; Fri, 7 Mar 2003 20:05:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261897AbTCHBFI>; Fri, 7 Mar 2003 20:05:08 -0500
Date: Fri, 7 Mar 2003 17:13:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: Greg KH <greg@kroah.com>, <alan@lxorguk.ukuu.org.uk>, <hch@infradead.org>,
       <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] register_blkdev
In-Reply-To: <20030307170520.5e38c3c9.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303071708260.1796-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Andrew Morton wrote:
> 
> Some time back Linus expressed a preference for a 2^20 major / 2^12 minor split.

Other way around. 12 bits for major, 20 bits for minor.

Minor numbers tend to get used up more quickly, as shown by the current 
state of affairs, and also as trivially shown by things like pty-like 
virtual devices that pretty much scale arbitrarily with memory and users.

I don't much care personally. I think the devil is in the details, and 
making sure we don't have legacy code that just knows about the fact that 
it can index a 256-entry array with the minor number.

Also, I have to say that over time I've become convinced that it's just a
painful mistake to mix up minor and major numbers, so it might well be
sensible for people who actually care about them to always keep them
separate. That would actually imply that 32+32 is the right thing to do
internally after all, and any other limits (whether they be 8+8, 12+20 or
16+16) would be limited by things like over-the-wire or on-the-disk
representations.

			Linus

