Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154288-31090>; Fri, 18 Dec 1998 04:24:22 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:4483 "EHLO smtp1.cern.ch" ident: "TIMEDOUT") by vger.rutgers.edu with ESMTP id <154394-31090>; Fri, 18 Dec 1998 04:19:06 -0500
To: MOLNAR Ingo <mingo@chiara.csoma.elte.hu>
Cc: Matt Kemner <kemner@live.networx.net.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: Re: 2.0.37pre3 won't boot
References: <Pine.LNX.3.96.981218100345.765A-100000@chiara.csoma.elte.hu>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 18 Dec 1998 11:03:38 +0100
In-Reply-To: MOLNAR Ingo's message of "Fri, 18 Dec 1998 10:09:56 +0100 (CET)"
Message-ID: <d31zlxsr5x.fsf@valhall.cern.ch>
X-Mailer: Quassia Gnus v0.37/Emacs 20.2
Sender: owner-linux-kernel@vger.rutgers.edu

>>>>> "Ingo" == MOLNAR Ingo <mingo@chiara.csoma.elte.hu> writes:

Ingo> On Fri, 18 Dec 1998, Matt Kemner wrote:

>> However I just compiled and installed 2.0.37pre3 on one of my
>> PRODUCTION machines, and am getting the same error - it will
>> uncompress, tell me it's booting the kernel, and then I get
>> nothing. This machine is an intel P166 Classic on a HX board, 96MB
>> RAM, Stallion host adapter with 4x16 tty panels.

Ingo> i am currently debugging a similar problem, and the funny thing
Ingo> is that if the kernel is compiled on my box, the system boots,
Ingo> if it's compiled on the failing system, it doesnt ... So just
Ingo> about the only remaining variable is binutils. What version of
Ingo> binutils do you have, especially the version of as86 and ld86?
Ingo> the one i have is:

Hmmmm there was a modification in a late 2.8.1.0.x binutils that
changed the behavior of the alignment of segments when linking. It
struck us on the m68k by preventing 2.0.x kernels from booting so I
did a nasty hack and reverted the patch for the binutils RPM on the
m68k.

Dunno if it is related, but I attached the patch below.

Jes

--- binutils-2.9.1.0.4/ld/scripttempl/elf.sc~	Tue Feb 17 20:36:01 1998
+++ binutils-2.9.1.0.4/ld/scripttempl/elf.sc	Thu Jul 23 17:57:41 1998
@@ -165,7 +165,6 @@
    *(.bss)
    *(COMMON)
   }
-  ${RELOCATING+. = ALIGN(${ELFSIZE} / 8);}
   ${RELOCATING+_end = . ;}
   ${RELOCATING+PROVIDE (end = .);}
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
