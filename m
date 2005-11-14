Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVKNBiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKNBiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVKNBiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:38:08 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:51118 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVKNBiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:38:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=CC6j1Z811Jyd8kM10InNhBLaSy6AWMzzhvm2uzl+AXE9F1yncQdFw7/MrpwOa7Se3BIFVwcarHWtuPjnVRHzmfu0ujlip6OBRByUAw+PvHyY/WRuamRrrH0gwyRm3+9x59gCxmDeb7M2Z3GtVAkMnIUARF0j2G2XWW4mC7siKhU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Trivial; turn "const static" into "static const"
Date: Mon, 14 Nov 2005 02:42:26 +0100
User-Agent: KMail/1.8.92
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200511140242.26322.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very trivial patch below.

ICC likes to complain about storage class not being first, GCC doesn't
care much (except for cases like "inline static"), but since changing
"const static" to "static const" doesn't change generated code and since
it shuts up ICC (and in case GCC decides to warn about it in the future
we've preemptively killed those warnings as well) here's a patch to
change all instances of "const static" to "static const" in 2.6.15-rc1.

Doesn't do much good (but a little) but also does no harm, so why not???

I must admit that I've not really given this patch much testing since I 
have a hard time seeing how it could break anything.

Thanks to Gabriel A. Devenyi for pointing out 
http://linuxicc.sourceforge.net/ which is what made me create this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
--- 

 arch/arm/plat-omap/dma.c                   |    2 +-
 arch/h8300/kernel/gpio.c                   |    4 ++--
 arch/h8300/platform/h8300h/ptrace_h8300h.c |   12 ++++++------
 arch/h8300/platform/h8s/ints.c             |    4 ++--
 arch/h8300/platform/h8s/ints_h8s.c         |    4 ++--
 drivers/ide/pci/pdc202xx_new.c             |    2 +-
 drivers/mtd/nand/au1550nd.c                |    2 +-
 drivers/mtd/nand/rtc_from4.c               |    2 +-
 drivers/mtd/nand/spia.c                    |    2 +-
 drivers/net/8139too.c                      |    2 +-
 drivers/net/pci-skeleton.c                 |    2 +-
 drivers/net/r8169.c                        |    2 +-
 drivers/net/sis190.c                       |    2 +-
 drivers/usb/atm/speedtch.c                 |    4 ++--
 drivers/usb/image/microtek.c               |    2 +-
 fs/cifs/cifs_uniupr.h                      |    2 +-
 16 files changed, 25 insertions(+), 25 deletions(-)

--- linux-2.6.15-rc1-orig/arch/arm/plat-omap/dma.c	2005-11-12 
18:07:13.000000000 +0100
+++ linux-2.6.15-rc1/arch/arm/plat-omap/dma.c	2005-11-14 02:22:09.000000000 
+0100
@@ -64,7 +64,7 @@ static int dma_chan_count;
 static spinlock_t dma_chan_lock;
 static struct omap_dma_lch dma_chan[OMAP_LOGICAL_DMA_CH_COUNT];
 
-const static u8 omap1_dma_irq[OMAP_LOGICAL_DMA_CH_COUNT] = {
+static const u8 omap1_dma_irq[OMAP_LOGICAL_DMA_CH_COUNT] = {
 	INT_DMA_CH0_6, INT_DMA_CH1_7, INT_DMA_CH2_8, INT_DMA_CH3,
 	INT_DMA_CH4, INT_DMA_CH5, INT_1610_DMA_CH6, INT_1610_DMA_CH7,
 	INT_1610_DMA_CH8, INT_1610_DMA_CH9, INT_1610_DMA_CH10,
--- linux-2.6.15-rc1-orig/arch/h8300/kernel/gpio.c	2005-08-29 
01:41:01.000000000 +0200
+++ linux-2.6.15-rc1/arch/h8300/kernel/gpio.c	2005-11-14 02:22:34.000000000 
+0100
@@ -122,7 +122,7 @@ int h8300_get_gpio_dir(int port_bit)
 static char *port_status(int portno)
 {
 	static char result[10];
-	const static char io[2]={'I','O'};
+	static const char io[2]={'I','O'};
 	char *rp;
 	int c;
 	unsigned char used,ddr;
@@ -143,7 +143,7 @@ static int gpio_proc_read(char *buf, cha
                           int len, int *unused_i, void *unused_v)
 {
 	int c,outlen;
-	const static char port_name[]="123456789ABCDEFGH";
+	static const char port_name[]="123456789ABCDEFGH";
 	outlen = 0;
 	for (c = 0; c < MAX_PORT; c++) {
 		if (ddrs[c] == NULL)
--- linux-2.6.15-rc1-orig/arch/h8300/platform/h8300h/ptrace_h8300h.c	
2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.15-rc1/arch/h8300/platform/h8300h/ptrace_h8300h.c	2005-11-14 
02:24:14.000000000 +0100
@@ -98,7 +98,7 @@ struct optable {
 		.type       = jmp, \
 	}
 
-const static struct optable optable_0[] = {
+static const struct optable optable_0[] = {
 	OPTABLE(0x00,0xff, 1,none), /* 0x00 */
 	OPTABLE(0x01,0xff,-1,none), /* 0x01 */
 	OPTABLE(0x02,0xfe, 1,none), /* 0x02-0x03 */
@@ -131,31 +131,31 @@ const static struct optable optable_0[] 
 	OPTABLE(0x80,0x80, 1,none), /* 0x80-0xff */
 };
 
-const static struct optable optable_1[] = {
+static const struct optable optable_1[] = {
 	OPTABLE(0x00,0xff,-3,none), /* 0x0100 */
 	OPTABLE(0x40,0xf0,-3,none), /* 0x0140-0x14f */
 	OPTABLE(0x80,0xf0, 1,none), /* 0x0180-0x018f */
 	OPTABLE(0xc0,0xc0, 2,none), /* 0x01c0-0x01ff */
 };
 
-const static struct optable optable_2[] = {
+static const struct optable optable_2[] = {
 	OPTABLE(0x00,0x20, 2,none), /* 0x6a0?/0x6a8?/0x6b0?/0x6b8? */
 	OPTABLE(0x20,0x20, 3,none), /* 0x6a2?/0x6aa?/0x6b2?/0x6ba? */
 };
 
-const static struct optable optable_3[] = {
+static const struct optable optable_3[] = {
 	OPTABLE(0x69,0xfb, 2,none), /* 0x010069/0x01006d/014069/0x01406d */
 	OPTABLE(0x6b,0xff,-4,none), /* 0x01006b/0x01406b */
 	OPTABLE(0x6f,0xff, 3,none), /* 0x01006f/0x01406f */
 	OPTABLE(0x78,0xff, 5,none), /* 0x010078/0x014078 */
 };
 
-const static struct optable optable_4[] = {
+static const struct optable optable_4[] = {
 	OPTABLE(0x00,0x78, 3,none), /* 
0x0100690?/0x01006d0?/0140690/0x01406d0?/0x0100698?/0x01006d8?/0140698?/0x01406d8? 
*/
 	OPTABLE(0x20,0x78, 4,none), /* 
0x0100692?/0x01006d2?/0140692/0x01406d2?/0x010069a?/0x01006da?/014069a?/0x01406da? 
*/
 };
 
-const static struct optables_list {
+static const struct optables_list {
 	const struct optable *ptr;
 	int size;
 } optables[] = {
--- linux-2.6.15-rc1-orig/arch/h8300/platform/h8s/ints.c	2005-08-29 
01:41:01.000000000 +0200
+++ linux-2.6.15-rc1/arch/h8300/platform/h8s/ints.c	2005-11-14 
02:23:08.000000000 +0100
@@ -52,7 +52,7 @@ struct irq_pins {
 	unsigned char bit_no;
 };
 /* ISTR = 0 */
-const static struct irq_pins irq_assign_table0[16]={
+static const struct irq_pins irq_assign_table0[16]={
         {H8300_GPIO_P5,H8300_GPIO_B0},{H8300_GPIO_P5,H8300_GPIO_B1},
 	{H8300_GPIO_P5,H8300_GPIO_B2},{H8300_GPIO_P5,H8300_GPIO_B3},
 	{H8300_GPIO_P5,H8300_GPIO_B4},{H8300_GPIO_P5,H8300_GPIO_B5},
@@ -63,7 +63,7 @@ const static struct irq_pins irq_assign_
 	{H8300_GPIO_PF,H8300_GPIO_B1},{H8300_GPIO_PF,H8300_GPIO_B2},
 };
 /* ISTR = 1 */
-const static struct irq_pins irq_assign_table1[16]={
+static const struct irq_pins irq_assign_table1[16]={
 	{H8300_GPIO_P8,H8300_GPIO_B0},{H8300_GPIO_P8,H8300_GPIO_B1},
 	{H8300_GPIO_P8,H8300_GPIO_B2},{H8300_GPIO_P8,H8300_GPIO_B3},
 	{H8300_GPIO_P8,H8300_GPIO_B4},{H8300_GPIO_P8,H8300_GPIO_B5},
--- linux-2.6.15-rc1-orig/arch/h8300/platform/h8s/ints_h8s.c	2005-08-29 
01:41:01.000000000 +0200
+++ linux-2.6.15-rc1/arch/h8300/platform/h8s/ints_h8s.c	2005-11-14 
02:23:29.000000000 +0100
@@ -42,7 +42,7 @@ struct irq_pins {
 	unsigned char bit_no;
 } __attribute__((aligned(1),packed));
 /* ISTR = 0 */
-const static struct irq_pins irq_assign_table0[16]={
+static const struct irq_pins irq_assign_table0[16]={
         {H8300_GPIO_P5,H8300_GPIO_B0},{H8300_GPIO_P5,H8300_GPIO_B1},
 	{H8300_GPIO_P5,H8300_GPIO_B2},{H8300_GPIO_P5,H8300_GPIO_B3},
 	{H8300_GPIO_P5,H8300_GPIO_B4},{H8300_GPIO_P5,H8300_GPIO_B5},
@@ -53,7 +53,7 @@ const static struct irq_pins irq_assign_
 	{H8300_GPIO_PF,H8300_GPIO_B1},{H8300_GPIO_PF,H8300_GPIO_B2},
 }; 
 /* ISTR = 1 */
-const static struct irq_pins irq_assign_table1[16]={
+static const struct irq_pins irq_assign_table1[16]={
 	{H8300_GPIO_P8,H8300_GPIO_B0},{H8300_GPIO_P8,H8300_GPIO_B1},
 	{H8300_GPIO_P8,H8300_GPIO_B2},{H8300_GPIO_P8,H8300_GPIO_B3},
 	{H8300_GPIO_P8,H8300_GPIO_B4},{H8300_GPIO_P8,H8300_GPIO_B5},
--- linux-2.6.15-rc1-orig/drivers/ide/pci/pdc202xx_new.c	2005-08-29 
01:41:01.000000000 +0200
+++ linux-2.6.15-rc1/drivers/ide/pci/pdc202xx_new.c	2005-11-14 
02:24:33.000000000 +0100
@@ -39,7 +39,7 @@
 
 #define PDC202_DEBUG_CABLE	0
 
-const static char *pdc_quirk_drives[] = {
+static const char *pdc_quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
 	"QUANTUM FIREBALLP KA6.4",
 	"QUANTUM FIREBALLP KA9.1",
--- linux-2.6.15-rc1-orig/drivers/mtd/nand/au1550nd.c	2005-11-12 
18:07:30.000000000 +0100
+++ linux-2.6.15-rc1/drivers/mtd/nand/au1550nd.c	2005-11-14 02:27:28.000000000 
+0100
@@ -43,7 +43,7 @@ static int nand_width = 1; /* default x8
 /*
  * Define partitions for flash device
  */
-const static struct mtd_partition partition_info[] = {
+static const struct mtd_partition partition_info[] = {
 	{
 		.name 	= "NAND FS 0",
 	  	.offset = 0,
--- linux-2.6.15-rc1-orig/drivers/mtd/nand/rtc_from4.c	2005-11-12 
18:07:30.000000000 +0100
+++ linux-2.6.15-rc1/drivers/mtd/nand/rtc_from4.c	2005-11-14 
02:27:02.000000000 +0100
@@ -96,7 +96,7 @@ static struct mtd_info *rtc_from4_mtd = 
  */
 static void __iomem *rtc_from4_fio_base = (void 
*)P2SEGADDR(RTC_FROM4_FIO_BASE);
 
-const static struct mtd_partition partition_info[] = {
+static const struct mtd_partition partition_info[] = {
         {
                 .name   = "Renesas flash partition 1",
                 .offset = 0,
--- linux-2.6.15-rc1-orig/drivers/mtd/nand/spia.c	2005-11-12 
18:07:30.000000000 +0100
+++ linux-2.6.15-rc1/drivers/mtd/nand/spia.c	2005-11-14 02:27:15.000000000 
+0100
@@ -67,7 +67,7 @@ module_param(spia_peddr, int, 0);
 /*
  * Define partitions for flash device
  */
-const static struct mtd_partition partition_info[] = {
+static const struct mtd_partition partition_info[] = {
 	{
 		.name	= "SPIA flash partition 1",
 		.offset	= 0,
--- linux-2.6.15-rc1-orig/drivers/net/8139too.c	2005-11-12 18:07:30.000000000 
+0100
+++ linux-2.6.15-rc1/drivers/net/8139too.c	2005-11-14 02:24:48.000000000 +0100
@@ -505,7 +505,7 @@ enum chip_flags {
 #define HW_REVID_MASK	HW_REVID(1, 1, 1, 1, 1, 1, 1)
 
 /* directly indexed by chip_t, above */
-const static struct {
+static const struct {
 	const char *name;
 	u32 version; /* from RTL8139C/RTL8139D docs */
 	u32 flags;
--- linux-2.6.15-rc1-orig/drivers/net/pci-skeleton.c	2005-11-05 
01:50:36.000000000 +0100
+++ linux-2.6.15-rc1/drivers/net/pci-skeleton.c	2005-11-14 02:26:49.000000000 
+0100
@@ -415,7 +415,7 @@ typedef enum {
 
 
 /* directly indexed by chip_t, above */
-const static struct {
+static const struct {
 	const char *name;
 	u8 version; /* from RTL8139C docs */
 	u32 RxConfigMask; /* should clear the bits supported by this chip */
--- linux-2.6.15-rc1-orig/drivers/net/r8169.c	2005-11-12 18:07:35.000000000 
+0100
+++ linux-2.6.15-rc1/drivers/net/r8169.c	2005-11-14 02:25:18.000000000 +0100
@@ -170,7 +170,7 @@ enum phy_version {
 #define _R(NAME,MAC,MASK) \
 	{ .name = NAME, .mac_version = MAC, .RxConfigMask = MASK }
 
-const static struct {
+static const struct {
 	const char *name;
 	u8 mac_version;
 	u32 RxConfigMask;	/* Clears the bits supported by this chip */
--- linux-2.6.15-rc1-orig/drivers/net/sis190.c	2005-11-12 18:07:35.000000000 
+0100
+++ linux-2.6.15-rc1/drivers/net/sis190.c	2005-11-14 02:25:04.000000000 +0100
@@ -329,7 +329,7 @@ static struct mii_chip_info {
 	{ NULL, }
 };
 
-const static struct {
+static const struct {
 	const char *name;
 } sis_chip_info[] = {
 	{ "SiS 190 PCI Fast Ethernet adapter" },
--- linux-2.6.15-rc1-orig/drivers/usb/atm/speedtch.c	2005-08-29 
01:41:01.000000000 +0200
+++ linux-2.6.15-rc1/drivers/usb/atm/speedtch.c	2005-11-14 02:27:50.000000000 
+0100
@@ -532,9 +532,9 @@ static void speedtch_handle_int(struct u
 	int ret = int_urb->status;
 
 	/* The magic interrupt for "up state" */
-	const static unsigned char up_int[6]   = { 0xa1, 0x00, 0x01, 0x00, 0x00, 
0x00 };
+	static const unsigned char up_int[6]   = { 0xa1, 0x00, 0x01, 0x00, 0x00, 
0x00 };
 	/* The magic interrupt for "down state" */
-	const static unsigned char down_int[6] = { 0xa1, 0x00, 0x00, 0x00, 0x00, 
0x00 };
+	static const unsigned char down_int[6] = { 0xa1, 0x00, 0x00, 0x00, 0x00, 
0x00 };
 
 	atm_dbg(usbatm, "%s entered\n", __func__);
 
--- linux-2.6.15-rc1-orig/drivers/usb/image/microtek.c	2005-11-12 
18:07:43.000000000 +0100
+++ linux-2.6.15-rc1/drivers/usb/image/microtek.c	2005-11-14 
02:28:03.000000000 +0100
@@ -661,7 +661,7 @@ struct vendor_product
 
 
 /* These are taken from the msmUSB.inf file on the Windows driver CD */
-const static struct vendor_product mts_supported_products[] =
+static const struct vendor_product mts_supported_products[] =
 {
 	{ "Phantom 336CX",	mts_sup_unknown},
 	{ "Phantom 336CX",	mts_sup_unknown},
--- linux-2.6.15-rc1-orig/fs/cifs/cifs_uniupr.h	2005-08-29 01:41:01.000000000 
+0200
+++ linux-2.6.15-rc1/fs/cifs/cifs_uniupr.h	2005-11-14 02:28:16.000000000 +0100
@@ -242,7 +242,7 @@ static signed char UniCaseRangeLff20[27]
 /*
  * Lower Case Range
  */
-const static struct UniCaseRange CifsUniLowerRange[] = {
+static const struct UniCaseRange CifsUniLowerRange[] = {
 	0x0380, 0x03ab, UniCaseRangeL0380,
 	0x0400, 0x042f, UniCaseRangeL0400,
 	0x0490, 0x04cb, UniCaseRangeL0490,
