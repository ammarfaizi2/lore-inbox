Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264491AbRFOTTO>; Fri, 15 Jun 2001 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264493AbRFOTTE>; Fri, 15 Jun 2001 15:19:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63452 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264491AbRFOTSu>;
	Fri, 15 Jun 2001 15:18:50 -0400
Date: Fri, 15 Jun 2001 15:18:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Final call for testers][PATCH] superblock handling changes
 (2.4.6-pre3)
In-Reply-To: <Pine.LNX.4.31.0106151209470.7559-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0106151513480.9091-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Linus Torvalds wrote:

> I have to agree with Matthew - "list_add_tail()" more clearly says what
> the code is trying to do.
> 
> Aside from that, I will bet you a dollar that you'll see that using
> "list_add_tail()" generating better code. Why? Simply because that way one
> of the pointers is a constant, instead of being through indirection. Try
> it and see.
> 
> And if order is arbitrary, please just use
> 
> 	list_add(&s->s_list, super_blocks);
> 
> because otherwise why use the ".prev" at all?

OK with me - I've completely missed his point when I was replying.
For now I'd go for list_add_tail() (if you check the patch you'll
see that this line was simply moved from get_empty_super() - verbatim).

Order may matter performance-wise and now we can control it, but I'd
leave experiments in that direction until 2.5. Anything that relied on
any specific order is broken, but let's not add that into the mix for
the time being, OK?

