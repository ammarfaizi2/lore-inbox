Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJGSDp>; Mon, 7 Oct 2002 14:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262543AbSJGSDp>; Mon, 7 Oct 2002 14:03:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34063 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261277AbSJGSDp>; Mon, 7 Oct 2002 14:03:45 -0400
Date: Mon, 7 Oct 2002 11:08:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <efault@gmx.de>
cc: Matthew Wilcox <willy@debian.org>, Christoph Hellwig <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: bcopy()
In-Reply-To: <5.1.0.14.2.20021007195409.00b54a98@pop.gmx.net>
Message-ID: <Pine.LNX.4.33.0210071105350.21165-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Mike Galbraith wrote:
> >
> >XFS seems to be a big user of bcopy, though..
> 
> Does it matter from the cleanliness side?  (1->N users)

It does.

I will not apply a patch that removes bcopy() in the name of 
"cleanliness", if it then results in a number of modules just adding their 
own

	#define bcopy(a,b,c) memcpy(b,a,c)

because then the whole cleanup would be pointless - it would just make 
some modules even uglier than they were before.

So I'd much rather see the XFS etc code moved away from bcopy() first,
because that's the _real_ cleanup. The library code isn't all that ugly in
comparison.

		Linus

