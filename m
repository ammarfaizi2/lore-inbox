Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154815AbPIBBcO>; Wed, 1 Sep 1999 21:32:14 -0400
Received: by vger.rutgers.edu id <S154849AbPIBB3L>; Wed, 1 Sep 1999 21:29:11 -0400
Received: from mb04.swip.net ([193.12.122.208]:51349 "EHLO mb04.swip.net") by vger.rutgers.edu with ESMTP id <S154702AbPIBB2y>; Wed, 1 Sep 1999 21:28:54 -0400
From: David Olofson <audiality@swipnet.se>
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Universal Driver Interface spec available
Date: Thu, 2 Sep 1999 03:00:53 +0200
X-Mailer: KMail [version 1.0.20]
Content-Type: text/plain
Cc: linux-kernel@vger.rutgers.edu
References: <37CD9F8F.F3881475@pobox.com>
MIME-Version: 1.0
Message-Id: <99090203300101.00439@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, 01 Sep 1999, Jeff Garzik wrote:
(...)
> On a related subject, I think Linux could use a much more coherent --
> and documented -- device driver interface.

Yes. And I'll need to sort some of that out for the Driver Programming
Interface (DPI) anyway. (See Audiality site; Downloads.) I basically need to
re-implement the calls as versions that can be called from RTLinux pthreads. It
would also be nice if everything could be kept compatible on the source level.
That's why I didn't like the original rtl_posixio module. (Have yet to release
my real version - with the *real* structs instead of my binary level
compatibles in 0.1.0...) I also have a problem with code like

	current->state = TASK_INTERRUPTIBLE;

and the like. Not too nice to #define into something else, not related to
current or task_struct...

	set_current_state(TASK_INTERRUPTIBLE);

Is a lot nicer. However, implementing things like that for no other reason but
to hide the underlying details (which, AFAIK, wasn't the case with this
example) is not as nice as it may sound in real life... Abstraction can be
dangerous. I'll have to do some in the DPI, but I'm afraid there's a risk
that the resulting API won't fit too well as a new driver API for standard
kernels.

OTOH, if RTLinux is ever going into the standard kernels, I think being able to
compile some drivers for it is essential. It's kind of pointless to most users
otherwise...


//David


 ·A·U·D·I·A·L·I·T·Y·   P r o f e s s i o n a l   L i n u x   A u d i o
-  - ------------------------------------------------------------- -  -
    ·Rock Solid                                      David Olofson:
    ·Low Latency    www.angelfire.com/or/audiality   ·Audio Hacker
    ·Plug-Ins            audiality@swipnet.se        ·Linux Advocate
    ·Open Source                                     ·Singer/Composer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
