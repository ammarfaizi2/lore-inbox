Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317466AbSFDKdC>; Tue, 4 Jun 2002 06:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317475AbSFDKdB>; Tue, 4 Jun 2002 06:33:01 -0400
Received: from pandora.cantech.net.au ([203.26.6.29]:54022 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S317466AbSFDKdA>; Tue, 4 Jun 2002 06:33:00 -0400
Date: Tue, 4 Jun 2002 18:32:45 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: Re: [PATCH] 2.4.19-pre10 s/Efoo/-Efoo/ drivers/char/rio/*.c
In-Reply-To: <20020604110032.A28843@jaquet.dk>
Message-ID: <Pine.LNX.4.44.0206041821520.32156-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Rasmus Andersen wrote:

> On Tue, Jun 04, 2002 at 04:48:58PM +0800, Anthony J. Breeds-Taurima wrote:
> > Hello All,
> > 	This is another cleanup patch changing positive return values into
> > negative's.
> > 
> > 
> > Yours Tony
> > 
> > Jan 22-26 2003      Linux.Conf.AU       http://conf.linux.org.au/
> >          The Australian Linux Technical Conference!
> > 
> > --------------------------------------------------------------------------------
> > diff -X dontdiff -urN linux-2.4.19-pre10.clean/drivers/char/rio/rio_linux.c linux-2.4.19-pre10/drivers/char/rio/rio_linux.c
> > --- linux-2.4.19-pre10.clean/drivers/char/rio/rio_linux.c	Tue Apr 30 13:22:07 2002
> > +++ linux-2.4.19-pre10/drivers/char/rio/rio_linux.c	Tue Jun  4 16:27:36 2002
> > @@ -702,7 +702,7 @@
> >    func_enter();
> >  
> >    /* The "dev" argument isn't used. */
> > -  rc = -riocontrol (p, 0, cmd, (void *)arg, suser ());
> > +  rc = riocontrol (p, 0, cmd, (void *)arg, suser ());
> 
> I'm sorry but since this code indeed changes the positive return
> codes into negatives, what is the purpose of your patch? Have you
> talked to the maintainer (R.E.Wolff)?

Yes I have spoken to Rogier about this before I posted it to LKML.
riocontol calls several functions like RIONewTable.  Which in the past
had returned ENXIO etc etc.  These positive returns where then had thier
sign switched in the riocontrol line above.  This patch was supposed to do
2 things 1) make the rio drivers conform to the more general "negative on
error" convention for most functions and 2) bring the code more inline with 
the version in 2.5

Howver looking closer, which I should have done BEFORE I posetd here
shows that this patch doesn't fix all places so the patch above is bad indeed.

I'll spend some time reauditing the code and fixing trhe places I missed and 
then retrans.


Yours Tony

Jan 22-26 2003      Linux.Conf.AU       http://conf.linux.org.au/
         The Australian Linux Technical Conference!

