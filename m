Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267408AbTAVJ6h>; Wed, 22 Jan 2003 04:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267409AbTAVJ6h>; Wed, 22 Jan 2003 04:58:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:7198 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267408AbTAVJ6f>;
	Wed, 22 Jan 2003 04:58:35 -0500
Message-ID: <3E2E6D84.8D485EF3@gmx.net>
Date: Wed, 22 Jan 2003 11:08:04 +0100
From: Matjaz Omerzel <21442@gmx.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bad TCP checksums - can you solve the puzzle?
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can it be possible that my i486 machine (100MHz, 32Mb RAM, running
2.4.18) with 3Com 3c905C-TX (Tornado) occasionally miscalculates TCP
checksums for outgoing packets?

Running "tcpdump -vvv -e -s 0 -w file" on 486, and examining file with
ethereal showed outgoing packet:

TCP checksum 3c4b (correct)

Obviously, this was a lie, because "netstat -s" on the client shows bad
segments received, and ethereal on the client said for the received
packet:

TCP checksum 3c4b (incorrect, should be 3c47)

I am unable to transfer anything more than a few megabytes from this
486, as client drops invalid packets and connection eventually hangs. In
fact, in 1 out 10 connections TCP recovers as though as a mysterious
force changed some bits and corrected the checksum, but only to hang
again a second later. So much about putting an old 486 in use for an
internet gateway...

I have personally assured that packet of dispute in example above was
identical on both sides. Same kernel was used on both sides, same
ethereal, and same sha1sum. Besides this, I have also tried numerous
other clients, from win2k, xp, to solaris, and in all cases connections
hang within a few seconds.

And now to the funny part.

Network card is verified and working. IP checksums never fail (0 packets
lost after two days of flood ping). TCP works with same kernel, same NIC
but on a different machine (Athlon 950) as well as with same machine,
same NIC and Windows 98. Needless to say, it works with different
machine (PIII) and different OS (Win2k).

Machine is verified, it has been working reliably for years. If, instead
of Tornado, I use a 3Com 3C509B (10Mbit EISA), the TCP works perfectly.
But if Tornado card was defective, TCP should also work with Via Rhine
(DFE-530TX) - but it DOESN'T. (However, drivers via-rhine and 3c59x I
believe were made by the same author, just in case that makes any sense)

Driver 3c59x is verified. It works with the same NIC, same kernel but in
a different machine. (BTW, weren't these cards/drivers among ones of the
highest reputation?) I have also tried 2.4.7 and 2.4.20 with the same
hardware - you guessed it, it didn't help either.

Kernel is verified. In several of my other installations from the same
RedHat 8 CD set, I have not seen this problem ever occur, and some of
the machines had the very same kind of NIC. And you should probably know
that better than me! 8-)

No problems with link or wire either. I am using direct crossover cable,
cards hook up in 100 Mbit/s and full duplex instantly. It does not
matter what the link partner is. There are no I/O or IRQ conflicts.
Forcing other speeds and duplex modes does not help, nor does toying
with hdparam or kernel compilation parameters. And I've tried many, I
believe. mii-diag says everything is okay.

PCI slot is verified. It does not matter into which slot I put the card,
or how I set PCI parameters in BIOS. Other cards work in this slot, this
cards doesn't work in any.

It does not matter how I set hw_checksums (3c59x.c) or
CONFIG_USE_PPRO_CHECKSUM (checksum.S). Isn't that strange? If the wrong
checksum was made in kernel, using hardware checksums should make the
problem go away. And vice versa.

Any clues or hints about what's going on? I would greatly appreciate
them, or at least some suggestions about what else to try. Because after
months without progress, I feel exhausted and I'm starting to run out of
ideas.

Nevertheless, I am not losing my enthusiasm in Linux. So please nobody
mention the cost of replacing the 486!

Best regards, Matjaz
(I am not a list member)
