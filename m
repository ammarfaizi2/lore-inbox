Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129971AbQJaBCx>; Mon, 30 Oct 2000 20:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129993AbQJaBCn>; Mon, 30 Oct 2000 20:02:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:49927 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129971AbQJaBCe>;
	Mon, 30 Oct 2000 20:02:34 -0500
Date: Tue, 31 Oct 2000 02:01:54 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Keith Owens <kaos@ocs.com.au>
Subject: Re: test10-pre7
Message-ID: <20001031020154.A20703@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
In-Reply-To: <20001031005740.A17150@caldera.de> <Pine.LNX.4.10.10010301643300.1789-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10010301643300.1789-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Oct 30, 2000 at 04:47:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 04:47:15PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 31 Oct 2000, Christoph Hellwig wrote:
> >
> > Old-style Makefiles are playing dirty tricks with defining
> > L_TARGET and then using O_TARGET for linking some onjects into
> > an intermediate object.
> 
> Actually, I think I have an even simpler solution, which is to change the
> newstyle rule to something very simple:
> 
> 	# Translate to Rules.make lists.
> 
> 	O_OBJS          := $(obj-y)
> 	M_OBJS          := $(obj-m)

This will destroy one nice feature of list-style makefiles:
when you have and object both in obj-y and obj-m it will be removed
from obj-m with the old boiler-plates, not with your proposal.

> 	MIX_OBJS        := $(export-objs)

The MIX_OBJS change is wrong.  It may not hurt the resulting
kernel image but you will build all export-objs, not only the
ones you actually have selected.  But we might get around this
with some $(filter ...) magic.


> 	# The global Rules.make.
> 
> 	include $(TOPDIR)/Rules.make
> 
> And you're done..
> 
> Does anybody see anything wrong with this approach?
> 
> It's kin dof cheesy, but I think it should work. The magic is that by
> avoiding OX_OBJS and MX_OBJS, we avoid all the sorting issues. We
> basically lie, and say that we don't have anything like that.
> 
> Then, MIX_OBJS picks up the stragglers, and makes sure that we consider
> the proper files to be SYMTAB_OBJS.
> 
> This works for me for USB (ie just remove all the stuff with "int-y" and
> multi's etc). Does it work for anybody else?

The idea looks great, but it looks like the implementation needs a little
bit work.

Keith do you want to hack on this now - or should I prepare a patch tomorrow?

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
