Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272056AbRHVReo>; Wed, 22 Aug 2001 13:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272055AbRHVRel>; Wed, 22 Aug 2001 13:34:41 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:9732 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272054AbRHVReY>; Wed, 22 Aug 2001 13:34:24 -0400
Message-ID: <3B83ED5B.2A717A65@t-online.de>
Date: Wed, 22 Aug 2001 19:35:23 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        alan@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
In-Reply-To: <slrn9o270m.rg.kraxel@bytesex.org> from "Gerd Knorr" at Aug 20, 1 06:45:06 pm <200108202252.CAA00742@mops.inr.ac.ru> <200108212037.f7LKb15N009912@bytesex.masq.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> 
> In lists.linux.kernel, you wrote:
> >  Hello!
> >
> > > Same problem here.  I've spend some time today to figure what is going
> > > on.  Workaround:
> > > -           min = PCIBIOS_MIN_IO;
> > > +           min = 0x4000 /* PCIBIOS_MIN_IO */;
> >
> >  I do not know how to thank you... You saved my life. :-)
> >  How did you guess this?
> 
> Long trial-and-error session.  Deactivate code and see if it still does
> crash to narrow down the code lines which trigger the lockup.  Once I've
> figured that enabling the I/O-Windows triggers the lookup the guess was
> easy ...
> 
> > > Looks like a ressource conflict to me.  The kernel gives I/O ranges to
> > > the cardbus socket which it thinks are free but which are *not* free for
> > > some reason (and probably used for APM stuff).  BIOS bug?  PCI quirks
> > > time?

Longstanding Linux Bug: "ignore a _seven_ year old standard called PNPBIOS".

> >
> >  The same hardware is here, Mitac M722. :-) BTW what bios is installed
> >  on your one?
> 
> "SYSTEM BIOS R1.02"
> 
> >  Anyway, Windows with the _same_ bios manages to guess and to reserve
> >  a few of ports tagged as some obscure "motherboard resources":
> >  230-233, 398-399, 4d0-4d1, 1000-103f(!), 1400-140f(!) and 3810-381f.
> >  yenta_socket eats ones marked with !. At least 1400 is really critical,
> >  it is interface to SM mode.
> 
> 0x1000 is critical too.  Activating the first I/O window only is enough
> to hang the notebook on any APM activity.

PNPBIOS _easily_ resolves this problem !

Try -ac Kernels with integrated PNPBIOS and "lspnp -v",
then you will see your "motherboard resources". No magic.

Note: Linux currently does _not_ yet reserve these resources automatically
(although I think the standalone pcmcia package has such an option).

By confirming (and posting your lspnp results) you could encourage
some developers to rectify this situation :-)

Alan, 2.4 would largely benefit from PNPBIOS, do you plan
to submit this to LT (probably with the proposed life saver fix) ?


-
Gunther
