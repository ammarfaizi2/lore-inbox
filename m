Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129278AbQJaQDh>; Tue, 31 Oct 2000 11:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129517AbQJaQD1>; Tue, 31 Oct 2000 11:03:27 -0500
Received: from mail05.syd.optusnet.com.au ([203.2.75.115]:40390 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S129278AbQJaQDN>; Tue, 31 Oct 2000 11:03:13 -0500
Message-ID: <39FEED28.6D9A1C3A@mira.net>
Date: Wed, 01 Nov 2000 03:02:48 +1100
From: Antony Suter <antony@mira.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0a7-0.35mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: for small packets TCP_NODELAY still delays
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(repost, apologies if youve seen this before)

There appeared to be a bug/feature in kernel series 2.0.x and 2.2.x
which caused perodic delays in the sending of very small TCP packets
even when the TCP_NODELAY option was set. In other words, the Linux
kernel was still trying to use delayed acknowledgements.

To quote:
"A detailed measurement of inter-message timing revealed that every
35th message under about 500 bytes is delayed by 20 ms under Linux
kernel 2.0.36. Upgrading to Linux kernel 2.2.2 changed this conclusion
only slightly (every 41st message under about 100 bytes was delayed
by 10 or 20 ms)."

Does kernel 2.4.0-testX(latest) still have this behavior?

This bug/feature greatly impairs the performance of distributed parallel
programs like those that use MPI, as in a Beowulf cluster. Simple kernel
patches increase the performance by a factor of 20.

I dont grok TCP/IP stacks so perhaps im being rude and dont understand
that there might be a valid reason why this bug/feature still happens.
In that case, it would be the right thing to include this as an
optimisation setable by a kernel compile time flag or even a sysctl
variable.

What comments do the 2.4.0 kernel networking experts have about this?

Source of the quote:-
http://www.icase.edu/coral/LinuxTCP.html
http://www.icase.edu/coral/LinuxTCP2.html

The pages include a link to a tool netpipe which can be used to measure
these performance factors.

--
- Antony Suter  (antony@mira.net)  "Examiner"  openpgp:71ADFC87
- "And how do you store the nuclear equivalent of the universal
- solvent?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
