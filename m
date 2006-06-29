Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751731AbWF2Ep6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWF2Ep6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 00:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWF2Ep5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 00:45:57 -0400
Received: from xenotime.net ([66.160.160.81]:47027 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932190AbWF2Ep4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 00:45:56 -0400
Date: Wed, 28 Jun 2006 21:48:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH 2/2] MTD: kernel-doc fixes + additions
Message-Id: <20060628214838.606bb18a.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix some kernel-doc typos/spellos.
Use kernel-doc syntax in places where it was almost used.
Correct/add struct, struct field, and function param names where needed.


Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/mtdnand.tmpl |    7 +--
 include/linux/mtd/bbm.h            |   35 +++++++++-------
 include/linux/mtd/mtd.h            |    4 -
 include/linux/mtd/nand.h           |    3 -
 include/linux/mtd/onenand.h        |   77 +++++++++++++++++++++----------------
 include/mtd/mtd-abi.h              |    2 
 6 files changed, 69 insertions(+), 59 deletions(-)

--- linux-2617-g13.orig/Documentation/DocBook/mtdnand.tmpl
+++ linux-2617-g13/Documentation/DocBook/mtdnand.tmpl
@@ -109,7 +109,7 @@
 		for most of the implementations. These functions can be replaced by the
 		board driver if neccecary. Those functions are called via pointers in the
 		NAND chip description structure. The board driver can set the functions which
-		should be replaced by board dependend functions before calling nand_scan().
+		should be replaced by board dependent functions before calling nand_scan().
 		If the function pointer is NULL on entry to nand_scan() then the pointer
 		is set to the default function which is suitable for the detected chip type.
 		</para></listitem>
@@ -133,7 +133,7 @@
 	  	[REPLACEABLE]</para><para>
 		Replaceable members hold hardware related functions which can be 
 		provided by the board driver. The board driver can set the functions which
-		should be replaced by board dependend functions before calling nand_scan().
+		should be replaced by board dependent functions before calling nand_scan().
 		If the function pointer is NULL on entry to nand_scan() then the pointer
 		is set to the default function which is suitable for the detected chip type.
 		</para></listitem>
@@ -156,9 +156,8 @@
      	<title>Basic board driver</title>
 	<para>
 		For most boards it will be sufficient to provide just the
-		basic functions and fill out some really board dependend
+		basic functions and fill out some really board dependent
 		members in the nand chip description structure.
-		See drivers/mtd/nand/skeleton for reference.
 	</para>
 	<sect1>
 		<title>Basic defines</title>
--- linux-2617-g13.orig/include/mtd/mtd-abi.h
+++ linux-2617-g13/include/mtd/mtd-abi.h
@@ -133,7 +133,7 @@ struct nand_ecclayout {
 };
 
 /**
- * struct mtd_ecc_stats - error correction status
+ * struct mtd_ecc_stats - error correction stats
  *
  * @corrected:	number of corrected bits
  * @failed:	number of uncorrectable errors
--- linux-2617-g13.orig/include/linux/mtd/bbm.h
+++ linux-2617-g13/include/linux/mtd/bbm.h
@@ -19,21 +19,21 @@
 
 /**
  * struct nand_bbt_descr - bad block table descriptor
- * @param options	options for this descriptor
- * @param pages		the page(s) where we find the bbt, used with
+ * @options:		options for this descriptor
+ * @pages:		the page(s) where we find the bbt, used with
  * 			option BBT_ABSPAGE when bbt is searched,
  * 			then we store the found bbts pages here.
  *			Its an array and supports up to 8 chips now
- * @param offs		offset of the pattern in the oob area of the page
- * @param veroffs	offset of the bbt version counter in the oob are of the page
- * @param version	version read from the bbt page during scan
- * @param len		length of the pattern, if 0 no pattern check is performed
- * @param maxblocks	maximum number of blocks to search for a bbt. This number of
- *			blocks is reserved at the end of the device
+ * @offs:		offset of the pattern in the oob area of the page
+ * @veroffs:		offset of the bbt version counter in the oob area of the page
+ * @version:		version read from the bbt page during scan
+ * @len:		length of the pattern, if 0 no pattern check is performed
+ * @maxblocks:		maximum number of blocks to search for a bbt. This
+ *			number of blocks is reserved at the end of the device
  *			where the tables are written.
- * @param reserved_block_code	if non-0, this pattern denotes a reserved
+ * @reserved_block_code: if non-0, this pattern denotes a reserved
  *			(rather than bad) block in the stored bbt
- * @param pattern	pattern to identify bad block table or factory marked
+ * @pattern:		pattern to identify bad block table or factory marked
  *			good / bad blocks, can be NULL, if len = 0
  *
  * Descriptor for the bad block table marker and the descriptor for the
@@ -93,12 +93,15 @@ struct nand_bbt_descr {
 #define ONENAND_BADBLOCK_POS	0
 
 /**
- * struct bbt_info - [GENERIC] Bad Block Table data structure
- * @param bbt_erase_shift	[INTERN] number of address bits in a bbt entry
- * @param badblockpos		[INTERN] position of the bad block marker in the oob area
- * @param bbt			[INTERN] bad block table pointer
- * @param badblock_pattern	[REPLACEABLE] bad block scan pattern used for initial bad block scan
- * @param priv			[OPTIONAL] pointer to private bbm date
+ * struct bbm_info - [GENERIC] Bad Block Table data structure
+ * @bbt_erase_shift:	[INTERN] number of address bits in a bbt entry
+ * @badblockpos:	[INTERN] position of the bad block marker in the oob area
+ * @options:		options for this descriptor
+ * @bbt:		[INTERN] bad block table pointer
+ * @isbad_bbt:		function to determine if a block is bad
+ * @badblock_pattern:	[REPLACEABLE] bad block scan pattern used for
+ *			initial bad block scan
+ * @priv:		[OPTIONAL] pointer to private bbm date
  */
 struct bbm_info {
 	int bbt_erase_shift;
--- linux-2617-g13.orig/include/linux/mtd/mtd.h
+++ linux-2617-g13/include/linux/mtd/mtd.h
@@ -77,11 +77,11 @@ typedef enum {
  *
  * @len:	number of bytes to write/read. When a data buffer is given
  *		(datbuf != NULL) this is the number of data bytes. When
- +		no data buffer is available this is the number of oob bytes.
+ *		no data buffer is available this is the number of oob bytes.
  *
  * @retlen:	number of bytes written/read. When a data buffer is given
  *		(datbuf != NULL) this is the number of data bytes. When
- +		no data buffer is available this is the number of oob bytes.
+ *		no data buffer is available this is the number of oob bytes.
  *
  * @ooblen:	number of oob bytes per page
  * @ooboffs:	offset of oob data in the oob area (only relevant when
--- linux-2617-g13.orig/include/linux/mtd/nand.h
+++ linux-2617-g13/include/linux/mtd/nand.h
@@ -407,7 +407,6 @@ struct nand_chip {
 
 /**
  * struct nand_flash_dev - NAND Flash Device ID Structure
- *
  * @name:	Identify the device type
  * @id:		device ID code
  * @pagesize:	Pagesize in bytes. Either 256 or 512 or 0
@@ -526,7 +525,6 @@ extern int nand_do_read(struct mtd_info 
 
 /**
  * struct platform_nand_chip - chip level device structure
- *
  * @nr_chips:		max. number of chips to scan for
  * @chip_offset:	chip number offset
  * @nr_partitions:	number of partitions pointed to by partitions (or zero)
@@ -549,7 +547,6 @@ struct platform_nand_chip {
 
 /**
  * struct platform_nand_ctrl - controller level device structure
- *
  * @hwcontrol:		platform specific hardware control structure
  * @dev_ready:		platform specific function to read ready/busy pin
  * @select_chip:	platform specific chip select function
--- linux-2617-g13.orig/include/linux/mtd/onenand.h
+++ linux-2617-g13/include/linux/mtd/onenand.h
@@ -23,7 +23,7 @@ extern int onenand_scan(struct mtd_info 
 /* Free resources held by the OneNAND device */
 extern void onenand_release(struct mtd_info *mtd);
 
-/**
+/*
  * onenand_state_t - chip states
  * Enumeration for OneNAND flash chip state
  */
@@ -42,9 +42,9 @@ typedef enum {
 
 /**
  * struct onenand_bufferram - OneNAND BufferRAM Data
- * @param block		block address in BufferRAM
- * @param page		page address in BufferRAM
- * @param valid		valid flag
+ * @block:		block address in BufferRAM
+ * @page:		page address in BufferRAM
+ * @valid:		valid flag
  */
 struct onenand_bufferram {
 	int block;
@@ -54,32 +54,43 @@ struct onenand_bufferram {
 
 /**
  * struct onenand_chip - OneNAND Private Flash Chip Data
- * @param base		[BOARDSPECIFIC] address to access OneNAND
- * @param chipsize	[INTERN] the size of one chip for multichip arrays
- * @param device_id	[INTERN] device ID
- * @param verstion_id	[INTERN] version ID
- * @param options	[BOARDSPECIFIC] various chip options. They can partly be set to inform onenand_scan about
- * @param erase_shift	[INTERN] number of address bits in a block
- * @param page_shift	[INTERN] number of address bits in a page
- * @param ppb_shift	[INTERN] number of address bits in a pages per block
- * @param page_mask	[INTERN] a page per block mask
- * @param bufferam_index	[INTERN] BufferRAM index
- * @param bufferam	[INTERN] BufferRAM info
- * @param readw		[REPLACEABLE] hardware specific function for read short
- * @param writew	[REPLACEABLE] hardware specific function for write short
- * @param command	[REPLACEABLE] hardware specific function for writing commands to the chip
- * @param wait		[REPLACEABLE] hardware specific function for wait on ready
- * @param read_bufferram	[REPLACEABLE] hardware specific function for BufferRAM Area
- * @param write_bufferram	[REPLACEABLE] hardware specific function for BufferRAM Area
- * @param read_word	[REPLACEABLE] hardware specific function for read register of OneNAND
- * @param write_word	[REPLACEABLE] hardware specific function for write register of OneNAND
- * @param scan_bbt	[REPLACEALBE] hardware specific function for scaning Bad block Table
- * @param chip_lock	[INTERN] spinlock used to protect access to this structure and the chip
- * @param wq		[INTERN] wait queue to sleep on if a OneNAND operation is in progress
- * @param state		[INTERN] the current state of the OneNAND device
- * @param ecclayout	[REPLACEABLE] the default ecc placement scheme
- * @param bbm		[REPLACEABLE] pointer to Bad Block Management
- * @param priv		[OPTIONAL] pointer to private chip date
+ * @base:		[BOARDSPECIFIC] address to access OneNAND
+ * @chipsize:		[INTERN] the size of one chip for multichip arrays
+ * @device_id:		[INTERN] device ID
+ * @density_mask:	chip density, used for DDP devices
+ * @verstion_id:	[INTERN] version ID
+ * @options:		[BOARDSPECIFIC] various chip options. They can
+ *			partly be set to inform onenand_scan about
+ * @erase_shift:	[INTERN] number of address bits in a block
+ * @page_shift:		[INTERN] number of address bits in a page
+ * @ppb_shift:		[INTERN] number of address bits in a pages per block
+ * @page_mask:		[INTERN] a page per block mask
+ * @bufferram_index:	[INTERN] BufferRAM index
+ * @bufferram:		[INTERN] BufferRAM info
+ * @readw:		[REPLACEABLE] hardware specific function for read short
+ * @writew:		[REPLACEABLE] hardware specific function for write short
+ * @command:		[REPLACEABLE] hardware specific function for writing
+ *			commands to the chip
+ * @wait:		[REPLACEABLE] hardware specific function for wait on ready
+ * @read_bufferram:	[REPLACEABLE] hardware specific function for BufferRAM Area
+ * @write_bufferram:	[REPLACEABLE] hardware specific function for BufferRAM Area
+ * @read_word:		[REPLACEABLE] hardware specific function for read
+ *			register of OneNAND
+ * @write_word:		[REPLACEABLE] hardware specific function for write
+ *			register of OneNAND
+ * @mmcontrol:		sync burst read function
+ * @block_markbad:	function to mark a block as bad
+ * @scan_bbt:		[REPLACEALBE] hardware specific function for scanning
+ *			Bad block Table
+ * @chip_lock:		[INTERN] spinlock used to protect access to this
+ *			structure and the chip
+ * @wq:			[INTERN] wait queue to sleep on if a OneNAND
+ *			operation is in progress
+ * @state:		[INTERN] the current state of the OneNAND device
+ * @page_buf:		data buffer
+ * @ecclayout:		[REPLACEABLE] the default ecc placement scheme
+ * @bbm:		[REPLACEABLE] pointer to Bad Block Management
+ * @priv:		[OPTIONAL] pointer to private chip date
  */
 struct onenand_chip {
 	void __iomem		*base;
@@ -147,9 +158,9 @@ struct onenand_chip {
 #define ONENAND_MFR_SAMSUNG	0xec
 
 /**
- * struct nand_manufacturers - NAND Flash Manufacturer ID Structure
- * @param name:		Manufacturer name
- * @param id:		manufacturer ID code of device.
+ * struct onenand_manufacturers - NAND Flash Manufacturer ID Structure
+ * @name:	Manufacturer name
+ * @id:		manufacturer ID code of device.
 */
 struct onenand_manufacturers {
         int id;


---
