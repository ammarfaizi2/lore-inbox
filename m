Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132763AbQLHVFv>; Fri, 8 Dec 2000 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132819AbQLHVFl>; Fri, 8 Dec 2000 16:05:41 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:54637
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132763AbQLHVFd>; Fri, 8 Dec 2000 16:05:33 -0500
Date: Fri, 8 Dec 2000 21:34:56 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: support@moxa.com.tw
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warnings from drivers/char/moxa.c
Message-ID: <20001208213456.F599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes some 'defined but not used' warnings go away
when compiling drivers/char/moxa.c without CONFIG_PCI (240t12p3). It should
apply cleanly.


--- linux-240-t12-pre3-clean/drivers/char/moxa.c	Wed May  3 10:45:18 2000
+++ linux/drivers/char/moxa.c	Wed Nov 29 18:35:01 2000
@@ -111,12 +111,14 @@
 	unsigned short board_type;
 } moxa_pciinfo;
 
+#ifdef CONFIG_PCI
 static moxa_pciinfo moxa_pcibrds[] =
 {
 	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C218, MOXA_BOARD_C218_PCI},
 	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_C320, MOXA_BOARD_C320_PCI},
 	{PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_CP204J, MOXA_BOARD_CP204J},
 };
+#endif
 
 typedef struct _moxa_isa_board_conf {
 	int boardType;
@@ -236,7 +238,10 @@
 /*
  * static functions:
  */
+#ifdef CONFIG_PCI
 static int moxa_get_PCI_conf(struct pci_dev *, int, moxa_board_conf *);
+#endif
+
 static void do_moxa_softint(void *);
 static int moxa_open(struct tty_struct *, struct file *);
 static void moxa_close(struct tty_struct *, struct file *);
@@ -333,7 +338,7 @@
 
 int moxa_init(void)
 {
-	int i, n, numBoards;
+	int i, numBoards;
 	struct moxa_str *ch;
 	int ret1, ret2;
 
@@ -484,6 +489,8 @@
 #ifdef CONFIG_PCI
 	{
 		struct pci_dev *p = NULL;
+		int n;
+
 		n = sizeof(moxa_pcibrds) / sizeof(moxa_pciinfo);
 		i = 0;
 		while (i < n) {
@@ -511,6 +518,7 @@
 	return (0);
 }
 
+#ifdef CONFIG_PCI
 static int moxa_get_PCI_conf(struct pci_dev *p, int board_type, moxa_board_conf * board)
 {
 	board->baseAddr = pci_resource_start (p, 2);
@@ -534,6 +542,7 @@
 
 	return (0);
 }
+#endif
 
 static void do_moxa_softint(void *private_)
 {

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Genius may have its limitations, but stupidity is not thus handicapped. 
  -- Elbert Hubbard 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
