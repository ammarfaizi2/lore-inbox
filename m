Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271703AbRHUOlH>; Tue, 21 Aug 2001 10:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271704AbRHUOk5>; Tue, 21 Aug 2001 10:40:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20382 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271703AbRHUOkt>;
	Tue, 21 Aug 2001 10:40:49 -0400
Date: Tue, 21 Aug 2001 07:40:56 -0700 (PDT)
Message-Id: <20010821.074056.97555444.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
Subject: Re: Qlogic/FC firmware
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15ZCS1-0007xV-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15ZCS1-0007xV-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 21 Aug 2001 15:24:17 +0100 (BST)

   > When the Qlogic,FC sees a master abort, the firmware is essentially
   > cleared to zero.
   
   None of the cards I have do this. Is this some kind of sparc specific
   firmware problem ?

Without x86 BIOS this is the situation you will get.

Unless you tell the firmware to probe all scsi devices at the OBP
command line, there is no firmware loaded into the FC card.  There
is no reason for firmware to get loaded onto the card.

So if I boot kernels from the Symbios scsi device and use a disk
on my qlogic,fc as root, I am fucked after my next power cycle.
This is exactly my setup on one of my systems.
   
What other non-x86 systems trying to use QLogic/FC cards as root?
Such as PPC.  There is nothing wrong or stupid about this, and such
systems have been broken by removing the firmware.

   Why. What exactly is your argument ? Lets waste 128K of kernel space to keep
   Dave happy. If the lack of proper boot time init on the sparc64 platform is
   causing more problems then copy the firmware image out of the BIOS into the
   card if sparc64 is defined.
   
That would require that I know where in the forth image Sun
sticks the firmware, I have no way to figure this out except
by toiling over disassembler dumps of the cards firmware.

I have no guarentees even that this is where it is (in the PCI
ROM of the qlogic,fc card) they could have just as well have stuffed
it into some arbitrary place in the main system forth ROM.

   And an initrd is the right answer. You free up the 128K of wasted space
   using it.
   
I'd rather have 128k of wasted space than an unbootable system.

All of Matt Jacob's drivers include all the firmware.  And this
makes a lot of sense for another reason, QA.  If you know what
firmware rev. everyone is using, you don't have to second guess
bug reports by asking "oh and what firmware did the BIOS load onto
your card btw" each time.

Nobody, and I mean nobody, except Linux has a Qlogic,FC kernel driver
that fails to load a known version of the firmware.

Also, "128k of wasted space" is a bogus argument too.  If you
build it statically into the kernel, __init_data the firmware.
And when we have the initmem stuff working for modules again (Jakub
did this years ago) you'll get it free'd up for the non-static case
too.   Fix the problem, not a symptom.

If you had put something like "This driver removed due to copyright
problems" into qlogicfc.c then I would have had no problems.

But to see only the firmware disappear almost looked like a careless
merge error.

Later,
David S. Miller
davem@redhat.com

