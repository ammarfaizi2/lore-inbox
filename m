Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131464AbQK2OcN>; Wed, 29 Nov 2000 09:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131482AbQK2OcD>; Wed, 29 Nov 2000 09:32:03 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:34570 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S131464AbQK2Obp>; Wed, 29 Nov 2000 09:31:45 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14885.3093.502426.711124@wire.cadcamlab.org>
Date: Wed, 29 Nov 2000 08:00:53 -0600 (CST)
To: Tigran Aivazian <tigran@veritas.com>
Cc: David Hinds <dhinds@valinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
In-Reply-To: <20001128175348.J8881@wire.cadcamlab.org>
        <Pine.LNX.4.21.0011290744260.798-100000@penguin.homenet>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tigran Aivazian <tigran@veritas.com>]
> no, I was not talking about ISO C standards but about the normal
> expected C environment under any UNIX. I guess, we just mean
> different things by "trivially equivalent" since neither of us said
> anything about what that actually meant. What I meant by that was
> "not only imply the same logic for the program but correspond to the
> same physical locations (if any) on the resulting object file".

OK, so we do mean two different things.  As far as standard C is
concerned, the location of your global variables is none of your
business, as long as they can be addressed with a pointer of the
appropriate type.  By the time you get to caring about what section
something goes in, you're way beyond standard C, and you need to start
looking at the gcc __attribute__(("section")) extension, and possibly
an ld link script.

So I guess to me "trivially equivalent" meant that a standards-
conforming C program would never notice the difference.  As such, I
think -fassume-bss-zero would be an entirely reasonable default for a C
compiler, just as reasonable as reordering globals within a section
(and nobody seems to be questioning gcc's right to do *that*).

It would probably also be reasonable to document it and provide an
option to switch it off.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
