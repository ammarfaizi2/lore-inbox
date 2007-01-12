Return-Path: <linux-kernel-owner+w=401wt.eu-S1161173AbXALXlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161173AbXALXlg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbXALXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:41:36 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:39524 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161173AbXALXlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:41:35 -0500
Message-id: <304942792709111335@wsc.cz>
Subject: [PATCH 1/1] Char: mxser_new, fix sparc compile error
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat, 13 Jan 2007 00:41:34 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, fix sparc compile error

On sparc B4000000 is not defined. Use B2000000 for special baudrate, which
is defined on all platforms.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 2826e3a35f34046890c84a77bc2784a184f9bf6a
tree fcfd15b000e703d91361f2b2c3c1bafb0d18b05d
parent 1ed2feac68d7b7cd50ffcd28cb0830b435e7d120
author Jiri Slaby <jirislaby@gmail.com> Sat, 13 Jan 2007 00:27:05 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 13 Jan 2007 00:27:05 +0059

 drivers/char/mxser_new.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 1997390..4c80549 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -189,6 +189,8 @@ static unsigned int mxvar_baud_table1[] = {
 };
 #define BAUD_TABLE_NO ARRAY_SIZE(mxvar_baud_table)
 
+#define B_SPEC	B2000000
+
 static int ioaddr[MXSER_BOARDS] = { 0, 0, 0, 0 };
 static int ttymajor = MXSERMAJOR;
 static int calloutmajor = MXSERCUMAJOR;
@@ -544,7 +546,7 @@ static int mxser_change_speed(struct mxser_port *info,
 		return ret;
 
 	if (mxser_set_baud_method[info->tty->index] == 0) {
-		if ((cflag & (CBAUD | CBAUDEX)) == B4000000)
+		if ((cflag & CBAUD) == B_SPEC)
 			baud = info->speed;
 		else
 			baud = tty_get_baud_rate(info->tty);
@@ -1700,7 +1702,7 @@ static int mxser_ioctl(struct tty_struct *tty, struct file *file,
 			if (speed == mxvar_baud_table[i])
 				break;
 		if (i == BAUD_TABLE_NO) {
-			info->tty->termios->c_cflag |= B4000000;
+			info->tty->termios->c_cflag |= B_SPEC;
 		} else if (speed != 0)
 			info->tty->termios->c_cflag |= mxvar_baud_table1[i];
 
