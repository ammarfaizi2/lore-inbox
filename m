Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131858AbQKTOtq>; Mon, 20 Nov 2000 09:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131958AbQKTOth>; Mon, 20 Nov 2000 09:49:37 -0500
Received: from hera.cwi.nl ([192.16.191.1]:12711 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131938AbQKTOt1>;
	Mon, 20 Nov 2000 09:49:27 -0500
Date: Mon, 20 Nov 2000 15:19:02 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011201419.PAA132679.aeb@aak.cwi.nl>
To: aeb@veritas.com, andre@linux-ide.org
Subject: Re: [PATCH] Large "clipped" IDE disk support for 2.4 when using old BIOS
Cc: linux-kernel@vger.kernel.org, tai@imasy.or.jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From andre@linux-ide.org Mon Nov 20 12:29:59 2000

    Andries,

    Don't you mean

    (drive->id->cfs_enable_1 & 0x0400)        word85
    and not
    (drive->id->command_set_1 & 0x0400)        word82

    Because when bit 10 of word 85 is not set then clip or HPArea is not enabled.

I saw no reason to complain about that part.

As far as I can see, ATA4 and ATA5 both require these two bits
to be identical. (Note that ATA4 has "supported" both in text
and table in both places, while ATA5 has "supported" in three
places and "enabled" in one. My preliminary ATA6 drafts do not differ.
And for example, there is no Set Features subcommand to enable/disable
the Host Protected Area feature. Maybe you have more recent drafts that
do allow disabling this feature?)

A small detail that might be improved is that one is only allowed to look
at this bit when words 83 and 84 have bit 15 equal to 0 and bit 14 equal to 1.
(Or, in case you prefer looking at word 85, bit 15 of word 87
must be 0 and bit 14 must be 1.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
