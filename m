Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbSL1Vwp>; Sat, 28 Dec 2002 16:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbSL1Vwp>; Sat, 28 Dec 2002 16:52:45 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:41912 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265939AbSL1Vwi>; Sat, 28 Dec 2002 16:52:38 -0500
Date: Sat, 28 Dec 2002 14:53:27 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK input pacth 2]
Message-ID: <Pine.LNX.4.33.0212281452470.1725-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pc_keyb.h is no longer needed.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.869, 2002-12-10 12:45:54-08:00, jsimmons@kozmo.(none)
  Delete: include/linux/pc_keyb.h


 pc_keyb.h |  130 --------------------------------------------------------------
 1 files changed, 130 deletions(-)


diff -Nru a/include/linux/pc_keyb.h b/include/linux/pc_keyb.h
--- a/include/linux/pc_keyb.h	Tue Dec 10 13:09:59 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,130 +0,0 @@
-/*
- *	include/linux/pc_keyb.h
- *
- *	PC Keyboard And Keyboard Controller
- *
- *	(c) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
- */
-
-/*
- *	Configuration Switches
- */
-
-#undef KBD_REPORT_ERR			/* Report keyboard errors */
-#define KBD_REPORT_UNKN			/* Report unknown scan codes */
-#define KBD_REPORT_TIMEOUTS		/* Report keyboard timeouts */
-#undef KBD_IS_FOCUS_9000		/* We have the brain-damaged FOCUS-9000 keyboard */
-#undef INITIALIZE_MOUSE			/* Define if your PS/2 mouse needs initialization. */
-
-
-
-#define KBD_INIT_TIMEOUT 1000		/* Timeout in ms for initializing the keyboard */
-#define KBC_TIMEOUT 250			/* Timeout in ms for sending to keyboard controller */
-#define KBD_TIMEOUT 1000		/* Timeout in ms for keyboard command acknowledge */
-
-/*
- *	Internal variables of the driver
- */
-
-extern unsigned char pckbd_read_mask;
-extern unsigned char aux_device_present;
-
-/*
- *	Keyboard Controller Registers on normal PCs.
- */
-
-#define KBD_STATUS_REG		0x64	/* Status register (R) */
-#define KBD_CNTL_REG		0x64	/* Controller command register (W) */
-#define KBD_DATA_REG		0x60	/* Keyboard data register (R/W) */
-
-/*
- *	Keyboard Controller Commands
- */
-
-#define KBD_CCMD_READ_MODE	0x20	/* Read mode bits */
-#define KBD_CCMD_WRITE_MODE	0x60	/* Write mode bits */
-#define KBD_CCMD_GET_VERSION	0xA1	/* Get controller version */
-#define KBD_CCMD_MOUSE_DISABLE	0xA7	/* Disable mouse interface */
-#define KBD_CCMD_MOUSE_ENABLE	0xA8	/* Enable mouse interface */
-#define KBD_CCMD_TEST_MOUSE	0xA9	/* Mouse interface test */
-#define KBD_CCMD_SELF_TEST	0xAA	/* Controller self test */
-#define KBD_CCMD_KBD_TEST	0xAB	/* Keyboard interface test */
-#define KBD_CCMD_KBD_DISABLE	0xAD	/* Keyboard interface disable */
-#define KBD_CCMD_KBD_ENABLE	0xAE	/* Keyboard interface enable */
-#define KBD_CCMD_WRITE_AUX_OBUF	0xD3    /* Write to output buffer as if
-					   initiated by the auxiliary device */
-#define KBD_CCMD_WRITE_MOUSE	0xD4	/* Write the following byte to the mouse */
-
-/*
- *	Keyboard Commands
- */
-
-#define KBD_CMD_SET_LEDS	0xED	/* Set keyboard leds */
-#define KBD_CMD_SET_RATE	0xF3	/* Set typematic rate */
-#define KBD_CMD_ENABLE		0xF4	/* Enable scanning */
-#define KBD_CMD_DISABLE		0xF5	/* Disable scanning */
-#define KBD_CMD_RESET		0xFF	/* Reset */
-
-/*
- *	Keyboard Replies
- */
-
-#define KBD_REPLY_POR		0xAA	/* Power on reset */
-#define KBD_REPLY_ACK		0xFA	/* Command ACK */
-#define KBD_REPLY_RESEND	0xFE	/* Command NACK, send the cmd again */
-
-/*
- *	Status Register Bits
- */
-
-#define KBD_STAT_OBF 		0x01	/* Keyboard output buffer full */
-#define KBD_STAT_IBF 		0x02	/* Keyboard input buffer full */
-#define KBD_STAT_SELFTEST	0x04	/* Self test successful */
-#define KBD_STAT_CMD		0x08	/* Last write was a command write (0=data) */
-#define KBD_STAT_UNLOCKED	0x10	/* Zero if keyboard locked */
-#define KBD_STAT_MOUSE_OBF	0x20	/* Mouse output buffer full */
-#define KBD_STAT_GTO 		0x40	/* General receive/xmit timeout */
-#define KBD_STAT_PERR 		0x80	/* Parity error */
-
-#define AUX_STAT_OBF (KBD_STAT_OBF | KBD_STAT_MOUSE_OBF)
-
-/*
- *	Controller Mode Register Bits
- */
-
-#define KBD_MODE_KBD_INT	0x01	/* Keyboard data generate IRQ1 */
-#define KBD_MODE_MOUSE_INT	0x02	/* Mouse data generate IRQ12 */
-#define KBD_MODE_SYS 		0x04	/* The system flag (?) */
-#define KBD_MODE_NO_KEYLOCK	0x08	/* The keylock doesn't affect the keyboard if set */
-#define KBD_MODE_DISABLE_KBD	0x10	/* Disable keyboard interface */
-#define KBD_MODE_DISABLE_MOUSE	0x20	/* Disable mouse interface */
-#define KBD_MODE_KCC 		0x40	/* Scan code conversion to PC format */
-#define KBD_MODE_RFU		0x80
-
-/*
- *	Mouse Commands
- */
-
-#define AUX_SET_RES		0xE8	/* Set resolution */
-#define AUX_SET_SCALE11		0xE6	/* Set 1:1 scaling */
-#define AUX_SET_SCALE21		0xE7	/* Set 2:1 scaling */
-#define AUX_GET_SCALE		0xE9	/* Get scaling factor */
-#define AUX_SET_STREAM		0xEA	/* Set stream mode */
-#define AUX_SET_SAMPLE		0xF3	/* Set sample rate */
-#define AUX_ENABLE_DEV		0xF4	/* Enable aux device */
-#define AUX_DISABLE_DEV		0xF5	/* Disable aux device */
-#define AUX_RESET		0xFF	/* Reset aux device */
-#define AUX_ACK			0xFA	/* Command byte ACK. */
-
-#define AUX_BUF_SIZE		2048	/* This might be better divisible by
-					   three to make overruns stay in sync
-					   but then the read function would need
-					   a lock etc - ick */
-
-struct aux_queue {
-	unsigned long head;
-	unsigned long tail;
-	wait_queue_head_t proc_list;
-	struct fasync_struct *fasync;
-	unsigned char buf[AUX_BUF_SIZE];
-};

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch7089
M'XL(`"=8]CT``\64T8K4,!2&KR=/$=@;1=HF;9*V@<JZNZ*P@L/(7DLV/=HZ
M;3(TZ>I*\-D-,SB.R^HRNF"2BW`2?LY_SI><X"L'DUQ\<OTX6N/0"7YMG9>+
MM?TZVO2)L0:>QN#*VAC,9C=E;M+9T)OY2]*;S>Q1/%TJKSM\`Y.3"YH6^XB_
MW8!<K%Z^NGKS8H50T^#S3IF/\`X\;AKD[72CAM:=*M\-UJ1^4L:-X%6J[1CV
M5T-.2!XGIV5!N`A4$%8&35M*%:/0DIQ5@J$?%DX/4[^C0G,:A4C)>"AX63)T
M@6E:B1J3/*-Q$4QSR;CD+"&5)`3?*XJ?49P0=(8?U\`YTO@"!O`@<6_T,+>P
M*W2VT>_7<'N==N@2%Z*L*%K^K"1*CAP($470\P>R_TT&AUYJ5@3*15V&MA)<
MT`HJJ$6M%;^_;N&L]Y<`&YBR=NNSS=*X2?;BW^[J'#2-,<*#*`@MMB`=+?4P
M</_D^#&T6=1F?`=E_BN23!+^9R3)_T-RUY6W.)D^;U=$;'E\@_Z"X_U'HSO0
4:S>/S8?K/#[L2J'O,WVZ;-D$````
`
end

