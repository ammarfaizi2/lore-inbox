Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRLOATB>; Fri, 14 Dec 2001 19:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280961AbRLOASv>; Fri, 14 Dec 2001 19:18:51 -0500
Received: from smtpsrv1.isis.unc.edu ([152.2.1.138]:49541 "EHLO
	smtpsrv1.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S280960AbRLOASm>; Fri, 14 Dec 2001 19:18:42 -0500
Date: Fri, 14 Dec 2001 19:18:32 -0500 (EST)
From: "Daniel T. Chen" <crimsun@email.unc.edu>
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br, jgarzik@mandrakesoft.com
Subject: [PATCH] more __devexit cleanups in drivers/net/*
Message-ID: <Pine.A41.4.21L1.0112141911580.40484-100000@login3.isis.unc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some more __devexit cleanups in drivers/net/*
(against .17-rc1)...


diff -uNr /usr/src/linux/drivers/net/dmfe.c /tmpfs/linux/drivers/net/dmfe.c
--- /usr/src/linux/drivers/net/dmfe.c   Fri Nov  9 16:50:01 2001
+++ /tmpfs/linux/drivers/net/dmfe.c     Fri Dec 14 18:08:35 2001
@@ -527,7 +527,7 @@
 }


-static void __exit dmfe_remove_one (struct pci_dev *pdev)
+static void __devexit dmfe_remove_one (struct pci_dev *pdev)
 {
        struct net_device *dev = pci_get_drvdata(pdev);
        struct dmfe_board_info *db = dev->priv;
@@ -2059,7 +2059,7 @@
        name:           "dmfe",
        id_table:       dmfe_pci_tbl,
        probe:          dmfe_init_one,
-       remove:         dmfe_remove_one,
+       remove:         __devexit_p(dmfe_remove_one),
 };

 MODULE_AUTHOR("Sten Wang, sten_wang@davicom.com.tw");
diff -uNr /usr/src/linux/drivers/net/hamachi.c /tmpfs/linux/drivers/net/hamachi.c
--- /usr/src/linux/drivers/net/hamachi.c        Tue Oct  9 18:13:03 2001
+++ /tmpfs/linux/drivers/net/hamachi.c  Fri Dec 14 18:10:12 2001
@@ -1981,7 +1981,7 @@
 }


-static void __exit hamachi_remove_one (struct pci_dev *pdev)
+static void __devexit hamachi_remove_one (struct pci_dev *pdev)
 {
        struct net_device *dev = pci_get_drvdata(pdev);

@@ -2011,7 +2011,7 @@
        name:           DRV_NAME,
        id_table:       hamachi_pci_tbl,
        probe:          hamachi_init_one,
-       remove:         hamachi_remove_one,
+       remove:         __devexit_p(hamachi_remove_one),
 };

 static int __init hamachi_init (void)
diff -uNr /usr/src/linux/drivers/net/tokenring/abyss.c /tmpfs/linux/drivers/net/tokenring/abyss.c
--- /usr/src/linux/drivers/net/tokenring/abyss.c        Thu Sep 13 19:04:43 2001
+++ /tmpfs/linux/drivers/net/tokenring/abyss.c  Fri Dec 14 18:33:22 2001
@@ -433,7 +433,7 @@
        return 0;
 }

-static void __exit abyss_detach (struct pci_dev *pdev)
+static void __devexit abyss_detach (struct pci_dev *pdev)
 {
        struct net_device *dev = pci_get_drvdata(pdev);

@@ -451,7 +451,7 @@
        name:           "abyss",
        id_table:       abyss_pci_tbl,
        probe:          abyss_attach,
-       remove:         abyss_detach,
+       remove:         __devexit_p(abyss_detach),
 };

 static int __init abyss_init (void)
diff -uNr /usr/src/linux/drivers/net/tokenring/tmspci.c /tmpfs/linux/drivers/net/tokenring/tmspci.c
--- /usr/src/linux/drivers/net/tokenring/tmspci.c       Thu Sep 13 19:04:43 2001
+++ /tmpfs/linux/drivers/net/tokenring/tmspci.c Fri Dec 14 18:34:07 2001
@@ -220,7 +220,7 @@
        return val;
 }

-static void __exit tms_pci_detach (struct pci_dev *pdev)
+static void __devexit tms_pci_detach (struct pci_dev *pdev)
 {
        struct net_device *dev = pci_get_drvdata(pdev);

@@ -238,7 +238,7 @@
        name:           "tmspci",
        id_table:       tmspci_pci_tbl,
        probe:          tms_pci_attach,
-       remove:         tms_pci_detach,
+       remove:         __devexit_p(tms_pci_detach),
 };

 static int __init tms_pci_init (void)

