Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVA0Xnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVA0Xnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVA0Xna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:43:30 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:47789 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261307AbVA0Xbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:31:31 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, cristoph@lameter.com, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050127233130.23569.78063.12414@localhost.localdomain>
In-Reply-To: <20050127233053.23569.16444.60993@localhost.localdomain>
References: <20050127233053.23569.16444.60993@localhost.localdomain>
Subject: [PATCH 5/8] pcxx: Remove drivers/char/pcxx.h
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [70.16.225.90] at Thu, 27 Jan 2005 17:31:30 -0600
Date: Thu, 27 Jan 2005 17:31:31 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes drivers/char/pcxx.h

It depends on the previous patches.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc2-mm1-original/drivers/char/pcxx.h linux-2.6.11-rc2-mm1/drivers/char/pcxx.h
--- linux-2.6.11-rc2-mm1-original/drivers/char/pcxx.h	2005-01-24 17:15:55.000000000 -0500
+++ linux-2.6.11-rc2-mm1/drivers/char/pcxx.h	1969-12-31 19:00:00.000000000 -0500
@@ -1,128 +0,0 @@
-#define FEPCODESEG  0x0200L
-#define FEPCODE     0x2000L
-#define BIOSCODE    0xf800L
-
-#define MISCGLOBAL  0x0C00L
-#define NPORT       0x0C22L
-#define MBOX        0x0C40L
-#define PORTBASE    0x0C90L
-
-#define FEPCLR      0x00
-#define FEPMEM      0x02
-#define FEPRST      0x04
-#define FEPINT      0x08
-#define	FEPMASK     0x0e
-#define	FEPWIN      0x80
-
-/* Maximum Number of Boards supported */
-#define MAX_DIGI_BOARDS 4
-
-#define PCXX_NUM_TYPES	4
-
-#define PCXI		0
-#define PCXE		1
-#define	PCXEVE		2
-#define PCXEM		3
-
-static char *board_desc[] = {
-	"PC/Xi",
-	"PC/Xe",
-	"PC/Xeve",
-	"PC/Xem",
-};
-
-static char *board_mem[] = {
-	"64k",
-	"64k",
-	"8k",
-	"32k",
-};
-#define STARTC      021
-#define STOPC       023
-#define IAIXON      0x2000
-
-
-struct board_info	{
-	unchar status;
-	unchar type;
-	unchar altpin;
-	ushort numports;
-	ushort port;
-	ulong  membase;
-	ulong  memsize;
-	ushort first_minor;
-	void *region;
-};
-
-
-#define TXSTOPPED   0x01
-#define LOWWAIT		0x02
-#define EMPTYWAIT	0x04
-#define RXSTOPPED	0x08
-#define TXBUSY		0x10
-
-#define DISABLED   0
-#define ENABLED    1
-#define OFF        0
-#define ON         1
-
-#define FEPTIMEOUT 200000  
-#define SERIAL_TYPE_NORMAL	1
-#define PCXE_EVENT_HANGUP   1
-#define PCXX_MAGIC	0x5c6df104L
-
-struct channel {
-							/* --------- Board/channel information ---------- */
-	long						magic;
-	unchar						boardnum;
-	unchar						channelnum;
-	uint						dev;
-	struct tty_struct			*tty;
-	struct board_info			*board;
-	volatile struct board_chan	*brdchan;
-	volatile struct global_data *mailbox;
-	int							asyncflags;
-	int							count;
-	int							blocked_open;
-	int							close_delay;
-	unsigned long						event;
-	wait_queue_head_t			open_wait;
-	wait_queue_head_t			close_wait;
-	struct work_struct			tqueue;
-							/* ------------ Async control data ------------- */
-	unchar						modemfake;      /* Modem values to be forced */
-	unchar						modem;          /* Force values */
-	ulong						statusflags;
-	unchar						omodem;         /* FEP output modem status */
-	unchar						imodem;         /* FEP input modem status */
-	unchar						hflow;
-	unchar						dsr;
-	unchar						dcd;
-	unchar						stopc;
-	unchar						startc;
-	unchar						stopca;
-	unchar						startca;
-	unchar						fepstopc;
-	unchar						fepstartc;
-	unchar						fepstopca;
-	unchar						fepstartca;
-	ushort						fepiflag;
-	ushort						fepcflag;
-	ushort						fepoflag;
-							/* ---------- Transmit/receive system ---------- */
-	unchar						txwin;
-	unchar						rxwin;
-	ushort						txbufsize;
-	ushort						rxbufsize;
-	unchar						*txptr;
-	unchar						*rxptr;
-	unchar						*tmp_buf;		/* Temp buffer */
-	struct semaphore				tmp_buf_sem;
-							/* ---- Termios data ---- */
-	ulong						c_iflag;
-	ulong						c_cflag;
-	ulong						c_lflag;
-	ulong						c_oflag;
-	struct digi_struct			digiext;
-	ulong						dummy[8];
-};
