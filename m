Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKTMaS>; Mon, 20 Nov 2000 07:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129851AbQKTMaI>; Mon, 20 Nov 2000 07:30:08 -0500
Received: from tasogare.imasy.or.jp ([202.227.24.5]:55564 "EHLO
	tasogare.imasy.or.jp") by vger.kernel.org with ESMTP
	id <S129210AbQKTM3x>; Mon, 20 Nov 2000 07:29:53 -0500
Message-Id: <200011201159.eAKBxnq07622@tasogare.imasy.or.jp>
To: Andries Brouwer <aeb@veritas.com>
Cc: tai@imasy.or.jp, andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old BIOS
In-Reply-To: <20001120032615.A1540@veritas.com> <20001119182431.A1226@veritas.com> <200011192230.eAJMUC202514@research.imasy.or.jp>
In-Reply-To: <20001120032615.A1540@veritas.com>
Date: Mon, 20 Nov 2000 20:59:48 +0900
From: "T. Yamada" <tai@tasogare.imasy.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Both disks claim support for the Host Protected Area feature set.
> No doubt early disks had firmware flaws.

So it's yet another "borken hardware"... Is there anything like
SCSI "blacklist" for IDE driver? Then it could be handled easily
by registering the drive there and check that out before autodetection.

> - The routine idedisk_supports_host_protected_area()
> should look at bit 10 of command_set_1, but it does a "& 0x0a".

Oh, no. Thanks for catching that. It should obviously be 0x0400.

# I guess it got converted in a way like this: 10th bit -> 10 -> 0x0a. Ugh.

> - The assignment "hd_cap = hd_max;" is one off:

Now that explains one missing sector reported previously. Yes,
ATA spec says that the command returns "maximum address", not
number of sectors.

I'll make a fix and resend a patch - or since the fix is so
simple, I guess Andre can just add these fixes to IDE driver directly.

--
Taisuke Yamada <tai@imasy.or.jp>
PGP fingerprint = 6B 57 1B ED 65 4C 7D AE  57 1B 49 A7 F7 C8 23 46
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
