Return-Path: <linux-kernel-owner+w=401wt.eu-S1030248AbXAKKLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbXAKKLM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbXAKKLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:11:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:49153 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030248AbXAKKLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:11:11 -0500
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: support for new board
Date: Thu, 11 Jan 2007 11:01:31 +0100
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701111101.31281.matthias.fuchs@esd-electronics.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:7ee1d245d6d47e4a96dce2c88f0dd45f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
this patch adds support for the CPCI-ASIO4 quad port CompactPCI UART board from
electronic system design gmbh.
I hope this patch does not molder because the serial code is currently an orphan.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>

---
commit 677ea3b4ad7aa9660e0c999c8f9457cb6e6620fb
tree ab54a09258da972b9f69a47e37c43cf44c15e009
parent f3a2c3ee458bd614231e548c13acb0cf33a68631
author Matthias Fuchs <matthias.fuchs@esd-electronics.com> Wed, 10 Jan 2007 08:41:44 +0100
committer Matthias Fuchs <matthias.fuchs@esd-electronics.com> Wed, 10 Jan 2007 08:41:44 +0100

 drivers/serial/8250_pci.c |   11 +++++++++++
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index 52e2e64..5a31ba4 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -936,6 +936,7 @@ enum pci_board_num_t {

        pbn_b2_1_115200,
        pbn_b2_2_115200,
+       pbn_b2_4_115200,
        pbn_b2_8_115200,

        pbn_b2_1_460800,
@@ -1249,6 +1250,12 @@ static struct pciserial_board pci_boards
                .base_baud      = 115200,
                .uart_offset    = 8,
        },
+       [pbn_b2_4_115200] = {
+               .flags          = FL_BASE2,
+               .num_ports      = 4,
+               .base_baud      = 115200,
+               .uart_offset    = 8,
+       },
        [pbn_b2_8_115200] = {
                .flags          = FL_BASE2,
                .num_ports      = 8,
@@ -1990,6 +1997,10 @@ static struct pci_device_id serial_pci_t
        {       PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_DUALMODEM,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                pbn_panacom2 },
+       {       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+               PCI_VENDOR_ID_ESDGMBH,
+               PCI_DEVICE_ID_ESDGMBH_CPCIASIO4, 0, 0,
+               pbn_b2_4_115200 },
        {       PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
                PCI_SUBVENDOR_ID_CHASE_PCIFAST,
                PCI_SUBDEVICE_ID_CHASE_PCIFAST4, 0, 0,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f7a416c..61a7de7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -953,6 +953,7 @@
 #define PCI_DEVICE_ID_PLX_R753         0x1152
 #define PCI_DEVICE_ID_PLX_OLITEC       0x1187
 #define PCI_DEVICE_ID_PLX_PCI200SYN    0x3196
+#define PCI_DEVICE_ID_PLX_9030         0x9030
 #define PCI_DEVICE_ID_PLX_9050         0x9050
 #define PCI_DEVICE_ID_PLX_9080         0x9080
 #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2 0xa001
@@ -1686,6 +1687,8 @@
 #define PCI_VENDOR_ID_ELECTRONICDESIGNGMBH 0x12f8
 #define PCI_DEVICE_ID_LML_33R10                0x8a02

+#define PCI_VENDOR_ID_ESDGMBH           0x12fe
+#define PCI_DEVICE_ID_ESDGMBH_CPCIASIO4        0x0111

 #define PCI_VENDOR_ID_SIIG             0x131f
 #define PCI_SUBVENDOR_ID_SIIG          0x131f
