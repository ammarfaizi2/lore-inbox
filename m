Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQKADbM>; Tue, 31 Oct 2000 22:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbQKADax>; Tue, 31 Oct 2000 22:30:53 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:22029 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129063AbQKADao>; Tue, 31 Oct 2000 22:30:44 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14847.36411.795012.99317@wire.cadcamlab.org>
Date: Tue, 31 Oct 2000 21:30:03 -0600 (CST)
To: jalvo@mbay.net (John Alvord)
Cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <11462.972947019@ocs3.ocs-net>
	<Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com>
	<20001031055959.A1041@wire.cadcamlab.org>
	<3a013178.6803918@mail.mbay.net>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > There are two ways to handle this:
> >
> >   obj-$(CONFIG_WD80x3) += wd.o 8390.o
> >   obj-$(CONFIG_EL2) += 3c503.o 8390.o
> >   obj-$(CONFIG_NE2000) += ne.o 8390.o
> >   obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
> >   obj-$(CONFIG_HPLAN) += hp.o 8390.o

[John Alvord <jalvo@mbay.net>]
> You can avoid duplicates with
>   obj-$(CONFIG_WD80x3) += wd.o
>   ifneq (,$(findstring 8390.o,obj-$(CONFIG_WD80x3))
>      obj-$(CONFIG_WD80x3) += 8390.o
>   endif
>  
> Which is wordy but accomplishes the objective of avoiding duplicates.

I said "there are two ways to handle this".  You snipped the second,
which was:

> > ...Or do horrible games with 'if' statements and temporary
> > variables with names like $(NEED_8390) to ensure that it gets
> > included once if needed and not if not -- thereby pretty much
> > defeating the readability of the new-style makefiles.

I would consider your approach a variant of the "horrible games with if
statements and temporary variables". (:

Here's an exercise to the reader: reformat drivers/net/Makefile using
John Alford's approach, diff the two, and take a look.  Then come back
and tell me LINK_FIRST -- 0-2 lines in the Makefile depending on your
ordering requirements, plus about five lines in Rules.make (*yes*, it
really is that simple) -- is really uglier.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
