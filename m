Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132692AbQLHVIM>; Fri, 8 Dec 2000 16:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbQLHVIC>; Fri, 8 Dec 2000 16:08:02 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:55149
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132692AbQLHVHr>; Fri, 8 Dec 2000 16:07:47 -0500
Date: Fri, 8 Dec 2000 21:37:15 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: support@moxa.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/char/mxser.c
Message-ID: <20001208213715.G599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes some 'defined but not used' warnings go
away when compiling drivers/char/mxser.c without CONFIG_PCI (240t12p3).
It should apply cleanly.


--- linux-240-t12-pre3-clean/drivers/char/mxser.c	Wed Nov 22 22:41:39 2000
+++ linux/drivers/char/mxser.c	Wed Nov 29 18:43:46 2000
@@ -164,11 +164,13 @@
 	unsigned short board_type;
 } mxser_pciinfo;
 
+#ifdef CONFIG_PCI
 static mxser_pciinfo mxser_pcibrds[] =
 {
 	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C168, MXSER_BOARD_C168_PCI},
 	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C104, MXSER_BOARD_C104_PCI},
 };
+#endif
 
 static int ioaddr[MXSER_BOARDS];
 static int ttymajor = MXSERMAJOR;
@@ -296,10 +298,13 @@
 void cleanup_module(void);
 #endif
 
+#ifdef CONFIG_PCI
+static int mxser_get_PCI_conf(struct pci_dev *, int, struct mxser_hwconf *);
+#endif
+
 static void mxser_getcfg(int board, struct mxser_hwconf *hwconf);
 int mxser_init(void);
 static int mxser_get_ISA_conf(int, struct mxser_hwconf *);
-static int mxser_get_PCI_conf(struct pci_dev *, int, struct mxser_hwconf *);
 static void mxser_do_softint(void *);
 static int mxser_open(struct tty_struct *, struct file *);
 static void mxser_close(struct tty_struct *, struct file *);
@@ -449,6 +454,7 @@
 	mxsercfg[board] = *hwconf;
 }
 
+#ifdef CONFIG_PCI
 static int mxser_get_PCI_conf(struct pci_dev *pdev, int board_type, struct mxser_hwconf *hwconf)
 {
 	int i;
@@ -473,11 +479,11 @@
 	}
 	return (0);
 }
+#endif
 
 int mxser_init(void)
 {
 	int i, m, retval, b;
-	int n, index;
 	int ret1, ret2;
 	struct mxser_hwconf hwconf;
 
@@ -609,6 +615,7 @@
 #ifdef CONFIG_PCI
 	{
 		struct pci_dev *pdev = NULL;
+		int n, index;
 
 		n = sizeof(mxser_pcibrds) / sizeof(mxser_pciinfo);
 		index = 0;

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

You don't become a failure until you're satisfied with being one. 
  -- Anonymous
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
