Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131934AbQLVSzW>; Fri, 22 Dec 2000 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132009AbQLVSzN>; Fri, 22 Dec 2000 13:55:13 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:42492 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S132008AbQLVSy5>; Fri, 22 Dec 2000 13:54:57 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012221824.eBMIOEN27293@webber.adilger.net>
Subject: Re: max number of ide controllers?
In-Reply-To: <01e401c06c12$44aeee60$2b6e60cf@pcscs.com> "from Charles Wilkins
 at Dec 22, 2000 07:25:28 am"
To: Charles Wilkins <chas@pcscs.com>
Date: Fri, 22 Dec 2000 11:24:13 -0700 (MST)
CC: Andrzej Krzysztofowicz <ankry@pg.gda.pl>, linux-raid@vger.kernel.org,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Wilkins writes:
> I added this to lilo.conf:
> append="ide2=0x168,10" and ran lilo
> 
> This is what I got:
> ide_setup: ide2=0x168,10
> .
> .
> ide2: ports already in use, skipping probe
> 
> The promise controllers then setup as ide3 and ide4, but the SB32 still does
> not report.
> Any ideas?

Maybe set the new dual controller to be IDE 2,3 and have the SB32 as IDE4.
Also, you can check /proc/ioports and /proc/interrupts to see if there
actually are conflicts with the port ranges or interrupts of your card.
I'm guessing not, because it worked before, but you never know.

IDE cards actually have 2 port ranges, so it may be that with the new card
you are getting conflicts.  My system shows:

0170-0177 : ide1
01e8-01ef : ide2
01f0-01f7 : ide0

0376-0376 : ide1
03ee-03ee : ide2
03f6-03f6 : ide0

The second ide2 port is in the same place as ttyS2 (com3)...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
