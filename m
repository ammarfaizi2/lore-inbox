Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRAZKu2>; Fri, 26 Jan 2001 05:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRAZKuT>; Fri, 26 Jan 2001 05:50:19 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:24240 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129143AbRAZKuC>; Fri, 26 Jan 2001 05:50:02 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200101261049.LAA26608@sunrise.pg.gda.pl>
Subject: Re: Marking sectors on IDE drives as bad
To: Petter.Wahlman@compaq.com (Wahlman, Petter)
Date: Fri, 26 Jan 2001 11:49:36 +0100 (MET)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org'),
        andre@linux-ide.org ('Andre Hedrick'),
        hahn@coffee.psychology.mcmaster.ca ('Mark Hahn'),
        adilger@turbolinux.com ('Andreas Dilger')
In-Reply-To: <E7D21F6C2128D41199B600508BCF8D54A9AD69@nosexc01.nwo.cpqcorp.net> from "Wahlman, Petter" at Jan 26, 2001 10:36:41 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Wahlman, Petter wrote:"
> The problem still persist, even after marking the respective block with:
> badblocks -n -o /var/log/badblocks,
> and e2fsck -l /var/log/badblocks

> fsck is forced at boot, with the previously mentioned error: 
> 
> Jan 26 10:32:37 evil kernel: hda: read_intr: error=0x01 { AddrMarkNotFound
> }, LBAsect=10262250, sector=1311147
> Jan 26 10:32:37 evil kernel: ide0: reset: success
> Jan 26 10:32:37 evil kernel: hda: read_intr: status=0x59 { DriveReady
> SeekComplete DataRequest Error }

IDE layer knows nothing about ext2 marked badblocks.
Did you turn off multicount (PIO) and readahead (DMA) for this disk
using hdparm ?

However note that some ext2 structure information is not relocable.
So if bad blocks hit them you lose.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
