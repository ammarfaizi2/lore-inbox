Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSGZHZf>; Fri, 26 Jul 2002 03:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSGZHZf>; Fri, 26 Jul 2002 03:25:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:62470 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317309AbSGZHZ0>; Fri, 26 Jul 2002 03:25:26 -0400
Message-ID: <3D40F8F9.1050507@evision.ag>
Date: Fri, 26 Jul 2002 09:23:37 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE 104
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000409030604010609090807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000409030604010609090807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Make the bit-sliced data types in hdreg.h use the bit-slice data types
   instead of the generic ones. This makes clear that those are supposed
   to be register masks.

--------------000409030604010609090807
Content-Type: text/plain;
 name="ide-104.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-104.diff"

diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.28/include/linux/hdreg.h	2002-07-24 23:03:27.000000000 +0200
+++ linux/include/linux/hdreg.h	2002-07-25 23:02:07.000000000 +0200
@@ -261,17 +261,17 @@ struct hd_drive_task_hdr {
 #define SECURITY_DISABLE_PASSWORD	0xBF
 
 struct hd_geometry {
-      unsigned char heads;
-      unsigned char sectors;
-      unsigned short cylinders;
+      u8 heads;
+      u8 sectors;
+      u16 cylinders;
       unsigned long start;
 };
 
 /* BIG GEOMETRY - dying, used only by HDIO_GETGEO_BIG_RAW */
 struct hd_big_geometry {
-	unsigned char heads;
-	unsigned char sectors;
-	unsigned int cylinders;
+	u8 heads;
+	u8 sectors;
+	u32 cylinders;
 	unsigned long start;
 };
 
@@ -326,249 +326,243 @@ enum {
  * ide/probe.c.
  */
 struct hd_driveid {
-	unsigned short	config;		/* lots of obsolete bit flags */
-	unsigned short	cyls;		/* Obsolete, "physical" cyls */
-	unsigned short	reserved2;	/* reserved (word 2) */
-	unsigned short	heads;		/* Obsolete, "physical" heads */
-	unsigned short	track_bytes;	/* unformatted bytes per track */
-	unsigned short	sector_bytes;	/* unformatted bytes per sector */
-	unsigned short	sectors;	/* Obsolete, "physical" sectors per track */
-	unsigned short	vendor0;	/* vendor unique */
-	unsigned short	vendor1;	/* vendor unique */
-	unsigned short	vendor2;	/* Retired vendor unique */
-	unsigned char	serial_no[20];	/* 0 = not_specified */
-	unsigned short	buf_type;	/* Retired */
-	unsigned short	buf_size;	/* Retired, 512 byte increments
-					 * 0 = not_specified
-					 */
-	unsigned short	ecc_bytes;	/* for r/w long cmds; 0 = not_specified */
-	unsigned char	fw_rev[8];	/* 0 = not_specified */
-	unsigned char	model[40];	/* 0 = not_specified */
-	unsigned char	max_multsect;	/* 0=not_implemented */
-	unsigned char	vendor3;	/* vendor unique */
-	unsigned short	dword_io;	/* 0=not_implemented; 1=implemented */
-	unsigned char	vendor4;	/* vendor unique */
-	unsigned char	capability;	/* (upper byte of word 49)
-					 *  3:	IORDYsup
-					 *  2:	IORDYsw
-					 *  1:	LBA
-					 *  0:	DMA
-					 */
-	unsigned short	reserved50;	/* reserved (word 50) */
-	unsigned char	vendor5;	/* Obsolete, vendor unique */
-	unsigned char	tPIO;		/* Obsolete, 0=slow, 1=medium, 2=fast */
-	unsigned char	vendor6;	/* Obsolete, vendor unique */
-	unsigned char	tDMA;		/* Obsolete, 0=slow, 1=medium, 2=fast */
-	unsigned short	field_valid;	/* (word 53)
-					 *  2:	ultra_ok	word  88
-					 *  1:	eide_ok		words 64-70
-					 *  0:	cur_ok		words 54-58
-					 */
-	unsigned short	cur_cyls;	/* Obsolete, logical cylinders */
-	unsigned short	cur_heads;	/* Obsolete, l heads */
-	unsigned short	cur_sectors;	/* Obsolete, l sectors per track */
-	unsigned short	cur_capacity0;	/* Obsolete, l total sectors on drive */
-	unsigned short	cur_capacity1;	/* Obsolete, (2 words, misaligned int)     */
-	unsigned char	multsect;	/* current multiple sector count */
-	unsigned char	multsect_valid;	/* when (bit0==1) multsect is ok */
-	unsigned int	lba_capacity;	/* Obsolete, total number of sectors */
-	unsigned short	dma_1word;	/* Obsolete, single-word dma info */
-	unsigned short	dma_mword;	/* multiple-word dma info */
-	unsigned short  eide_pio_modes; /* bits 0:mode3 1:mode4 */
-	unsigned short  eide_dma_min;	/* min mword dma cycle time (ns) */
-	unsigned short  eide_dma_time;	/* recommended mword dma cycle time (ns) */
-	unsigned short  eide_pio;       /* min cycle time (ns), no IORDY  */
-	unsigned short  eide_pio_iordy; /* min cycle time (ns), with IORDY */
-	unsigned short	words69_70[2];	/* reserved words 69-70
-					 * future command overlap and queuing
-					 */
+	u16	config;		/* lots of obsolete bit flags */
+	u16	cyls;		/* Obsolete, "physical" cyls */
+	u16	reserved2;	/* reserved (word 2) */
+	u16	heads;		/* Obsolete, "physical" heads */
+	u16	track_bytes;	/* unformatted bytes per track */
+	u16	sector_bytes;	/* unformatted bytes per sector */
+	u16	sectors;	/* Obsolete, "physical" sectors per track */
+	u16	vendor0;	/* vendor unique */
+	u16	vendor1;	/* vendor unique */
+	u16	vendor2;	/* Retired vendor unique */
+	u8	serial_no[20];	/* 0 = not_specified */
+	u16	buf_type;	/* Retired */
+	u16	buf_size;	/* Retired, 512 byte increments
+				 * 0 = not_specified
+				 */
+	u16	ecc_bytes;	/* for r/w long cmds; 0 = not_specified */
+	u8	fw_rev[8];	/* 0 = not_specified */
+	char	model[40];	/* 0 = not_specified */
+	u8	max_multsect;	/* 0=not_implemented */
+	u8	vendor3;	/* vendor unique */
+	u16	dword_io;	/* 0=not_implemented; 1=implemented */
+	u8	vendor4;	/* vendor unique */
+	u8	capability;	/* (upper byte of word 49)
+				 *  3:	IORDYsup
+				 *  2:	IORDYsw
+				 *  1:	LBA
+				 *  0:	DMA
+				 */
+	u16	reserved50;	/* reserved (word 50) */
+	u8	vendor5;	/* Obsolete, vendor unique */
+	u8	tPIO;		/* Obsolete, 0=slow, 1=medium, 2=fast */
+	u8	vendor6;	/* Obsolete, vendor unique */
+	u8	tDMA;		/* Obsolete, 0=slow, 1=medium, 2=fast */
+	u16	field_valid;	/* (word 53)
+				 *  2:	ultra_ok	word  88
+				 *  1:	eide_ok		words 64-70
+				 *  0:	cur_ok		words 54-58
+				 */
+	u16	cur_cyls;	/* Obsolete, logical cylinders */
+	u16	cur_heads;	/* Obsolete, l heads */
+	u16	cur_sectors;	/* Obsolete, l sectors per track */
+	u16	cur_capacity0;	/* Obsolete, l total sectors on drive */
+	u16	cur_capacity1;	/* Obsolete, (2 words, misaligned int)     */
+	u8	multsect;	/* current multiple sector count */
+	u8	multsect_valid;	/* when (bit0==1) multsect is ok */
+	u32	lba_capacity;	/* Obsolete, total number of sectors */
+	u16	dma_1word;	/* Obsolete, single-word dma info */
+	u16	dma_mword;	/* multiple-word dma info */
+	u16	eide_pio_modes; /* bits 0:mode3 1:mode4 */
+	u16	eide_dma_min;	/* min mword dma cycle time (ns) */
+	u16	eide_dma_time;	/* recommended mword dma cycle time (ns) */
+	u16	eide_pio;       /* min cycle time (ns), no IORDY  */
+	u16	eide_pio_iordy; /* min cycle time (ns), with IORDY */
+	u16	words69_70[2];	/* reserved words 69-70
+				 * future command overlap and queuing
+				 */
 	/* HDIO_GET_IDENTITY currently returns only words 0 through 70 */
-	unsigned short	words71_74[4];	/* reserved words 71-74
-					 * for IDENTIFY PACKET DEVICE command
-					 */
-	unsigned short  queue_depth;	/* (word 75)
-					 * 15:5	reserved
-					 *  4:0	Maximum queue depth -1
-					 */
-	unsigned short  words76_79[4];	/* reserved words 76-79 */
-	unsigned short  major_rev_num;	/* (word 80) */
-	unsigned short  minor_rev_num;	/* (word 81) */
-	unsigned short  command_set_1;	/* (word 82) supported
-					 * 15:	Obsolete
-					 * 14:	NOP command
-					 * 13:	READ_BUFFER
-					 * 12:	WRITE_BUFFER
-					 * 11:	Obsolete
-					 * 10:	Host Protected Area
-					 *  9:	DEVICE Reset
-					 *  8:	SERVICE Interrupt
-					 *  7:	Release Interrupt
-					 *  6:	look-ahead
-					 *  5:	write cache
-					 *  4:	PACKET Command
-					 *  3:	Power Management Feature Set
-					 *  2:	Removable Feature Set
-					 *  1:	Security Feature Set
-					 *  0:	SMART Feature Set
-					 */
-	unsigned short  command_set_2;	/* (word 83)
-					 * 15:	Shall be ZERO
-					 * 14:	Shall be ONE
-					 * 13:	FLUSH CACHE EXT
-					 * 12:	FLUSH CACHE
-					 * 11:	Device Configuration Overlay
-					 * 10:	48-bit Address Feature Set
-					 *  9:	Automatic Acoustic Management
-					 *  8:	SET MAX security
-					 *  7:	reserved 1407DT PARTIES
-					 *  6:	SetF sub-command Power-Up
-					 *  5:	Power-Up in Standby Feature Set
-					 *  4:	Removable Media Notification
-					 *  3:	APM Feature Set
-					 *  2:	CFA Feature Set
-					 *  1:	READ/WRITE DMA QUEUED
-					 *  0:	Download MicroCode
-					 */
-	unsigned short  cfsse;		/* (word 84)
-					 * cmd set-feature supported extensions
-					 * 15:	Shall be ZERO
-					 * 14:	Shall be ONE
-					 * 13:3	reserved
-					 *  2:	Media Serial Number Valid
-					 *  1:	SMART selt-test supported
-					 *  0:	SMART error logging
-					 */
-	unsigned short  cfs_enable_1;	/* (word 85)
-					 * command set-feature enabled
-					 * 15:	Obsolete
-					 * 14:	NOP command
-					 * 13:	READ_BUFFER
-					 * 12:	WRITE_BUFFER
-					 * 11:	Obsolete
-					 * 10:	Host Protected Area
-					 *  9:	DEVICE Reset
-					 *  8:	SERVICE Interrupt
-					 *  7:	Release Interrupt
-					 *  6:	look-ahead
-					 *  5:	write cache
-					 *  4:	PACKET Command
-					 *  3:	Power Management Feature Set
-					 *  2:	Removable Feature Set
-					 *  1:	Security Feature Set
-					 *  0:	SMART Feature Set
-					 */
-	unsigned short  cfs_enable_2;	/* (word 86)
-					 * command set-feature enabled
-					 * 15:	Shall be ZERO
-					 * 14:	Shall be ONE
-					 * 13:	FLUSH CACHE EXT
-					 * 12:	FLUSH CACHE
-					 * 11:	Device Configuration Overlay
-					 * 10:	48-bit Address Feature Set
-					 *  9:	Automatic Acoustic Management
-					 *  8:	SET MAX security
-					 *  7:	reserved 1407DT PARTIES
-					 *  6:	SetF sub-command Power-Up
-					 *  5:	Power-Up in Standby Feature Set
-					 *  4:	Removable Media Notification
-					 *  3:	APM Feature Set
-					 *  2:	CFA Feature Set
-					 *  1:	READ/WRITE DMA QUEUED
-					 *  0:	Download MicroCode
-					 */
-	unsigned short  csf_default;	/* (word 87)
-					 * command set-feature default
-					 * 15:	Shall be ZERO
-					 * 14:	Shall be ONE
-					 * 13:3	reserved
-					 *  2:	Media Serial Number Valid
-					 *  1:	SMART selt-test supported
-					 *  0:	SMART error logging
-					 */
-	unsigned short  dma_ultra;	/* (word 88) */
-	unsigned short	word89;		/* reserved (word 89) */
-	unsigned short	word90;		/* reserved (word 90) */
-	unsigned short	CurAPMvalues;	/* current APM values */
-	unsigned short	word92;		/* reserved (word 92) */
-	unsigned short	hw_config;	/* hardware config (word 93)
-					 * 15:
-					 * 14:
-					 * 13:
-					 * 12:
-					 * 11:
-					 * 10:
-					 *  9:
-					 *  8:
-					 *  7:
-					 *  6:
-					 *  5:
-					 *  4:
-					 *  3:
-					 *  2:
-					 *  1:
-					 *  0:
-					 */
-	unsigned short	acoustic;	/* (word 94)
-					 * 15:8	Vendor's recommended value
-					 *  7:0	current value
-					 */
-	unsigned short	words95_99[5];	/* reserved words 95-99 */
-	unsigned long long lba_capacity_2;/* 48-bit total number of sectors */
-	unsigned short	words104_125[22];/* reserved words 104-125 */
-	unsigned short	last_lun;	/* (word 126) */
-	unsigned short	word127;	/* (word 127) Feature Set
-					 * Removable Media Notification
-					 * 15:2	reserved
-					 *  1:0	00 = not supported
-					 *	01 = supported
-					 *	10 = reserved
-					 *	11 = reserved
-					 */
-	unsigned short	dlf;		/* (word 128)
-					 * device lock function
-					 * 15:9	reserved
-					 *  8	security level 1:max 0:high
-					 *  7:6	reserved
-					 *  5	enhanced erase
-					 *  4	expire
-					 *  3	frozen
-					 *  2	locked
-					 *  1	en/disabled
-					 *  0	capability
-					 */
-	unsigned short  csfo;		/*  (word 129)
-					 * current set features options
-					 * 15:4	reserved
-					 *  3:	auto reassign
-					 *  2:	reverting
-					 *  1:	read-look-ahead
-					 *  0:	write cache
-					 */
-	unsigned short	words130_155[26];/* reserved vendor words 130-155 */
-	unsigned short	word156;	/* reserved vendor word 156 */
-	unsigned short	words157_159[3];/* reserved vendor words 157-159 */
-	unsigned short	cfa_power;	/* (word 160) CFA Power Mode
-					 * 15 word 160 supported
-					 * 14 reserved
-					 * 13
-					 * 12
-					 * 11:0
-					 */
-	unsigned short	words161_175[14];/* Reserved for CFA */
-	unsigned short	words176_205[31];/* Current Media Serial Number */
-	unsigned short	words206_254[48];/* reserved words 206-254 */
-	unsigned short	integrity_word;	/* (word 255)
-					 * 15:8 Checksum
-					 *  7:0 Signature
-					 */
+	u16	words71_74[4];	/* reserved words 71-74
+				 * for IDENTIFY PACKET DEVICE command
+				 */
+	u16	queue_depth;	/* (word 75)
+				 * 15:5	reserved
+				 *  4:0	Maximum queue depth -1
+				 */
+	u16	words76_79[4];	/* reserved words 76-79 */
+	u16	major_rev_num;	/* (word 80) */
+	u16	minor_rev_num;	/* (word 81) */
+	u16	command_set_1;	/* (word 82) supported
+				 * 15:	Obsolete
+				 * 14:	NOP command
+				 * 13:	READ_BUFFER
+				 * 12:	WRITE_BUFFER
+				 * 11:	Obsolete
+				 * 10:	Host Protected Area
+				 *  9:	DEVICE Reset
+				 *  8:	SERVICE Interrupt
+				 *  7:	Release Interrupt
+				 *  6:	look-ahead
+				 *  5:	write cache
+				 *  4:	PACKET Command
+				 *  3:	Power Management Feature Set
+				 *  2:	Removable Feature Set
+				 *  1:	Security Feature Set
+				 *  0:	SMART Feature Set
+				 */
+	u16	command_set_2;	/* (word 83)
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:	FLUSH CACHE EXT
+				 * 12:	FLUSH CACHE
+				 * 11:	Device Configuration Overlay
+				 * 10:	48-bit Address Feature Set
+				 *  9:	Automatic Acoustic Management
+				 *  8:	SET MAX security
+				 *  7:	reserved 1407DT PARTIES
+				 *  6:	SetF sub-command Power-Up
+				 *  5:	Power-Up in Standby Feature Set
+				 *  4:	Removable Media Notification
+				 *  3:	APM Feature Set
+				 *  2:	CFA Feature Set
+				 *  1:	READ/WRITE DMA QUEUED
+				 *  0:	Download MicroCode
+				 */
+	u16	cfsse;		/* (word 84)
+				 * cmd set-feature supported extensions
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:3	reserved
+				 *  2:	Media Serial Number Valid
+				 *  1:	SMART selt-test supported
+				 *  0:	SMART error logging
+				 */
+	u16	cfs_enable_1;	/* (word 85)
+				 * command set-feature enabled
+				 * 15:	Obsolete
+				 * 14:	NOP command
+				 * 13:	READ_BUFFER
+				 * 12:	WRITE_BUFFER
+				 * 11:	Obsolete
+				 * 10:	Host Protected Area
+				 *  9:	DEVICE Reset
+				 *  8:	SERVICE Interrupt
+				 *  7:	Release Interrupt
+				 *  6:	look-ahead
+				 *  5:	write cache
+				 *  4:	PACKET Command
+				 *  3:	Power Management Feature Set
+				 *  2:	Removable Feature Set
+				 *  1:	Security Feature Set
+				 *  0:	SMART Feature Set
+				 */
+	u16	cfs_enable_2;	/* (word 86)
+				 * command set-feature enabled
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:	FLUSH CACHE EXT
+				 * 12:	FLUSH CACHE
+				 * 11:	Device Configuration Overlay
+				 * 10:	48-bit Address Feature Set
+				 *  9:	Automatic Acoustic Management
+				 *  8:	SET MAX security
+				 *  7:	reserved 1407DT PARTIES
+				 *  6:	SetF sub-command Power-Up
+				 *  5:	Power-Up in Standby Feature Set
+				 *  4:	Removable Media Notification
+				 *  3:	APM Feature Set
+				 *  2:	CFA Feature Set
+				 *  1:	READ/WRITE DMA QUEUED
+				 *  0:	Download MicroCode
+				 */
+	u16	csf_default;	/* (word 87)
+				 * command set-feature default
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:3	reserved
+				 *  2:	Media Serial Number Valid
+				 *  1:	SMART selt-test supported
+				 *  0:	SMART error logging
+				 */
+	u16	dma_ultra;	/* (word 88) */
+	u16	word89;		/* reserved (word 89) */
+	u16	word90;		/* reserved (word 90) */
+	u16	CurAPMvalues;	/* current APM values */
+	u16	word92;		/* reserved (word 92) */
+	u16	hw_config;	/* hardware config (word 93)
+				 * 15:
+				 * 14:
+				 * 13:
+				 * 12:
+				 * 11:
+				 * 10:
+				 *  9:
+				 *  8:
+				 *  7:
+				 *  6:
+				 *  5:
+				 *  4:
+				 *  3:
+				 *  2:
+				 *  1:
+				 *  0:
+				 */
+	u16	acoustic;	/* (word 94)
+				 * 15:8	Vendor's recommended value
+				 *  7:0	current value
+				 */
+	u16	words95_99[5];	/* reserved words 95-99 */
+	u64	lba_capacity_2;	/* 48-bit total number of sectors */
+	u16	words104_125[22];/* reserved words 104-125 */
+	u16	last_lun;	/* (word 126) */
+	u16	word127;	/* (word 127) Feature Set
+				 * Removable Media Notification
+				 * 15:2	reserved
+				 *  1:0	00 = not supported
+				 *	01 = supported
+				 *	10 = reserved
+				 *	11 = reserved
+				 */
+	u16	dlf;		/* (word 128)
+				 * device lock function
+				 * 15:9	reserved
+				 *  8	security level 1:max 0:high
+				 *  7:6	reserved
+				 *  5	enhanced erase
+				 *  4	expire
+				 *  3	frozen
+				 *  2	locked
+				 *  1	en/disabled
+				 *  0	capability
+				 */
+	u16	csfo;		/* (word 129)
+				 * current set features options
+				 * 15:4	reserved
+				 *  3:	auto reassign
+				 *  2:	reverting
+				 *  1:	read-look-ahead
+				 *  0:	write cache
+				 */
+	u16	words130_155[26];/* reserved vendor words 130-155 */
+	u16	word156;	/* reserved vendor word 156 */
+	u16	words157_159[3];/* reserved vendor words 157-159 */
+	u16	cfa_power;	/* (word 160) CFA Power Mode
+				 * 15 word 160 supported
+				 * 14 reserved
+				 * 13
+				 * 12
+				 * 11:0
+				 */
+	u16	words161_175[14];/* Reserved for CFA */
+	u16	words176_205[31];/* Current Media Serial Number */
+	u16	words206_254[48];/* reserved words 206-254 */
+	u16	integrity_word;	/* (word 255)
+				 * 15:8 Checksum
+				 *  7:0 Signature
+				 */
 } __attribute__((packed));
 
-/*
- * IDE "nice" flags. These are used on a per drive basis to determine
- * when to be nice and give more bandwidth to the other devices which
- * share the same IDE bus.
- */
 #define IDE_NICE_DSC_OVERLAP	(0)	/* per the DSC overlap protocol */
-#define IDE_NICE_ATAPI_OVERLAP	(1)	/* not supported yet */
 
-#endif	/* _LINUX_HDREG_H */
+#endif

--------------000409030604010609090807--

