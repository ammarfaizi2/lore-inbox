Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264489AbRFOTMx>; Fri, 15 Jun 2001 15:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264491AbRFOTMo>; Fri, 15 Jun 2001 15:12:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12559 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264489AbRFOTMe>; Fri, 15 Jun 2001 15:12:34 -0400
Date: Fri, 15 Jun 2001 12:12:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Matthew Wilcox <matthew@wil.cx>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [Final call for testers][PATCH] superblock handling changes
 (2.4.6-pre3)
In-Reply-To: <Pine.GSO.4.21.0106151221190.8909-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.31.0106151209470.7559-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Alexander Viro wrote:
> > > +	list_add (&s->s_list, super_blocks.prev);
> >
> > I'd use list_add_tail(&s->s_list, super_blocks);
>
> Umm... Why?

I have to agree with Matthew - "list_add_tail()" more clearly says what
the code is trying to do.

Aside from that, I will bet you a dollar that you'll see that using
"list_add_tail()" generating better code. Why? Simply because that way one
of the pointers is a constant, instead of being through indirection. Try
it and see.

And if order is arbitrary, please just use

	list_add(&s->s_list, super_blocks);

because otherwise why use the ".prev" at all?

		Linus

