Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbTJGXU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 19:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTJGXU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 19:20:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:22773 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262450AbTJGXUY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 19:20:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][IDE] kill EOL value of ide_pci_device_t->bootable
Date: Wed, 8 Oct 2003 01:23:56 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310080123.56322.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] kill EOL value of ide_pci_device_t->bootable

Most PCI IDE drivers init bootable to EOL (=255) for last entry
of the *_chipsets[] table, but it is not checked anywhere.

 drivers/ide/pci/adma100.h      |    4 +---
 drivers/ide/pci/alim15x3.h     |    4 +---
 drivers/ide/pci/amd74xx.h      |    3 ---
 drivers/ide/pci/cmd640.h       |    4 +---
 drivers/ide/pci/cmd64x.h       |    1 -
 drivers/ide/pci/cs5530.h       |    4 +---
 drivers/ide/pci/cy82c693.h     |    4 +---
 drivers/ide/pci/generic.h      |    9 ++-------
 drivers/ide/pci/hpt34x.h       |    4 +---
 drivers/ide/pci/hpt366.h       |    4 +---
 drivers/ide/pci/it8172.h       |    4 +---
 drivers/ide/pci/ns87415.h      |    4 +---
 drivers/ide/pci/opti621.h      |    4 +---
 drivers/ide/pci/pdc202xx_new.h |    4 +---
 drivers/ide/pci/pdc202xx_old.h |    4 +---
 drivers/ide/pci/piix.h         |    4 +---
 drivers/ide/pci/rz1000.h       |    4 +---
 drivers/ide/pci/sc1200.h       |    4 +---
 drivers/ide/pci/serverworks.h  |    4 +---
 drivers/ide/pci/siimage.h      |    4 +---
 drivers/ide/pci/sis5513.h      |    4 +---
 drivers/ide/pci/sl82c105.h     |    4 +---
 drivers/ide/pci/slc90e66.h     |    4 +---
 drivers/ide/pci/triflex.h      |    4 +---
 drivers/ide/pci/trm290.h       |    4 +---
 drivers/ide/pci/via82cxxx.h    |    4 +---
 include/linux/ide.h            |    1 -
 27 files changed, 25 insertions(+), 81 deletions(-)

diff -puN drivers/ide/pci/adma100.h~ide-pci-kill-EOL drivers/ide/pci/adma100.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/adma100.h~ide-pci-kill-EOL	2003-10-08 00:54:32.714706360 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/adma100.h	2003-10-08 00:54:32.794694200 +0200
@@ -22,9 +22,7 @@ static ide_pci_device_t pdcadma_chipsets
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= OFF_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 }
 
 #endif /* ADMA_100_H */
diff -puN drivers/ide/pci/alim15x3.h~ide-pci-kill-EOL drivers/ide/pci/alim15x3.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/alim15x3.h~ide-pci-kill-EOL	2003-10-08 00:54:32.717705904 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/alim15x3.h	2003-10-08 00:54:32.794694200 +0200
@@ -40,9 +40,7 @@ static ide_pci_device_t ali15x3_chipsets
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* ALI15X3 */
diff -puN drivers/ide/pci/amd74xx.h~ide-pci-kill-EOL drivers/ide/pci/amd74xx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/amd74xx.h~ide-pci-kill-EOL	2003-10-08 00:54:32.720705448 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/amd74xx.h	2003-10-08 00:54:32.795694048 +0200
@@ -101,9 +101,6 @@ static ide_pci_device_t amd74xx_chipsets
 		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x01,0x01}},
 		.bootable	= ON_BOARD,
 	},
-	{
-		.bootable	= EOL,
-	}
 };
 
 #endif /* AMD74XX_H */
diff -puN drivers/ide/pci/cmd640.h~ide-pci-kill-EOL drivers/ide/pci/cmd640.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd640.h~ide-pci-kill-EOL	2003-10-08 00:54:32.723704992 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd640.h	2003-10-08 00:54:32.795694048 +0200
@@ -16,9 +16,7 @@ static ide_pci_device_t cmd640_chipsets[
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 }
 
 #endif /* CMD640_H */
diff -puN drivers/ide/pci/cmd64x.h~ide-pci-kill-EOL drivers/ide/pci/cmd64x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cmd64x.h~ide-pci-kill-EOL	2003-10-08 00:54:32.726704536 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cmd64x.h	2003-10-08 00:54:32.796693896 +0200
@@ -121,7 +121,6 @@ static ide_pci_device_t cmd64x_chipsets[
 		.bootable	= ON_BOARD,
 	},{
 		.channels	= 2,
-		.bootable	= EOL,
 	}
 };
 
diff -puN drivers/ide/pci/cs5530.h~ide-pci-kill-EOL drivers/ide/pci/cs5530.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cs5530.h~ide-pci-kill-EOL	2003-10-08 00:54:32.729704080 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cs5530.h	2003-10-08 00:54:32.796693896 +0200
@@ -37,9 +37,7 @@ static ide_pci_device_t cs5530_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* CS5530_H */
diff -puN drivers/ide/pci/cy82c693.h~ide-pci-kill-EOL drivers/ide/pci/cy82c693.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/cy82c693.h~ide-pci-kill-EOL	2003-10-08 00:54:32.732703624 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/cy82c693.h	2003-10-08 00:54:32.796693896 +0200
@@ -79,9 +79,7 @@ static ide_pci_device_t cy82c693_chipset
 		.channels	= 1,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* CY82C693_H */
diff -puN drivers/ide/pci/generic.h~ide-pci-kill-EOL drivers/ide/pci/generic.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/generic.h~ide-pci-kill-EOL	2003-10-08 00:54:32.735703168 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/generic.h	2003-10-08 00:54:32.797693744 +0200
@@ -100,9 +100,7 @@ static ide_pci_device_t generic_chipsets
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #if 0
@@ -114,10 +112,7 @@ static ide_pci_device_t unknown_chipset[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
-
+	},
 };
 #endif
 
diff -puN drivers/ide/pci/hpt34x.h~ide-pci-kill-EOL drivers/ide/pci/hpt34x.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt34x.h~ide-pci-kill-EOL	2003-10-08 00:54:32.738702712 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt34x.h	2003-10-08 00:54:32.797693744 +0200
@@ -44,9 +44,7 @@ static ide_pci_device_t hpt34x_chipsets[
 		.autodma	= NOAUTODMA,
 		.bootable	= NEVER_BOARD,
 		.extra		= 16
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* HPT34X_H */
diff -puN drivers/ide/pci/hpt366.h~ide-pci-kill-EOL drivers/ide/pci/hpt366.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/hpt366.h~ide-pci-kill-EOL	2003-10-08 00:54:32.741702256 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/hpt366.h	2003-10-08 00:54:32.798693592 +0200
@@ -497,9 +497,7 @@ static ide_pci_device_t hpt366_chipsets[
 		.channels	= 2,	/* 4 */
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* HPT366_H */
diff -puN drivers/ide/pci/it8172.h~ide-pci-kill-EOL drivers/ide/pci/it8172.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/it8172.h~ide-pci-kill-EOL	2003-10-08 00:54:32.743701952 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/it8172.h	2003-10-08 00:54:32.798693592 +0200
@@ -30,9 +30,7 @@ static ide_pci_device_t it8172_chipsets[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x00,0x00,0x00}, {0x40,0x00,0x01}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* ITE8172G_H */
diff -puN drivers/ide/pci/ns87415.h~ide-pci-kill-EOL drivers/ide/pci/ns87415.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/ns87415.h~ide-pci-kill-EOL	2003-10-08 00:54:32.746701496 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/ns87415.h	2003-10-08 00:54:32.799693440 +0200
@@ -16,9 +16,7 @@ static ide_pci_device_t ns87415_chipsets
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* NS87415_H */
diff -puN drivers/ide/pci/opti621.h~ide-pci-kill-EOL drivers/ide/pci/opti621.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/opti621.h~ide-pci-kill-EOL	2003-10-08 00:54:32.749701040 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/opti621.h	2003-10-08 00:54:32.799693440 +0200
@@ -29,9 +29,7 @@ static ide_pci_device_t opti621_chipsets
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* OPTI621_H */
diff -puN drivers/ide/pci/pdc202xx_new.h~ide-pci-kill-EOL drivers/ide/pci/pdc202xx_new.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_new.h~ide-pci-kill-EOL	2003-10-08 00:54:32.752700584 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_new.h	2003-10-08 00:54:32.799693440 +0200
@@ -265,9 +265,7 @@ static ide_pci_device_t pdcnew_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= OFF_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* PDC202XX_H */
diff -puN drivers/ide/pci/pdc202xx_old.h~ide-pci-kill-EOL drivers/ide/pci/pdc202xx_old.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/pdc202xx_old.h~ide-pci-kill-EOL	2003-10-08 00:54:32.755700128 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/pdc202xx_old.h	2003-10-08 00:54:32.800693288 +0200
@@ -300,9 +300,7 @@ static ide_pci_device_t pdc202xx_chipset
 #endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* PDC202XX_H */
diff -puN drivers/ide/pci/piix.h~ide-pci-kill-EOL drivers/ide/pci/piix.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/piix.h~ide-pci-kill-EOL	2003-10-08 00:54:32.758699672 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/piix.h	2003-10-08 00:54:32.801693136 +0200
@@ -244,9 +244,7 @@ static ide_pci_device_t piix_pci_info[] 
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* PIIX_H */
diff -puN drivers/ide/pci/rz1000.h~ide-pci-kill-EOL drivers/ide/pci/rz1000.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/rz1000.h~ide-pci-kill-EOL	2003-10-08 00:54:32.761699216 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/rz1000.h	2003-10-08 00:54:32.801693136 +0200
@@ -24,9 +24,7 @@ static ide_pci_device_t rz1000_chipsets[
 		.channels	= 2,
 		.autodma	= NODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* RZ100X_H */
diff -puN drivers/ide/pci/sc1200.h~ide-pci-kill-EOL drivers/ide/pci/sc1200.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sc1200.h~ide-pci-kill-EOL	2003-10-08 00:54:32.764698760 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sc1200.h	2003-10-08 00:54:32.802692984 +0200
@@ -37,9 +37,7 @@ static ide_pci_device_t sc1200_chipsets[
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* SC1200_H */
diff -puN drivers/ide/pci/serverworks.h~ide-pci-kill-EOL drivers/ide/pci/serverworks.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/serverworks.h~ide-pci-kill-EOL	2003-10-08 00:54:32.766698456 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/serverworks.h	2003-10-08 00:54:32.802692984 +0200
@@ -90,9 +90,7 @@ static ide_pci_device_t serverworks_chip
 		.channels	= 1,	/* 2 */
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* SERVERWORKS_H */
diff -puN drivers/ide/pci/siimage.h~ide-pci-kill-EOL drivers/ide/pci/siimage.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/siimage.h~ide-pci-kill-EOL	2003-10-08 00:54:32.769698000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/siimage.h	2003-10-08 00:54:32.802692984 +0200
@@ -75,9 +75,7 @@ static ide_pci_device_t siimage_chipsets
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* SIIMAGE_H */
diff -puN drivers/ide/pci/sis5513.h~ide-pci-kill-EOL drivers/ide/pci/sis5513.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sis5513.h~ide-pci-kill-EOL	2003-10-08 00:54:32.772697544 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sis5513.h	2003-10-08 00:54:32.803692832 +0200
@@ -38,9 +38,7 @@ static ide_pci_device_t sis5513_chipsets
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x4a,0x02,0x02}, {0x4a,0x04,0x04}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* SIS5513_H */
diff -puN drivers/ide/pci/sl82c105.h~ide-pci-kill-EOL drivers/ide/pci/sl82c105.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sl82c105.h~ide-pci-kill-EOL	2003-10-08 00:54:32.775697088 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sl82c105.h	2003-10-08 00:54:32.803692832 +0200
@@ -21,9 +21,7 @@ static ide_pci_device_t sl82c105_chipset
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x01,0x01}, {0x40,0x10,0x10}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* W82C105_H */
diff -puN drivers/ide/pci/slc90e66.h~ide-pci-kill-EOL drivers/ide/pci/slc90e66.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/slc90e66.h~ide-pci-kill-EOL	2003-10-08 00:54:32.778696632 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/slc90e66.h	2003-10-08 00:54:32.803692832 +0200
@@ -40,9 +40,7 @@ static ide_pci_device_t slc90e66_chipset
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* SLC90E66_H */
diff -puN drivers/ide/pci/triflex.h~ide-pci-kill-EOL drivers/ide/pci/triflex.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/triflex.h~ide-pci-kill-EOL	2003-10-08 00:54:32.782696024 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/triflex.h	2003-10-08 00:54:32.804692680 +0200
@@ -27,9 +27,7 @@ static ide_pci_device_t triflex_devices[
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x80, 0x01, 0x01}, {0x80, 0x02, 0x02}},
 		.bootable	= ON_BOARD,
-	},{	
-		.bootable	= EOL,
-	}
+	},
 };
 
 #ifdef CONFIG_PROC_FS
diff -puN drivers/ide/pci/trm290.h~ide-pci-kill-EOL drivers/ide/pci/trm290.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/trm290.h~ide-pci-kill-EOL	2003-10-08 00:54:32.785695568 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/trm290.h	2003-10-08 00:54:32.804692680 +0200
@@ -16,9 +16,7 @@ static ide_pci_device_t trm290_chipsets[
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* TRM290_H */
diff -puN drivers/ide/pci/via82cxxx.h~ide-pci-kill-EOL drivers/ide/pci/via82cxxx.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/via82cxxx.h~ide-pci-kill-EOL	2003-10-08 00:54:32.787695264 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/via82cxxx.h	2003-10-08 00:54:32.805692528 +0200
@@ -48,9 +48,7 @@ static ide_pci_device_t via82cxxx_chipse
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x40,0x02,0x02}, {0x40,0x01,0x01}},
 		.bootable	= ON_BOARD,
-	},{
-		.bootable	= EOL,
-	}
+	},
 };
 
 #endif /* VIA82CXXX_H */
diff -puN include/linux/ide.h~ide-pci-kill-EOL include/linux/ide.h
--- linux-2.6.0-test6-bk2/include/linux/ide.h~ide-pci-kill-EOL	2003-10-08 00:54:32.791694656 +0200
+++ linux-2.6.0-test6-bk2-root/include/linux/ide.h	2003-10-08 00:54:32.806692376 +0200
@@ -1660,7 +1660,6 @@ void ide_pci_register_host_proc(ide_pci_
 #define NODMA 0
 #define NOAUTODMA 1
 #define AUTODMA 2
-#define EOL 255
 
 typedef struct ide_pci_enablebit_s {
 	u8	reg;	/* byte pci reg holding the enable-bit */

_

