Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130874AbQKZLUl>; Sun, 26 Nov 2000 06:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131063AbQKZLUb>; Sun, 26 Nov 2000 06:20:31 -0500
Received: from 194-73-188-238.btconnect.com ([194.73.188.238]:35844 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130874AbQKZLUT>;
        Sun, 26 Nov 2000 06:20:19 -0500
Date: Sun, 26 Nov 2000 10:52:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: John Alvord <jalvo@mbay.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <3a219890.57346310@mail.mbay.net>
Message-ID: <Pine.LNX.4.21.0011261048130.1039-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, John Alvord wrote:
> It also says "I do not know much about the details of the kernel C
> environment. In particular I do not know that all static variables are
> initialized to 0 in the kernel startup. I have not read setup.S."
                                                          ~~~~~~~~~

Sorry, John, I _have_ to [give good example to others]. The above says
that _you_ my dear friend, do not know where the BSS clearing code is. It
is not in setup.S. It is not even in the same directory, where setup.S is.
It is in arch/i386/kernel/head.S, starting from line 120:

/*
 * Clear BSS first so that there are no surprises...
 */
        xorl %eax,%eax
        movl $ SYMBOL_NAME(__bss_start),%edi
        movl $ SYMBOL_NAME(_end),%ecx
        subl %edi,%ecx
        cld
        rep
        stosb

... speaking of which (putting asbesto on and hiding from Andries ;) can't
we optimize this code to move words at a time and not bytes.... ;)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
