Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129703AbQKYWyV>; Sat, 25 Nov 2000 17:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131600AbQKYWyM>; Sat, 25 Nov 2000 17:54:12 -0500
Received: from taku.hut.fi ([130.233.228.87]:56588 "EHLO taku.hut.fi")
        by vger.kernel.org with ESMTP id <S129703AbQKYWx7>;
        Sat, 25 Nov 2000 17:53:59 -0500
Date: Sun, 26 Nov 2000 00:23:11 +0200 (EET)
From: Tuomas Heino <iheino@cc.hut.fi>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PIIX4 BX Errata for DMA errors.
In-Reply-To: <Pine.LNX.4.10.10011241823350.7446-100000@master.linux-ide.org>
Message-ID: <Pine.OSF.4.10.10011252332030.30210-100000@smaragdi.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Andre Hedrick wrote:

> Anyone having DMA errors that are dmaproc: error 14, there is not a clean
> workaround yet.  Also the Intel erratas state that only a bus reset will
> clear the hang, but the details are loose.

We talking about errors like the following one? :

Nov 18 10:08:46 bx3 kernel: hdb: timeout waiting for DMA
Nov 18 10:08:46 bx3 kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
Nov 18 10:08:46 bx3 kernel: hdb: irq timeout: status=0xd0 { Busy }
Nov 18 10:08:46 bx3 kernel: hda: DMA disabled
Nov 18 10:08:46 bx3 kernel: hdb: DMA disabled
Nov 18 10:08:48 bx3 kernel: ide0: reset: success

If so, anyone happen to be able to help me figure out why that keeps
happening on hdb & hdd while it never happens on hda?

/dev/hda:

 Model=IBM-DJNA-352500, FwRev=J51OA30K, SerialNo=GW0GWF37316
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=1966kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=49981680
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4

/dev/hdb:

 Model=IBM-DTTA-371440, FwRev=T71OA73A, SerialNo=WK0WKG29267
 BuffType=DualPortCache, BuffSize=462kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=28229040
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 *udma1 udma2

/dev/hdd:

 Model=IBM-DTTA-371440, FwRev=T71OA73A, SerialNo=WK0WKA28245
 BuffType=DualPortCache, BuffSize=462kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=28229040
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2

Also is there a way to actually use /proc/ide/hd?/smart_* ?

# diff -u --recursive 19990822 20001125 | diffstat
 hda/smart_values |   14 +++++++-------
 hdb/smart_values |   12 ++++++------
 hdd/smart_values |   10 +++++-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
