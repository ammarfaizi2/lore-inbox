Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318099AbSHBELT>; Fri, 2 Aug 2002 00:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSHBELT>; Fri, 2 Aug 2002 00:11:19 -0400
Received: from h-64-105-137-35.SNVACAID.covad.net ([64.105.137.35]:8161 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318099AbSHBELO>; Fri, 2 Aug 2002 00:11:14 -0400
Date: Thu, 1 Aug 2002 21:14:36 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Subject: Patch: linux-2.5.30: return hd_driveid to <linux/hdreg.h>
Message-ID: <20020801211436.A11035@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	IDE-108 moved struct hd_driveid from linux/hdreg.h to
linux/ide.h.  However, user level code in pcmcia-cs-3.2.0/cardmgr/ide-info.c
refers to hd_driveid, and including <linux/ide.h> results in a flood
of conflicts with GNU C library headers.

	The following patch returns struct hd_driveid to include/linux/hdreg.h
and changes its u{8,16,32,64} references to __u{8,16,32,64} (which are
types that the linux include files export for user level programs).

	I have rebuilt the core kernel, drivers/{ide,scsi} and
pcmcia-cs-3.2.0 with this change.  It fixes the pcmcia-cs-3.2.0
compilation problems and does not appear to cause any new compilation
errors in the kernel.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide.diffs"

--- linux-2.5.30/include/linux/ide.h	2002-08-01 14:16:12.000000000 -0700
+++ linux/include/linux/ide.h	2002-08-01 21:01:37.000000000 -0700
@@ -259,250 +259,6 @@
 	BUSSTATE_TRISTATE
 };
 
-/*
- * Structure returned by HDIO_GET_IDENTITY, as per ANSI NCITS ATA6 rev.1b spec.
- *
- * If you change something here, please remember to update fix_driveid() in
- * ide/probe.c.
- */
-struct hd_driveid {
-	u16	config;		/* lots of obsolete bit flags */
-	u16	cyls;		/* Obsolete, "physical" cyls */
-	u16	reserved2;	/* reserved (word 2) */
-	u16	heads;		/* Obsolete, "physical" heads */
-	u16	track_bytes;	/* unformatted bytes per track */
-	u16	sector_bytes;	/* unformatted bytes per sector */
-	u16	sectors;	/* Obsolete, "physical" sectors per track */
-	u16	vendor0;	/* vendor unique */
-	u16	vendor1;	/* vendor unique */
-	u16	vendor2;	/* Retired vendor unique */
-	u8	serial_no[20];	/* 0 = not_specified */
-	u16	buf_type;	/* Retired */
-	u16	buf_size;	/* Retired, 512 byte increments
-				 * 0 = not_specified
-				 */
-	u16	ecc_bytes;	/* for r/w long cmds; 0 = not_specified */
-	u8	fw_rev[8];	/* 0 = not_specified */
-	char	model[40];	/* 0 = not_specified */
-	u8	max_multsect;	/* 0=not_implemented */
-	u8	vendor3;	/* vendor unique */
-	u16	dword_io;	/* 0=not_implemented; 1=implemented */
-	u8	vendor4;	/* vendor unique */
-	u8	capability;	/* (upper byte of word 49)
-				 *  3:	IORDYsup
-				 *  2:	IORDYsw
-				 *  1:	LBA
-				 *  0:	DMA
-				 */
-	u16	reserved50;	/* reserved (word 50) */
-	u8	vendor5;	/* Obsolete, vendor unique */
-	u8	tPIO;		/* Obsolete, 0=slow, 1=medium, 2=fast */
-	u8	vendor6;	/* Obsolete, vendor unique */
-	u8	tDMA;		/* Obsolete, 0=slow, 1=medium, 2=fast */
-	u16	field_valid;	/* (word 53)
-				 *  2:	ultra_ok	word  88
-				 *  1:	eide_ok		words 64-70
-				 *  0:	cur_ok		words 54-58
-				 */
-	u16	cur_cyls;	/* Obsolete, logical cylinders */
-	u16	cur_heads;	/* Obsolete, l heads */
-	u16	cur_sectors;	/* Obsolete, l sectors per track */
-	u16	cur_capacity0;	/* Obsolete, l total sectors on drive */
-	u16	cur_capacity1;	/* Obsolete, (2 words, misaligned int)     */
-	u8	multsect;	/* current multiple sector count */
-	u8	multsect_valid;	/* when (bit0==1) multsect is ok */
-	u32	lba_capacity;	/* Obsolete, total number of sectors */
-	u16	dma_1word;	/* Obsolete, single-word dma info */
-	u16	dma_mword;	/* multiple-word dma info */
-	u16	eide_pio_modes; /* bits 0:mode3 1:mode4 */
-	u16	eide_dma_min;	/* min mword dma cycle time (ns) */
-	u16	eide_dma_time;	/* recommended mword dma cycle time (ns) */
-	u16	eide_pio;       /* min cycle time (ns), no IORDY  */
-	u16	eide_pio_iordy; /* min cycle time (ns), with IORDY */
-	u16	words69_70[2];	/* reserved words 69-70
-				 * future command overlap and queuing
-				 */
-	/* HDIO_GET_IDENTITY currently returns only words 0 through 70 */
-	u16	words71_74[4];	/* reserved words 71-74
-				 * for IDENTIFY PACKET DEVICE command
-				 */
-	u16	queue_depth;	/* (word 75)
-				 * 15:5	reserved
-				 *  4:0	Maximum queue depth -1
-				 */
-	u16	words76_79[4];	/* reserved words 76-79 */
-	u16	major_rev_num;	/* (word 80) */
-	u16	minor_rev_num;	/* (word 81) */
-	u16	command_set_1;	/* (word 82) supported
-				 * 15:	Obsolete
-				 * 14:	NOP command
-				 * 13:	READ_BUFFER
-				 * 12:	WRITE_BUFFER
-				 * 11:	Obsolete
-				 * 10:	Host Protected Area
-				 *  9:	DEVICE Reset
-				 *  8:	SERVICE Interrupt
-				 *  7:	Release Interrupt
-				 *  6:	look-ahead
-				 *  5:	write cache
-				 *  4:	PACKET Command
-				 *  3:	Power Management Feature Set
-				 *  2:	Removable Feature Set
-				 *  1:	Security Feature Set
-				 *  0:	SMART Feature Set
-				 */
-	u16	command_set_2;	/* (word 83)
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:	FLUSH CACHE EXT
-				 * 12:	FLUSH CACHE
-				 * 11:	Device Configuration Overlay
-				 * 10:	48-bit Address Feature Set
-				 *  9:	Automatic Acoustic Management
-				 *  8:	SET MAX security
-				 *  7:	reserved 1407DT PARTIES
-				 *  6:	SetF sub-command Power-Up
-				 *  5:	Power-Up in Standby Feature Set
-				 *  4:	Removable Media Notification
-				 *  3:	APM Feature Set
-				 *  2:	CFA Feature Set
-				 *  1:	READ/WRITE DMA QUEUED
-				 *  0:	Download MicroCode
-				 */
-	u16	cfsse;		/* (word 84)
-				 * cmd set-feature supported extensions
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:3	reserved
-				 *  2:	Media Serial Number Valid
-				 *  1:	SMART selt-test supported
-				 *  0:	SMART error logging
-				 */
-	u16	cfs_enable_1;	/* (word 85)
-				 * command set-feature enabled
-				 * 15:	Obsolete
-				 * 14:	NOP command
-				 * 13:	READ_BUFFER
-				 * 12:	WRITE_BUFFER
-				 * 11:	Obsolete
-				 * 10:	Host Protected Area
-				 *  9:	DEVICE Reset
-				 *  8:	SERVICE Interrupt
-				 *  7:	Release Interrupt
-				 *  6:	look-ahead
-				 *  5:	write cache
-				 *  4:	PACKET Command
-				 *  3:	Power Management Feature Set
-				 *  2:	Removable Feature Set
-				 *  1:	Security Feature Set
-				 *  0:	SMART Feature Set
-				 */
-	u16	cfs_enable_2;	/* (word 86)
-				 * command set-feature enabled
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:	FLUSH CACHE EXT
-				 * 12:	FLUSH CACHE
-				 * 11:	Device Configuration Overlay
-				 * 10:	48-bit Address Feature Set
-				 *  9:	Automatic Acoustic Management
-				 *  8:	SET MAX security
-				 *  7:	reserved 1407DT PARTIES
-				 *  6:	SetF sub-command Power-Up
-				 *  5:	Power-Up in Standby Feature Set
-				 *  4:	Removable Media Notification
-				 *  3:	APM Feature Set
-				 *  2:	CFA Feature Set
-				 *  1:	READ/WRITE DMA QUEUED
-				 *  0:	Download MicroCode
-				 */
-	u16	csf_default;	/* (word 87)
-				 * command set-feature default
-				 * 15:	Shall be ZERO
-				 * 14:	Shall be ONE
-				 * 13:3	reserved
-				 *  2:	Media Serial Number Valid
-				 *  1:	SMART selt-test supported
-				 *  0:	SMART error logging
-				 */
-	u16	dma_ultra;	/* (word 88) */
-	u16	word89;		/* reserved (word 89) */
-	u16	word90;		/* reserved (word 90) */
-	u16	CurAPMvalues;	/* current APM values */
-	u16	word92;		/* reserved (word 92) */
-	u16	hw_config;	/* hardware config (word 93)
-				 * 15:
-				 * 14:
-				 * 13:
-				 * 12:
-				 * 11:
-				 * 10:
-				 *  9:
-				 *  8:
-				 *  7:
-				 *  6:
-				 *  5:
-				 *  4:
-				 *  3:
-				 *  2:
-				 *  1:
-				 *  0:
-				 */
-	u16	acoustic;	/* (word 94)
-				 * 15:8	Vendor's recommended value
-				 *  7:0	current value
-				 */
-	u16	words95_99[5];	/* reserved words 95-99 */
-	u64	lba_capacity_2;	/* 48-bit total number of sectors */
-	u16	words104_125[22];/* reserved words 104-125 */
-	u16	last_lun;	/* (word 126) */
-	u16	word127;	/* (word 127) Feature Set
-				 * Removable Media Notification
-				 * 15:2	reserved
-				 *  1:0	00 = not supported
-				 *	01 = supported
-				 *	10 = reserved
-				 *	11 = reserved
-				 */
-	u16	dlf;		/* (word 128)
-				 * device lock function
-				 * 15:9	reserved
-				 *  8	security level 1:max 0:high
-				 *  7:6	reserved
-				 *  5	enhanced erase
-				 *  4	expire
-				 *  3	frozen
-				 *  2	locked
-				 *  1	en/disabled
-				 *  0	capability
-				 */
-	u16	csfo;		/* (word 129)
-				 * current set features options
-				 * 15:4	reserved
-				 *  3:	auto reassign
-				 *  2:	reverting
-				 *  1:	read-look-ahead
-				 *  0:	write cache
-				 */
-	u16	words130_155[26];/* reserved vendor words 130-155 */
-	u16	word156;	/* reserved vendor word 156 */
-	u16	words157_159[3];/* reserved vendor words 157-159 */
-	u16	cfa_power;	/* (word 160) CFA Power Mode
-				 * 15 word 160 supported
-				 * 14 reserved
-				 * 13
-				 * 12
-				 * 11:0
-				 */
-	u16	words161_175[14];/* Reserved for CFA */
-	u16	words176_205[31];/* Current Media Serial Number */
-	u16	words206_254[48];/* reserved words 206-254 */
-	u16	integrity_word;	/* (word 255)
-				 * 15:8 Checksum
-				 *  7:0 Signature
-				 */
-} __attribute__((packed));
-
 #define IDE_NICE_DSC_OVERLAP	(0)	/* per the DSC overlap protocol */
 
 /*
--- linux-2.5.30/include/linux/hdreg.h	2002-08-01 14:16:23.000000000 -0700
+++ linux/include/linux/hdreg.h	2002-08-01 21:01:45.000000000 -0700
@@ -49,4 +49,249 @@
 /* 0x330 is reserved - used to be HDIO_GETGEO_BIG */
 #define HDIO_GETGEO_BIG_RAW	0x0331	/* */
 
+/*
+ * Structure returned by HDIO_GET_IDENTITY, as per ANSI NCITS ATA6 rev.1b spec.
+ *
+ * If you change something here, please remember to update fix_driveid() in
+ * ide/probe.c.
+ */
+
+struct hd_driveid {
+	__u16	config;		/* lots of obsolete bit flags */
+	__u16	cyls;		/* Obsolete, "physical" cyls */
+	__u16	reserved2;	/* reserved (word 2) */
+	__u16	heads;		/* Obsolete, "physical" heads */
+	__u16	track_bytes;	/* unformatted bytes per track */
+	__u16	sector_bytes;	/* unformatted bytes per sector */
+	__u16	sectors;	/* Obsolete, "physical" sectors per track */
+	__u16	vendor0;	/* vendor unique */
+	__u16	vendor1;	/* vendor unique */
+	__u16	vendor2;	/* Retired vendor unique */
+	__u8	serial_no[20];	/* 0 = not_specified */
+	__u16	buf_type;	/* Retired */
+	__u16	buf_size;	/* Retired, 512 byte increments
+				 * 0 = not_specified
+				 */
+	__u16	ecc_bytes;	/* for r/w long cmds; 0 = not_specified */
+	__u8	fw_rev[8];	/* 0 = not_specified */
+	char	model[40];	/* 0 = not_specified */
+	__u8	max_multsect;	/* 0=not_implemented */
+	__u8	vendor3;	/* vendor unique */
+	__u16	dword_io;	/* 0=not_implemented; 1=implemented */
+	__u8	vendor4;	/* vendor unique */
+	__u8	capability;	/* (upper byte of word 49)
+				 *  3:	IORDYsup
+				 *  2:	IORDYsw
+				 *  1:	LBA
+				 *  0:	DMA
+				 */
+	__u16	reserved50;	/* reserved (word 50) */
+	__u8	vendor5;	/* Obsolete, vendor unique */
+	__u8	tPIO;		/* Obsolete, 0=slow, 1=medium, 2=fast */
+	__u8	vendor6;	/* Obsolete, vendor unique */
+	__u8	tDMA;		/* Obsolete, 0=slow, 1=medium, 2=fast */
+	__u16	field_valid;	/* (word 53)
+				 *  2:	ultra_ok	word  88
+				 *  1:	eide_ok		words 64-70
+				 *  0:	cur_ok		words 54-58
+				 */
+	__u16	cur_cyls;	/* Obsolete, logical cylinders */
+	__u16	cur_heads;	/* Obsolete, l heads */
+	__u16	cur_sectors;	/* Obsolete, l sectors per track */
+	__u16	cur_capacity0;	/* Obsolete, l total sectors on drive */
+	__u16	cur_capacity1;	/* Obsolete, (2 words, misaligned int)     */
+	__u8	multsect;	/* current multiple sector count */
+	__u8	multsect_valid;	/* when (bit0==1) multsect is ok */
+	__u32	lba_capacity;	/* Obsolete, total number of sectors */
+	__u16	dma_1word;	/* Obsolete, single-word dma info */
+	__u16	dma_mword;	/* multiple-word dma info */
+	__u16	eide_pio_modes; /* bits 0:mode3 1:mode4 */
+	__u16	eide_dma_min;	/* min mword dma cycle time (ns) */
+	__u16	eide_dma_time;	/* recommended mword dma cycle time (ns) */
+	__u16	eide_pio;       /* min cycle time (ns), no IORDY  */
+	__u16	eide_pio_iordy; /* min cycle time (ns), with IORDY */
+	__u16	words69_70[2];	/* reserved words 69-70
+				 * future command overlap and queuing
+				 */
+	/* HDIO_GET_IDENTITY currently returns only words 0 through 70 */
+	__u16	words71_74[4];	/* reserved words 71-74
+				 * for IDENTIFY PACKET DEVICE command
+				 */
+	__u16	queue_depth;	/* (word 75)
+				 * 15:5	reserved
+				 *  4:0	Maximum queue depth -1
+				 */
+	__u16	words76_79[4];	/* reserved words 76-79 */
+	__u16	major_rev_num;	/* (word 80) */
+	__u16	minor_rev_num;	/* (word 81) */
+	__u16	command_set_1;	/* (word 82) supported
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
+	__u16	command_set_2;	/* (word 83)
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
+	__u16	cfsse;		/* (word 84)
+				 * cmd set-feature supported extensions
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:3	reserved
+				 *  2:	Media Serial Number Valid
+				 *  1:	SMART selt-test supported
+				 *  0:	SMART error logging
+				 */
+	__u16	cfs_enable_1;	/* (word 85)
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
+	__u16	cfs_enable_2;	/* (word 86)
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
+	__u16	csf_default;	/* (word 87)
+				 * command set-feature default
+				 * 15:	Shall be ZERO
+				 * 14:	Shall be ONE
+				 * 13:3	reserved
+				 *  2:	Media Serial Number Valid
+				 *  1:	SMART selt-test supported
+				 *  0:	SMART error logging
+				 */
+	__u16	dma_ultra;	/* (word 88) */
+	__u16	word89;		/* reserved (word 89) */
+	__u16	word90;		/* reserved (word 90) */
+	__u16	CurAPMvalues;	/* current APM values */
+	__u16	word92;		/* reserved (word 92) */
+	__u16	hw_config;	/* hardware config (word 93)
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
+	__u16	acoustic;	/* (word 94)
+				 * 15:8	Vendor's recommended value
+				 *  7:0	current value
+				 */
+	__u16	words95_99[5];	/* reserved words 95-99 */
+	__u64	lba_capacity_2;	/* 48-bit total number of sectors */
+	__u16	words104_125[22];/* reserved words 104-125 */
+	__u16	last_lun;	/* (word 126) */
+	__u16	word127;	/* (word 127) Feature Set
+				 * Removable Media Notification
+				 * 15:2	reserved
+				 *  1:0	00 = not supported
+				 *	01 = supported
+				 *	10 = reserved
+				 *	11 = reserved
+				 */
+	__u16	dlf;		/* (word 128)
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
+	__u16	csfo;		/* (word 129)
+				 * current set features options
+				 * 15:4	reserved
+				 *  3:	auto reassign
+				 *  2:	reverting
+				 *  1:	read-look-ahead
+				 *  0:	write cache
+				 */
+	__u16	words130_155[26];/* reserved vendor words 130-155 */
+	__u16	word156;	/* reserved vendor word 156 */
+	__u16	words157_159[3];/* reserved vendor words 157-159 */
+	__u16	cfa_power;	/* (word 160) CFA Power Mode
+				 * 15 word 160 supported
+				 * 14 reserved
+				 * 13
+				 * 12
+				 * 11:0
+				 */
+	__u16	words161_175[14];/* Reserved for CFA */
+	__u16	words176_205[31];/* Current Media Serial Number */
+	__u16	words206_254[48];/* reserved words 206-254 */
+	__u16	integrity_word;	/* (word 255)
+				 * 15:8 Checksum
+				 *  7:0 Signature
+				 */
+} __attribute__((packed));
+
 #endif

--/04w6evG8XlLl3ft--
