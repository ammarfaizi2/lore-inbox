Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310546AbSCQLTK>; Sun, 17 Mar 2002 06:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSCQLTA>; Sun, 17 Mar 2002 06:19:00 -0500
Received: from bjgate.bj-ig.de ([194.127.182.253]:44674 "EHLO tower.bj-ig.de")
	by vger.kernel.org with ESMTP id <S289191AbSCQLSv>;
	Sun, 17 Mar 2002 06:18:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ralf =?iso-8859-15?q?M=FCller?= <ralf@bj-ig.de>
Message-Id: <200203171153.48705@bj-ig.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add Promise 20276 to supported IDE controllers
Date: Sun, 17 Mar 2002 12:18:27 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We had to do the following patch to get an onboard Promise 20276 ide
controller working on our system - maybe one of you is interested.

The patch is against 2.4.19-pre3.

Ralf

===========[cut here]==============
*** linux-2.4.19-pre3/drivers/ide/pdc202xx.c    Sun Mar 17 01:18:05 2002
- --- linux/drivers/ide/pdc202xx.c        Sun Mar 17 11:44:22 2002
***************
*** 218,223 ****
- --- 218,226 ----
                case PCI_DEVICE_ID_PROMISE_20275:
                        p += sprintf(p, "\n                                PDC20275 Chipset.\n");
                        break;
+               case PCI_DEVICE_ID_PROMISE_20276:
+                       p += sprintf(p, "\n                                PDC20276 Chipset.\n");
+                       break;
                case PCI_DEVICE_ID_PROMISE_20269:
                        p += sprintf(p, "\n                                PDC20269 TX2 Chipset.\n");
                        break;
***************
*** 237,242 ****
- --- 240,246 ----
        char *p = buffer;
        switch(bmide_dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268:
                case PCI_DEVICE_ID_PROMISE_20268R:
***************
*** 730,735 ****
- --- 734,740 ----

        switch(dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_PROMISE_20269:
                        udma_133 = (udma_66) ? 1 : 0;
                        udma_100 = (udma_66) ? 1 : 0;
***************
*** 987,992 ****
- --- 992,998 ----

        switch (dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268R:
                case PCI_DEVICE_ID_PROMISE_20268:
***************
*** 1119,1124 ****
- --- 1125,1131 ----

        switch (dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268R:
                case PCI_DEVICE_ID_PROMISE_20268:
***************
*** 1213,1218 ****
- --- 1220,1226 ----

          switch(hwif->pci_dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268:
                case PCI_DEVICE_ID_PROMISE_20268R:
***************
*** 1231,1236 ****
- --- 1239,1245 ----

          switch(hwif->pci_dev->device) {
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20268:
                case PCI_DEVICE_ID_PROMISE_20268R:
*** linux-2.4.19-pre3/drivers/ide/ide-pci.c     Sun Mar 17 01:20:00 2002
- --- linux/drivers/ide/ide-pci.c Sun Mar 17 11:39:11 2002
***************
*** 56,61 ****
- --- 56,62 ----
  #define DEVID_PDC20268R ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268R})
  #define DEVID_PDC20269        ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269})
  #define DEVID_PDC20275        ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275})
+ #define DEVID_PDC20276        ((ide_pci_devid_t){PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276})
  #define DEVID_RZ1000  ((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1000})
  #define DEVID_RZ1001  ((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_RZ1001})
  #define DEVID_SAMURAI ((ide_pci_devid_t){PCI_VENDOR_ID_PCTECH,  PCI_DEVICE_ID_PCTECH_SAMURAI_IDE})
***************
*** 420,425 ****
- --- 421,427 ----
        {DEVID_PDC20268R,"PDC20270",    PCI_PDC202XX,   ATA66_PDC202XX, INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,      0 },
        {DEVID_PDC20269,"PDC20269",     PCI_PDC202XX,   ATA66_PDC202XX,  INIT_PDC202XX, NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,      0 },
        {DEVID_PDC20275,"PDC20275",     PCI_PDC202XX,   ATA66_PDC202XX, INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,      0 },
+       {DEVID_PDC20276,"PDC20276",     PCI_PDC202XX,   ATA66_PDC202XX, INIT_PDC202XX,  NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   OFF_BOARD,      0 },
        {DEVID_RZ1000,  "RZ1000",       NULL,           NULL,           INIT_RZ1000,    NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,       0 },
        {DEVID_RZ1001,  "RZ1001",       NULL,           NULL,           INIT_RZ1000,    NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,       0 },
        {DEVID_SAMURAI, "SAMURAI",      NULL,           NULL,           INIT_SAMURAI,   NULL,           {{0x00,0x00,0x00}, {0x00,0x00,0x00}},   ON_BOARD,       0 },
***************
*** 481,486 ****
- --- 483,489 ----
                case PCI_DEVICE_ID_PROMISE_20268R:
                case PCI_DEVICE_ID_PROMISE_20269:
                case PCI_DEVICE_ID_PROMISE_20275:
+               case PCI_DEVICE_ID_PROMISE_20276:
                case PCI_DEVICE_ID_ARTOP_ATP850UF:
                case PCI_DEVICE_ID_ARTOP_ATP860:
                case PCI_DEVICE_ID_ARTOP_ATP860R:
***************
*** 810,815 ****
- --- 813,819 ----
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20268R) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20269) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20275) ||
+                   IDE_PCI_DEVID_EQ(d->devid, DEVID_PDC20276) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6210) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260) ||
                    IDE_PCI_DEVID_EQ(d->devid, DEVID_AEC6260R) ||
*** linux-2.4.19-pre3/include/linux/pci_ids.h   Sun Mar 17 01:32:41 2002
- --- linux/include/linux/pci_ids.h       Sun Mar 17 11:48:02 2002
***************
*** 606,611 ****
- --- 606,612 ----
  #define PCI_DEVICE_ID_PROMISE_20268R  0x6268
  #define PCI_DEVICE_ID_PROMISE_20269   0x4d69
  #define PCI_DEVICE_ID_PROMISE_20275   0x1275
+ #define PCI_DEVICE_ID_PROMISE_20276   0x5275
  #define PCI_DEVICE_ID_PROMISE_5300    0x5300

  #define PCI_VENDOR_ID_N9              0x105d
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyUe4sACgkQZcF+4X5mWz9PdwCfWcMYTVtDAO9VhUQVHvD7Hljl
408AnR4cIk/W5nbHn/QAMminLO6MCyIT
=f6yE
-----END PGP SIGNATURE-----
