Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSE0D7w>; Sun, 26 May 2002 23:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSE0D7v>; Sun, 26 May 2002 23:59:51 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:3344 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S310190AbSE0D7t>; Sun, 26 May 2002 23:59:49 -0400
Date: Sun, 26 May 2002 20:57:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Copyright Violation (Re: [patch] New driver for Artop [Acard]
 controllers.)
In-Reply-To: <1022460150.11859.187.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10205261916570.3010-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

So look for yourself, this is extracted straight out if the patch
submitted to LKML.  It is very clear, without the NDA Documentation and no
hardware to perform a clean-room new driver.  Without the is information,
one could not write a driver for the hardware.

Now to quote Vojtech,

"After getting a couple reports that the Artop driver doesn't work, I
decided to take a look at it ... well and I decided that this is
impossible to debug, so I rewrote it from scratch instead. I have no
documentation nor the actual hardware, so it may be wrong somewhere,
but I think definitely less wrong than the original one."


*****************
ChangeSet@1.657, 2002-05-24 15:34:29+02:00, vojtech@twilight.ucw.cz
  This is a new driver for the Artop (Acard) controllers. It's completely
  untested, as I have never seen the hardware. However, I suspect it is
  much less broken than the previous one ...

<comment>
For starters he has no hardware and no documents, and he has read my
copyrighted source code, thus there is no way for him to have a clean room
model.
</comment>

+/*
+ *
+ * $Id: aec62xx.c,v 1.0 2002/05/24 14:37:19 vojtech Exp $
  *
- * Version 0.11        March 27, 2002
+ *  Copyright (c) 2002 Vojtech Pavlik
  *
- * Copyright (C) 1999-2000     Andre Hedrick (andre@linux-ide.org)
+ *  Based on the work of:
+ *     Andre Hedrick
+ */

<comment>
All that has to be done is return proper CopyRight clauses.
</comment>

+static unsigned char aec_cyc2udma[17] = { 0, 0, 7, 6, 5, 4, 4, 3, 3, 2, 2, 2,
2, 1, 1, 1, 1 };

-
-struct chipset_bus_clock_list_entry aec62xx_base [] = {
-#ifdef CONFIG_BLK_DEV_IDEDMA
-       {       XFER_UDMA_6,    0x41,   0x06,   0x31,   0x07    },
-       {       XFER_UDMA_5,    0x41,   0x05,   0x31,   0x06    },
-       {       XFER_UDMA_4,    0x41,   0x04,   0x31,   0x05    },
-       {       XFER_UDMA_3,    0x41,   0x03,   0x31,   0x04    },
-       {       XFER_UDMA_2,    0x41,   0x02,   0x31,   0x03    },
-       {       XFER_UDMA_1,    0x41,   0x01,   0x31,   0x02    },
-       {       XFER_UDMA_0,    0x41,   0x01,   0x31,   0x01    },
-
-       {       XFER_MW_DMA_2,  0x41,   0x00,   0x31,   0x00    },
-       {       XFER_MW_DMA_1,  0x42,   0x00,   0x31,   0x00    },
-       {       XFER_MW_DMA_0,  0x7a,   0x00,   0x0a,   0x00    },
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-       {       XFER_PIO_4,     0x41,   0x00,   0x31,   0x00    },
-       {       XFER_PIO_3,     0x43,   0x00,   0x33,   0x00    },
-       {       XFER_PIO_2,     0x78,   0x00,   0x08,   0x00    },
-       {       XFER_PIO_1,     0x7a,   0x00,   0x0a,   0x00    },
-       {       XFER_PIO_0,     0x70,   0x00,   0x00,   0x00    },
-       {       0,              0x00,   0x00,   0x00,   0x00    }
-};

<comment>
New table is purely derived from the previous table.
It is clever to hide the push/pull in the index based on the card.
This will generate the associated pairs identically from the static table.
</comment>

+#define AEC_MISC               0x49

 static unsigned int __init aec62xx_ata66_check(struct ata_channel *ch)
 {
-       u8 mask = ch->unit ? 0x02 : 0x01;
-       u8 ata66 = 0;
+       unsigned char t;

-       pci_read_config_byte(ch->pci_dev, 0x49, &ata66);
-
-       return ((ata66 & mask) ? 0 : 1);
+       pci_read_config_byte(ch->pci_dev, AEC_MISC, &t);
+       return ((t & (1 << ch->unit)) ? 0 : 1);
 }

<comment>
Here he moves a specified pci-config space register to a define.
Next he trades the mask for a bit shift.
Next he renames the test variable.
</comment>


-       pci_read_config_word(dev, 0x40|(2*drive->dn), &d_conf);
-       tmp0 = pci_bus_clock_list(speed, aec62xx_base);
-       SPLIT_BYTE(tmp0,tmp1,tmp2);
-       MAKE_WORD(d_conf,tmp1,tmp2);
-       pci_write_config_word(dev, 0x40|(2*drive->dn), d_conf);

-static int aec6260_tune_chipset(struct ata_device *drive, byte speed)
-{
-       struct pci_dev *dev = drive->channel->pci_dev;
-       byte unit               = (drive->select.b.unit & 0x01);
-       u8 ultra_pci = drive->channel->unit ? 0x45 : 0x44;
-       byte drive_conf         = 0x00;

-static int aec6210_tune_chipset(struct ata_device *drive, byte speed)
-{
-       pci_read_config_byte(dev, 0x54, &ultra);
-       tmp1 = ((0x00 << (2*drive->dn)) | (ultra & ~(3 << (2*drive->dn))));
-       ultra_conf = pci_bus_clock_list_ultra(speed, aec62xx_base);
-       tmp2 = ((ultra_conf << (2*drive->dn)) | (tmp1 & ~(3 << (2*drive->dn))));
-       pci_write_config_byte(dev, 0x54, tmp2);

+#define AEC_DRIVE_TIMING       0x40
+#define AEC_UDMA_NEW           0x44
+#define AEC_UDMA_OLD           0x54

+       pci_write_config_byte(dev, AEC_DRIVE_TIMING + dn,
+               (FIT(timing->active, 0, 15) << 4) | FIT(timing->recover, 0, 15));
+
+       pci_read_config_byte(dev, AEC_UDMA_NEW + (dn >> 1), &t);
+       t &= ~(0xf << ((dn & 1) << 2));
+       if (timing->udma)
+               t |= aec_cyc2udma[FIT(timing->udma, 2, 16)] << ((dn & 1) << 2);
+       pci_write_config_byte(dev, AEC_UDMA_NEW + (dn >> 1), t);

<comment>
These are a little more difficult to see
Here he adds a skip masking order to merge timings into one call.
</comment>

*****************

Regards,

Andre Hedrick
LAD Storage Consulting Group

AEC6280R: IDE controller on PCI bus 02 dev 20
AEC6280R: chipset revision 2
AEC6280R: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
AEC6880R: IDE controller on PCI bus 02 dev 28
AEC6880R: chipset revision 2
AEC6880R: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0xb400-0xb407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0xb408-0xb40f, BIOS settings: hdk:pio, hdl:pio

Controller: 0
Chipset: AEC865
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no
DMA Mode:       UDMA(5)           PIO(?)         UDMA(5)            PIO(?)

Controller: 1 
Chipset: AEC865
--------------- Primary Channel ---------------- Secondary Channel -------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              no              yes               no
DMA Mode:       UDMA(6)           PIO(?)         UDMA(6)            PIO(?)

Nor could one know the detection difference between the two chipset with
the same device id and revision.

02:04.0 SCSI storage controller: Artop Electronic Corp: Unknown device 0009 (rev 02)
02:05.0 SCSI storage controller: Artop Electronic Corp: Unknown device 0009 (rev 02)


On 27 May 2002, Alan Cox wrote:

> On Mon, 2002-05-27 at 00:08, Andre Hedrick wrote:
> > All of the original code described how to make the hardware operate.  If
> > your code makes the hardware operate, then it uses material copyrighted 
> > and owned by me.
> 
> Really. You think if I read a GPL'd example of a piece of code I can't
> write a non GPL'd one. Companies use two sets of people to ensure that
> there are no questions (one set write the spec, the other to write from
> that spec in a different building).
> 
> > I suggest you think real hard and long about your decisions to go about
> > calling derived works from stolen/deleted Copyrights. 
> 
> Rude yes, but derived work.. open question. I guess Eben can give you a
> reasonably sane opinion if its so important.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



