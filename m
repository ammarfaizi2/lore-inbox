Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130991AbQK1Vgm>; Tue, 28 Nov 2000 16:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131027AbQK1Vgc>; Tue, 28 Nov 2000 16:36:32 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:58633 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130991AbQK1VgV>;
        Tue, 28 Nov 2000 16:36:21 -0500
Date: Tue, 28 Nov 2000 21:08:13 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: David Hinds <dhinds@valinux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
In-Reply-To: <20001128125840.A28888@valinux.com>
Message-ID: <Pine.LNX.4.21.0011282101030.1940-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, David Hinds wrote:
> I would contend that it is a compiler bug in gcc if it treats the two
> statements differently, since they are trivially equivalent.  I guess
> that it has been decided that linux kernel coding style dictates no
> zero initializers, so that's that.  Personally, I prefer symmetry: if
> I have a list of static variables initialized to various things, I
> don't have to use a different form for ones that are zero initialized.

I would contend that you are wrong -- it is not a compiler bug.

First, they are not trivially equivalent. In fact, they are not equivalent
at all. Any good C book should tell you that one places data in "data
segment" and another in "bss segment" (with a footnote explaining
historical meaning of "block started by symbol")

Second, If compiler did the ".data -> .bss" move on the fly then it would
violate the principle of least surprize. For example a programmer could
expect the variable to be in .data for binary patching the object (this
reason is not applicable to the Linux kernel because section information
is lost when converting vmlinux to raw binary and then onto bzImage).

> 
> Did the savings really work out to be measured in kb's of space?  I
> would have expected compression to eliminate most of the savings.
> 

if one doesn't count compression then -- hundreds of Kbs (K=1024 and b =
byte, not bit!). Even Mbs if you count multiple architectures.

Use Keith Owens' famous perl script to do the counting.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
