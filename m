Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129625AbQK1S4r>; Tue, 28 Nov 2000 13:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129710AbQK1S4h>; Tue, 28 Nov 2000 13:56:37 -0500
Received: from [212.32.186.211] ([212.32.186.211]:32155 "EHLO
        fungus.svenskatest.se") by vger.kernel.org with ESMTP
        id <S129625AbQK1S4X>; Tue, 28 Nov 2000 13:56:23 -0500
Date: Tue, 28 Nov 2000 19:26:12 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Subject: Re: Bug in date converting functions DOS<=>UNIX in FAT, NCPFS and
 SMBFS drivers
In-Reply-To: <Pine.GSO.3.96.SK.1001124162224.25896A-200000@univ.uniyar.ac.ru>
Message-ID: <Pine.LNX.4.21.0011251250460.16600-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Igor Yu. Zhbanov wrote:

> Hello!

Hello, sorry for the slow response.

> I have found a bug in drivers of file systems which use a DOS-like format
> of date (16 bit: years since 1980 - 7 bits, month - 4 bits, day - 5 bits).

[snip]

> 2) VFAT for example have three kinds of dates: creation date, modification date
>    and access date. Sometimes one of these dates is set to zero (which indicates
>    that this date is not set). Zero is not a valid date (e.g. months are
>    numbered from one, not from zero) and can't be properly converted to
>    UNIX-like format of date (it was converted to date before 1980).

Days are also numbered from one (at least smbfs) and this change doesn't
do anything about that. An all zero date gives 315446400 (or else my
testprogram is broken) and you wanted it to give 315532800 (?). So that
should be fixed too, I think.

It would be nice if someone would rewrite these shift-and-mask orgies into
something with a bit more structure (bitfields? hmm, endianess problems?
undefined compiler behaviour? I don't know ... macros?).

I'm having trouble following these, but maybe that's just me.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
