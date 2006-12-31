Return-Path: <linux-kernel-owner+w=401wt.eu-S932439AbWLaBGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWLaBGL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 20:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWLaBFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 20:05:50 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:45810 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932521AbWLaBFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 20:05:32 -0500
Message-id: <28323206623255710283@wsc.cz>
In-reply-to: <152402571305932932@wsc.cz>
Subject: [PATCH 8/8] Char: moxa, eliminate typedefs
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sun, 31 Dec 2006 02:05:31 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moxa, eliminate typedefs

Do not use typedefs, use directly struct <something> instead.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 5eb77a193f47ab2a0ed35c7f949f103e740b24dc
tree a815e0033c9707e5df2ebee36c9acf32cf7cf6f8
parent 5b7f53b3500ebd3aa2cc25bb68fdcd88af3643c0
author Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:59:54 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sun, 31 Dec 2006 01:59:54 +0059

 drivers/char/moxa.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
index a0eb088..42de5bf 100644
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -94,32 +94,32 @@ static struct pci_device_id moxa_pcibrds[] = {
 MODULE_DEVICE_TABLE(pci, moxa_pcibrds);
 #endif /* CONFIG_PCI */
 
-typedef struct _moxa_isa_board_conf {
+struct moxa_isa_board_conf {
 	int boardType;
 	int numPorts;
 	unsigned long baseAddr;
-} moxa_isa_board_conf;
+};
 
-static moxa_isa_board_conf moxa_isa_boards[] =
+static struct moxa_isa_board_conf moxa_isa_boards[] =
 {
 /*       {MOXA_BOARD_C218_ISA,8,0xDC000}, */
 };
 
-typedef struct _moxa_pci_devinfo {
+struct moxa_pci_devinfo {
 	ushort busNum;
 	ushort devNum;
 	struct pci_dev *pdev;
-} moxa_pci_devinfo;
+};
 
-typedef struct _moxa_board_conf {
+struct moxa_board_conf {
 	int boardType;
 	int numPorts;
 	unsigned long baseAddr;
 	int busType;
-	moxa_pci_devinfo pciInfo;
-} moxa_board_conf;
+	struct moxa_pci_devinfo pciInfo;
+};
 
-static moxa_board_conf moxa_boards[MAX_BOARDS];
+static struct moxa_board_conf moxa_boards[MAX_BOARDS];
 static void __iomem *moxaBaseAddr[MAX_BOARDS];
 static int loadstat[MAX_BOARDS];
 
@@ -273,7 +273,8 @@ static struct timer_list moxaEmptyTimer[MAX_PORTS];
 static DEFINE_SPINLOCK(moxa_lock);
 
 #ifdef CONFIG_PCI
-static int moxa_get_PCI_conf(struct pci_dev *p, int board_type, moxa_board_conf * board)
+static int moxa_get_PCI_conf(struct pci_dev *p, int board_type,
+		struct moxa_board_conf *board)
 {
 	board->baseAddr = pci_resource_start (p, 2);
 	board->boardType = board_type;
@@ -1369,7 +1370,6 @@ struct mon_str {
 	int rxcnt[MAX_PORTS];
 	int txcnt[MAX_PORTS];
 };
-typedef struct mon_str mon_st;
 
 #define 	DCD_changed	0x01
 #define 	DCD_oldstate	0x80
@@ -1386,7 +1386,7 @@ static char moxaDCDState[MAX_PORTS];
 static char moxaLowChkFlag[MAX_PORTS];
 static int moxaLowWaterChk;
 static int moxaCard;
-static mon_st moxaLog;
+static struct mon_str moxaLog;
 static int moxaFuncTout = HZ / 2;
 static ushort moxaBreakCnt[MAX_PORTS];
 
@@ -1485,7 +1485,8 @@ int MoxaDriverIoctl(unsigned int cmd, unsigned long arg, int port)
 	}
 	switch (cmd) {
 	case MOXA_GET_CONF:
-		if(copy_to_user(argp, &moxa_boards, MAX_BOARDS * sizeof(moxa_board_conf)))
+		if(copy_to_user(argp, &moxa_boards, MAX_BOARDS *
+				sizeof(struct moxa_board_conf)))
 			return -EFAULT;
 		return (0);
 	case MOXA_INIT_DRIVER:
@@ -1494,7 +1495,7 @@ int MoxaDriverIoctl(unsigned int cmd, unsigned long arg, int port)
 		return (0);
 	case MOXA_GETDATACOUNT:
 		moxaLog.tick = jiffies;
-		if(copy_to_user(argp, &moxaLog, sizeof(mon_st)))
+		if(copy_to_user(argp, &moxaLog, sizeof(struct mon_str)))
 			return -EFAULT;
 		return (0);
 	case MOXA_FLUSH_QUEUE:
