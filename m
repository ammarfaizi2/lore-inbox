Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262551AbTCRVt5>; Tue, 18 Mar 2003 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262555AbTCRVt5>; Tue, 18 Mar 2003 16:49:57 -0500
Received: from hera.cwi.nl ([192.16.191.8]:243 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262551AbTCRVtw>;
	Tue, 18 Mar 2003 16:49:52 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 18 Mar 2003 23:00:47 +0100 (MET)
Message-Id: <UTC200303182200.h2IM0ln00076.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] dev_t [3/3]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The third patch removes the last occurrences of MAX_BLKDEV and
MAX_CHRDEV and sorts the majors in major.h.
It also updates the definition of SCSI_DISK_MAJOR.

Andries

--------------- 03-major-diff -----------------
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/major.h b/include/linux/major.h
--- a/include/linux/major.h	Tue Dec 10 18:42:41 2002
+++ b/include/linux/major.h	Tue Mar 18 21:53:29 2003
@@ -6,85 +6,74 @@
  * For the device number assignments, see Documentation/devices.txt.
  */
 
-/* limits */
+#define UNNAMED_MAJOR		0
+#define MEM_MAJOR		1
+#define RAMDISK_MAJOR		1
+#define FLOPPY_MAJOR		2
+#define PTY_MASTER_MAJOR	2
+#define IDE0_MAJOR		3
+#define HD_MAJOR		IDE0_MAJOR
+#define PTY_SLAVE_MAJOR		3
+#define TTY_MAJOR		4
+#define TTYAUX_MAJOR		5
+#define LP_MAJOR		6
+#define VCS_MAJOR		7
+#define LOOP_MAJOR		7
+#define SCSI_DISK0_MAJOR	8
+#define SCSI_TAPE_MAJOR		9
+#define MD_MAJOR		9
+#define MISC_MAJOR		10
+#define SCSI_CDROM_MAJOR	11
+#define MUX_MAJOR		11	/* PA-RISC only */
+#define QIC02_TAPE_MAJOR	12
+#define XT_DISK_MAJOR		13
+#define SOUND_MAJOR		14
+#define CDU31A_CDROM_MAJOR	15
+#define JOYSTICK_MAJOR		15
+#define GOLDSTAR_CDROM_MAJOR	16
+#define OPTICS_CDROM_MAJOR	17
+#define SANYO_CDROM_MAJOR	18
+#define CYCLADES_MAJOR		19
+#define CYCLADESAUX_MAJOR	20
+#define MITSUMI_X_CDROM_MAJOR	20
+#define MFM_ACORN_MAJOR		21	/* ARM Linux /dev/mfm */
+#define SCSI_GENERIC_MAJOR	21
+#define IDE1_MAJOR		22
+#define DIGICU_MAJOR		22
+#define DIGI_MAJOR		23
+#define MITSUMI_CDROM_MAJOR	23
+#define CDU535_CDROM_MAJOR	24
+#define STL_SERIALMAJOR		24
+#define MATSUSHITA_CDROM_MAJOR	25
+#define STL_CALLOUTMAJOR	25
+#define MATSUSHITA_CDROM2_MAJOR	26
+#define QIC117_TAPE_MAJOR	27
+#define MATSUSHITA_CDROM3_MAJOR	27
+#define MATSUSHITA_CDROM4_MAJOR	28
+#define STL_SIOMEMMAJOR		28
+#define ACSI_MAJOR		28
+#define AZTECH_CDROM_MAJOR	29
+#define GRAPHDEV_MAJOR		29   /* SparcLinux & Linux/68k /dev/fb */
+#define CM206_CDROM_MAJOR	32
+#define IDE2_MAJOR		33
+#define IDE3_MAJOR		34
+#define Z8530_MAJOR		34
+#define XPRAM_MAJOR		35   /* Expanded storage on S/390: "slow ram"*/
+#define NETLINK_MAJOR		36
+#define PS2ESDI_MAJOR		36
+#define IDETAPE_MAJOR		37
+#define Z2RAM_MAJOR		37
+#define APBLOCK_MAJOR		38   /* AP1000 Block device */
+#define DDV_MAJOR		39   /* AP1000 DDV block device */
+#define NBD_MAJOR		43   /* Network block device	*/
+#define RISCOM8_NORMAL_MAJOR	48
+#define DAC960_MAJOR		48   /* 48..55 */
+#define RISCOM8_CALLOUT_MAJOR	49
+#define MKISS_MAJOR		55
+#define DSP56K_MAJOR		55   /* DSP56001 processor device */
 
-/*
- * Important: Don't change this to 256.  Major number 255 is and must be
- * reserved for future expansion into a larger dev_t space.
- */
-#define MAX_CHRDEV	255
-#define MAX_BLKDEV	255
-
-#define UNNAMED_MAJOR	0
-#define MEM_MAJOR	1
-#define RAMDISK_MAJOR	1
-#define FLOPPY_MAJOR	2
-#define PTY_MASTER_MAJOR 2
-#define IDE0_MAJOR	3
-#define PTY_SLAVE_MAJOR 3
-#define HD_MAJOR	IDE0_MAJOR
-#define TTY_MAJOR	4
-#define TTYAUX_MAJOR	5
-#define LP_MAJOR	6
-#define VCS_MAJOR	7
-#define LOOP_MAJOR	7
-#define SCSI_DISK0_MAJOR 8
-#define SCSI_TAPE_MAJOR	9
-#define MD_MAJOR        9
-#define MISC_MAJOR	10
-#define SCSI_CDROM_MAJOR 11
-#define MUX_MAJOR	11	/* PA-RISC only */
-#define QIC02_TAPE_MAJOR 12
-#define XT_DISK_MAJOR	13
-#define SOUND_MAJOR	14
-#define CDU31A_CDROM_MAJOR 15
-#define JOYSTICK_MAJOR	15
-#define GOLDSTAR_CDROM_MAJOR 16
-#define OPTICS_CDROM_MAJOR 17
-#define SANYO_CDROM_MAJOR 18
-#define CYCLADES_MAJOR  19
-#define CYCLADESAUX_MAJOR 20
-#define MITSUMI_X_CDROM_MAJOR 20
-#define MFM_ACORN_MAJOR 21	/* ARM Linux /dev/mfm */
-#define SCSI_GENERIC_MAJOR 21
-#define Z8530_MAJOR 34
-#define DIGI_MAJOR 23
-#define IDE1_MAJOR	22
-#define DIGICU_MAJOR 22
-#define MITSUMI_CDROM_MAJOR 23
-#define CDU535_CDROM_MAJOR 24
-#define STL_SERIALMAJOR 24
-#define MATSUSHITA_CDROM_MAJOR 25
-#define STL_CALLOUTMAJOR 25
-#define MATSUSHITA_CDROM2_MAJOR 26
-#define QIC117_TAPE_MAJOR 27
-#define MATSUSHITA_CDROM3_MAJOR 27
-#define MATSUSHITA_CDROM4_MAJOR 28
-#define STL_SIOMEMMAJOR 28
-#define ACSI_MAJOR	28
-#define AZTECH_CDROM_MAJOR 29
-#define GRAPHDEV_MAJOR	29	/* SparcLinux & Linux/68k /dev/fb */
-#define SHMIQ_MAJOR	85	/* Linux/mips, SGI /dev/shmiq */
-#define CM206_CDROM_MAJOR 32
-#define IDE2_MAJOR	33
-#define IDE3_MAJOR	34
-#define XPRAM_MAJOR     35      /* expanded storage on S/390 = "slow ram" */
-                                /* proposed by Peter                      */
-#define NETLINK_MAJOR	36
-#define PS2ESDI_MAJOR	36
-#define IDETAPE_MAJOR	37
-#define Z2RAM_MAJOR	37
-#define APBLOCK_MAJOR   38   /* AP1000 Block device */
-#define DDV_MAJOR       39   /* AP1000 DDV block device */
-#define NBD_MAJOR	43   /* Network block device	*/
-#define RISCOM8_NORMAL_MAJOR 48
-#define DAC960_MAJOR	48	/* 48..55 */
-#define RISCOM8_CALLOUT_MAJOR 49
-#define MKISS_MAJOR	55
-#define DSP56K_MAJOR    55   /* DSP56001 processor device */
-
-#define IDE4_MAJOR	56
-#define IDE5_MAJOR	57
+#define IDE4_MAJOR		56
+#define IDE5_MAJOR		57
 
 #define SCSI_DISK1_MAJOR	65
 #define SCSI_DISK2_MAJOR	66
@@ -94,15 +83,6 @@
 #define SCSI_DISK6_MAJOR	70
 #define SCSI_DISK7_MAJOR	71
 
-#define SCSI_DISK8_MAJOR	128
-#define SCSI_DISK9_MAJOR	129
-#define SCSI_DISK10_MAJOR	130
-#define SCSI_DISK11_MAJOR	131
-#define SCSI_DISK12_MAJOR	132
-#define SCSI_DISK13_MAJOR	133
-#define SCSI_DISK14_MAJOR	134
-#define SCSI_DISK15_MAJOR	135
-
 #define COMPAQ_SMART2_MAJOR	72
 #define COMPAQ_SMART2_MAJOR1	73
 #define COMPAQ_SMART2_MAJOR2	74
@@ -112,10 +92,31 @@
 #define COMPAQ_SMART2_MAJOR6	78
 #define COMPAQ_SMART2_MAJOR7	79
 
-#define SPECIALIX_NORMAL_MAJOR 75
-#define SPECIALIX_CALLOUT_MAJOR 76
+#define SPECIALIX_NORMAL_MAJOR	75
+#define SPECIALIX_CALLOUT_MAJOR	76
+
+#define AURORA_MAJOR		79
+
+#define I2O_MAJOR		80	/* 80->87 */
+
+#define SHMIQ_MAJOR		85   /* Linux/mips, SGI /dev/shmiq */
+
+#define IDE6_MAJOR		88
+#define IDE7_MAJOR		89
+#define IDE8_MAJOR		90
+#define IDE9_MAJOR		91
+
+#define DASD_MAJOR		94
+
+#define MDISK_MAJOR		95
+
+#define UBD_MAJOR		98
+
+#define JSFD_MAJOR		99
+
+#define PHONE_MAJOR		100
 
-#define COMPAQ_CISS_MAJOR 	104
+#define COMPAQ_CISS_MAJOR	104
 #define COMPAQ_CISS_MAJOR1	105
 #define COMPAQ_CISS_MAJOR2      106
 #define COMPAQ_CISS_MAJOR3      107
@@ -126,36 +127,26 @@
 
 #define ATARAID_MAJOR		114
 
-#define DASD_MAJOR      94	/* Official assignations from Peter */
-
-#define MDISK_MAJOR     95	/* Official assignations from Peter */
-
-#define I2O_MAJOR		80	/* 80->87 */
-
-#define IDE6_MAJOR	88
-#define IDE7_MAJOR	89
-#define IDE8_MAJOR	90
-#define IDE9_MAJOR	91
-
-#define UBD_MAJOR	98
-
-#define AURORA_MAJOR 79
-
-#define JSFD_MAJOR	99
+#define SCSI_DISK8_MAJOR	128
+#define SCSI_DISK9_MAJOR	129
+#define SCSI_DISK10_MAJOR	130
+#define SCSI_DISK11_MAJOR	131
+#define SCSI_DISK12_MAJOR	132
+#define SCSI_DISK13_MAJOR	133
+#define SCSI_DISK14_MAJOR	134
+#define SCSI_DISK15_MAJOR	135
 
-#define PHONE_MAJOR	100
+#define UNIX98_PTY_MASTER_MAJOR	128
+#define UNIX98_PTY_MAJOR_COUNT	8
+#define UNIX98_PTY_SLAVE_MAJOR	(UNIX98_PTY_MASTER_MAJOR+UNIX98_PTY_MAJOR_COUNT)
 
-#define RTF_MAJOR	150
-#define RAW_MAJOR	162
+#define RTF_MAJOR		150
+#define RAW_MAJOR		162
 
 #define USB_ACM_MAJOR		166
 #define USB_ACM_AUX_MAJOR	167
 #define USB_CHAR_MAJOR		180
 
-#define UNIX98_PTY_MASTER_MAJOR	128
-#define UNIX98_PTY_MAJOR_COUNT	8
-#define UNIX98_PTY_SLAVE_MAJOR	(UNIX98_PTY_MASTER_MAJOR+UNIX98_PTY_MAJOR_COUNT)
-
 #define VXVM_MAJOR		199	/* VERITAS volume i/o driver    */
 #define VXSPEC_MAJOR		200	/* VERITAS volume config driver */
 #define VXDMP_MAJOR		201	/* VERITAS volume multipath driver */
@@ -163,17 +154,18 @@
 #define MSR_MAJOR		202
 #define CPUID_MAJOR		203
 
-#define OSST_MAJOR	206	/* OnStream-SCx0 SCSI tape */
+#define OSST_MAJOR		206	/* OnStream-SCx0 SCSI tape */
 
-#define IBM_TTY3270_MAJOR       227	/* Official allocations now */
-#define IBM_FS3270_MAJOR        228
+#define IBM_TTY3270_MAJOR	227
+#define IBM_FS3270_MAJOR	228
 
 /*
  * Tests for SCSI devices.
  */
 
 #define SCSI_DISK_MAJOR(M) ((M) == SCSI_DISK0_MAJOR || \
-  ((M) >= SCSI_DISK1_MAJOR && (M) <= SCSI_DISK7_MAJOR))
+  ((M) >= SCSI_DISK1_MAJOR && (M) <= SCSI_DISK7_MAJOR) || \
+  ((M) >= SCSI_DISK8_MAJOR && (M) <= SCSI_DISK15_MAJOR))
   
 #define SCSI_BLK_MAJOR(M) \
   (SCSI_DISK_MAJOR(M)	\
