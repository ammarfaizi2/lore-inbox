Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143421AbRAHMZU>; Mon, 8 Jan 2001 07:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137106AbRAHMZK>; Mon, 8 Jan 2001 07:25:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15108 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143421AbRAHMZD>; Mon, 8 Jan 2001 07:25:03 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 8 Jan 2001 12:26:17 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101080711470.4061-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 07:16:25 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FbNU-0004SI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm... Details, please? Are you talking about 2^32 or about fs layout limits?
> The former may very well belong to VFS - no arguments here. The latter...
> And yes, fs layout limits are visible - for ext2 they can be as low as 2^24
> blocks.

The SuS rules require write checks

resource limit
	if that stops all of the write
			SIGXFZ
			EFBIG
	else short write

!O_LARGEFILE and > off_t limit
	if that stops all of the write
			SIGXFZ
			EFBIG
	else short write

over fs limit
	if that stops all the write
			SIGXFZ
			EFBIG
	else short write

truncate has to honour the resource and fs limit. ftruncate also checks
the O_LARGEFILE limit.

Finally some OS's actually let you F_SETFL O_LARGEFILE.

I can put all that in the VFS so I did (right now the ext2 size calculator is
wrong but thats proof of concept detail). Just need to shift if over from
ext2/file.c

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
