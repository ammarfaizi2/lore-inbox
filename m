Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbQJ3Xsq>; Mon, 30 Oct 2000 18:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129658AbQJ3Xsf>; Mon, 30 Oct 2000 18:48:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:1289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129041AbQJ3XsZ>; Mon, 30 Oct 2000 18:48:25 -0500
Date: Mon, 30 Oct 2000 15:47:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: <12109.972949137@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10010301541000.3595-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Keith Owens wrote:
> 
> >It is NEVER acceptable to change the order of object files.
> 
> It is NEVER acceptable to change the order of object files, but only
> for those files where the developer has explicitly said what the order
> must be.  In the case of USB, the developers say usb.o must be first,
> the rest can be in any order.

How much do you want to bet that this can and will change if people were
made aware of how easy ordering can be?

I think we have too many "subtle" rules already.

We should have some REALLY simple and to-the-point rules. Namely:

 - object files get linked in the order specified

No ifs, buts, "except when the user doesn't care", or anything like that.
No extra new logic with fancy new names for FIRST and LAST objects. No,
that's the wrong thing.

> >	ALL_O = $(O_OBJS)
> >
> >and the meaning of $OX_OBJS is the _subset_ of object file that have
> >SYMTAB objects.
> 
> We do not have an automatic way of detecting SYMTAB objects, OX_OBJS is
> the only way that 2.4 kbuild can tell if an source has SYMTAB or not.

I _know_.

I'm saying that we should not care. OX_OBJS still exists, but it has
nothing to do with _linking_. It has everything to do with the build
rules.

OX_OBJS is just a list of files that have exports.

It won't affect linking. It will only affect the list of SYMTAB_OBJS,
_nothing_ more.

For example, the old-style kernel/Makefile, you'd have O_OBJS containing
signal.o and sys.o. As would OX_OBJS. They'd be in both places, because
O_OBJS would tell that yes, we want to link it into the kernel, and
OX_OBJS would tell that yes, we need to generate symtab informaiton for
the files in question.

The two things are entirely orthogonal, as far as I can see. Except
historically we've mixed them up (OX_OBJS + O_OBJS is the link-list,
O_OBJS is the symtab information). And this mixup is what the problems
come from.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
