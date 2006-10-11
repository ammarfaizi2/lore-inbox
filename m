Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161480AbWJKVNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161480AbWJKVNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWJKVNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:13:51 -0400
Received: from av1.karneval.cz ([81.27.192.123]:9749 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S1161486AbWJKVNr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:13:47 -0400
Message-id: <32432223423423@karneval.cz>
Subject: [PATCH 2/4] Char: mxser_new, delete ttys and termios
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 11 Oct 2006 23:13:44 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, delete ttys and termios

- Driver uses global tty_struct array, which tries to assign to the
  tty_driver's ttys.
- the very same thing for termios
- the same for termios_locked

Kill such constructions.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

---
commit 5c3719e8b660b2813c8db5bec5a963d2702ad4fc
tree 73d93200d43e7175e1ef804101b40cdeb0266362
parent 945bdc94338eb55b6c4dd1198357abb5acb93dd4
author Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 21:24:45 +0200
committer Jiri Slaby <jirislaby@gmail.com> Wed, 11 Oct 2006 21:24:45 +0200

 drivers/char/mxser_new.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index d9e5400..8026047 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -313,9 +313,6 @@ static int mxserBoardCAP[MXSER_BOARDS] =
 
 static struct mxser_board mxser_boards[MXSER_BOARDS];
 static struct tty_driver *mxvar_sdriver;
-static struct tty_struct *mxvar_tty[MXSER_PORTS + 1];
-static struct termios *mxvar_termios[MXSER_PORTS + 1];
-static struct termios *mxvar_termios_locked[MXSER_PORTS + 1];
 static struct mxser_log mxvar_log;
 static int mxvar_diagflag;
 static unsigned char mxser_msr[MXSER_PORTS + 1];
@@ -2652,9 +2649,6 @@ static int __init mxser_module_init(void
 	mxvar_sdriver->init_termios.c_cflag = B9600|CS8|CREAD|HUPCL|CLOCAL;
 	mxvar_sdriver->flags = TTY_DRIVER_REAL_RAW|TTY_DRIVER_DYNAMIC_DEV;
 	tty_set_operations(mxvar_sdriver, &mxser_ops);
-	mxvar_sdriver->ttys = mxvar_tty;
-	mxvar_sdriver->termios = mxvar_termios;
-	mxvar_sdriver->termios_locked = mxvar_termios_locked;
 
 	retval = tty_register_driver(mxvar_sdriver);
 	if (retval) {
