Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129064AbQJaITS>; Tue, 31 Oct 2000 03:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129068AbQJaITJ>; Tue, 31 Oct 2000 03:19:09 -0500
Received: from 13dyn156.delft.casema.net ([212.64.76.156]:4366 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129064AbQJaISu>; Tue, 31 Oct 2000 03:18:50 -0500
Message-Id: <200010310818.JAA28471@cave.bitwizard.nl>
Subject: Re: test10-pre7
In-Reply-To: <Pine.LNX.4.10.10010301423070.1085-100000@penguin.transmeta.com>
 from Linus Torvalds at "Oct 30, 2000 02:24:13 pm"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 31 Oct 2000 09:18:18 +0100 (MET)
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Keith Owens <kaos@ocs.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> 
> On Mon, 30 Oct 2000, Jeff Garzik wrote:
> > 
> > Ya know, sorting those lists causes this problem, too...  usb.o is
> > listed first in the various lists, as is usbcore.o.  Is it possible to
> > avoid sorting?  Doing so will fix this, and also any other link order
> > breakage like this that exists, too.
> 
> This is the right fix. We MUST NOT sort those things.
> 
> The only reason for sorting is apparently to remove the "multi-objs"
> things, and replace them with the object files they are composed of.

No. It is NOT the only reason. 

Some driver have a "lowerlevel" driver that needs to be included or
can be loaded as a module whenever the driver is enabled.

This happens to be the case with sx, rio and generic_serial. So both
SX and RIO, when enabled pull in generic_serial, which gets sorted out
by the sort-and-uniqify. 

I used to have horrendously complicated Makefile rules to get this
right, but this was simplified enormously by the "eliminate duplicate 
objects" that is now in the Makefiles. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
