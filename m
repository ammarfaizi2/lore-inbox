Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbQKRSU2>; Sat, 18 Nov 2000 13:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130294AbQKRSUS>; Sat, 18 Nov 2000 13:20:18 -0500
Received: from 13dyn189.delft.casema.net ([212.64.76.189]:2058 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130211AbQKRSUH>; Sat, 18 Nov 2000 13:20:07 -0500
Message-Id: <200011181750.SAA14559@cave.bitwizard.nl>
Subject: Re: EXPORT_NO_SYMBOLS vs. (null) ?
In-Reply-To: <3A16C01C.8421220A@mandrakesoft.com> from Jeff Garzik at "Nov 18,
 2000 12:45:00 pm"
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Sat, 18 Nov 2000 18:50:00 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Rogier Wolff wrote:
> > 
> > Alan Cox wrote:
> > > > What is the difference between a module that exports no symbols and
> > > > includes EXPORT_NO_SYMBOLS reference, and such a module that lacks
> > > > EXPORT_NO_SYMBOLS?
> > > >
> > > > Alan once upbraided me for assuming they were the same :)
> > >
> > > EXPORT_NO_SYMBOLS             -       nothing exported
> > > MODULE_foo                    -       export specific symbol
> > >
> > > none of the above, export all globals but without modvers
> >                                 ^^^^^^^ and statics!!!!
> > 
> > I consider that a bug, but...
> 
> eh?  Can you give an example of this?  This should definitely -not- be
> the case.

Compile a kernel, marking "sx" and "riscom8" as modules. 

Install, modprobe sx, and voila, you'll pull in the riscom because
its "block_til_ready" static was found to satisfy the block_til_ready
from generic_serial. 

We're working on renaming the one in generic_serial to
"gs_block_til_ready", but haven't checked yet if the patch got
applied. So you may have to use a "month-old" kernel for this test.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
