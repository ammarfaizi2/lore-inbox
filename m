Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbQJ3Kkw>; Mon, 30 Oct 2000 05:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbQJ3Kkm>; Mon, 30 Oct 2000 05:40:42 -0500
Received: from 24-240-90-35.hsacorp.net ([24.240.90.35]:32764 "EHLO
	bobo.spike.home") by vger.kernel.org with ESMTP id <S129093AbQJ3Kkh>;
	Mon, 30 Oct 2000 05:40:37 -0500
To: David Hinds <dhinds@lahmed.Stanford.EDU>
Cc: Rasmus Andersen <rasmus@jaquet.dk>,
        Arjan van de Ven <arjan@fenrus.demon.nl>, linux-kernel@vger.kernel.org,
        dhinds@zen.stanford.edu, corey@world.std.com
Subject: Re: Compile error in drivers/ide/osb4.c in 240-t10p6
In-Reply-To: <20001029144822.B622@jaquet.dk> <m13psPR-000OXnC@amadeus.home.nl> <20001029231257.J625@jaquet.dk> <20001029183230.A29522@lahmed.stanford.edu>
From: coreythomas@charter.net
Date: 30 Oct 2000 05:40:34 -0500
In-Reply-To: David Hinds's message of "Sun, 29 Oct 2000 18:32:30 -0800"
Message-ID: <87itqapq71.fsf@bobo.spike.home>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ray_cs was imported to the kernel as one of the first test drivers by
Linus.  At the time, he wanted to get rid of the CardServices(function...)
interface and replace it with pcmcia_function calls.  It seems that
the correct fix would be to change pcmcia_request_irq to RequestIRQ
like all the other drivers use.  Or, change all the other drivers.  In
any case I know of no reason for ray_cs to be unique.


David Hinds <dhinds@lahmed.Stanford.EDU> writes:

> On Sun, Oct 29, 2000 at 11:12:57PM +0100, Rasmus Andersen wrote:
> > 
> > Thanks for the pointer. However my test build still barfs in the final
> > link phase because we (in t10p6) morphed drivers/pcmcia/cs.c::pcmcia_
> > request_irq into (the static) cs_request_irq. The rename part
> > broke the two other places in cs.c where pcmcia_request_irq was
> > referenced and the static part made its usage in drivers/net/pcmcia/
> > ray_cs.c a bit awkward.
> 
> It should be un-morphed back to the way it was.  It was an error that
> slipped into a patch I was preparing, because I was hand-editing the
> "diff" output to accommodate some changes between the kernel tree and
> the separate PCMCIA package.
> 
> -- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
