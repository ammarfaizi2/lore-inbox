Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130743AbQKRTPe>; Sat, 18 Nov 2000 14:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131032AbQKRTPN>; Sat, 18 Nov 2000 14:15:13 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54281 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130871AbQKRTPE>;
	Sat, 18 Nov 2000 14:15:04 -0500
Message-ID: <3A16CE07.37A9F4B6@mandrakesoft.com>
Date: Sat, 18 Nov 2000 13:44:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ?
In-Reply-To: <200011181750.SAA14559@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Jeff Garzik wrote:
> > Rogier Wolff wrote:
> > >
> > > Alan Cox wrote:
> > > > > What is the difference between a module that exports no symbols and
> > > > > includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
> > > > > EXPORT_NO_SYMBOLS?
> > > > >
> > > > > Alan once upbraided me for assuming they were the same :)
> > > >
> > > > EXPORT_NO_SYMBOLS             -       nothing exported
> > > > MODULE_foo                    -       export specific symbol
> > > >
> > > > none of the above, export all globals but without modvers
> > >                                 ^^^^^^^ and statics!!!!
> > >
> > > I consider that a bug, but...
> >
> > eh?  Can you give an example of this?  This should definitely -not- be
> > the case.
> 
> Compile a kernel, marking "sx" and "riscom8" as modules.
> 
> Install, modprobe sx, and voila, you'll pull in the riscom because
> its "block_til_ready" static was found to satisfy the block_til_ready
> from generic_serial.

That doesn't imply that statics are being exported as symbols. 
generic_serial had no EXPORT_xxx markers, and block_til_ready was
public, so it was expected behavior for g_s to export b_t_r as a symbol.

It is strange that a static which exists in riscom8 causes another
module which exports the same symbol to be pulled in.

> We're working on renaming the one in generic_serial to
> "gs_block_til_ready", but haven't checked yet if the patch got
> applied. So you may have to use a "month-old" kernel for this test.

Can this function be made static?  It looks like many drivers define it
themselves..

In any case, you have a patch coming to you [offline] cleaning up the sx
and riscom8 namespaces...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
