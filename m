Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbQKVNSo>; Wed, 22 Nov 2000 08:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129682AbQKVNSf>; Wed, 22 Nov 2000 08:18:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23819 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129259AbQKVNSX>;
	Wed, 22 Nov 2000 08:18:23 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011221140.eAMBeKB07181@flint.arm.linux.org.uk>
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
To: jamagallon@able.es
Date: Wed, 22 Nov 2000 11:40:20 +0000 (GMT)
Cc: dake@staszic.waw.pl (Bartlomiej Zolnierkiewicz),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001121235529.E925@werewolf.able.es> from "J . A . Magallon" at Nov 21, 2000 11:55:29 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon writes:
> On Tue, 21 Nov 2000 22:25:01 Bartlomiej Zolnierkiewicz wrote:
> > -static int basePort = 0;	/* base port address */
> > -static int regPort = 0;		/* port for register number */
> > -static int dataPort = 0;	/* port for register data */
> > +static int basePort;	/* base port address */
> > +static int regPort;	/* port for register number */
> > +static int dataPort;	/* port for register data */
> 
> That is not too much confidence on the ANSI-ness of the compiler ???

Its got nothing to do with the ANSI-ness of the compiler, but more to do
with the C startup code - does the C startup code initialise BSS to zero
or does it not?

In this particular example, we have full control over it; in the kernel
has our own start up code which does initialise the BSS to zero.

In the dim and distant past (about 7-8 years ago), it was true that we
didn't init the BSS and everything had to be initialised, but this is
long gone.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
