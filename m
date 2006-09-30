Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWI3Wdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWI3Wdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWI3Wdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:33:41 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:48769 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751551AbWI3Wdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:33:40 -0400
Message-id: <81721356982173@wsc.cz>
Subject: [PATCH 1/4] Char: mxser_new, kill unneeded memsets
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Sun,  1 Oct 2006 00:33:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, kill unneeded memsets

There is no need to re-zero static global variables' memory, hence memsets
doing this are useless.
alloc_tty_struct also zeroes allocated memory: another candidate for
removing.
This fixes also a bug -- global structures are cleaned up after
initialization of some its parts.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e3d57eae41e172fbd6195a78532f3325b2441450
tree b1c17a897e53fa8fa217f1ea809659b9ff462718
parent 309f84ccd85a12c363b7ceb60139bcf2fabefbd7
author Jiri Slaby <jirislaby@gmail.com> Sat, 30 Sep 2006 00:10:08 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 30 Sep 2006 00:10:08 +0200

 drivers/char/mxser_new.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index f93d438..1a6a3aa 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -697,7 +697,6 @@ static int mxser_init(void)
 		MXSER_VERSION);
 
 	/* Initialize the tty_driver structure */
-	memset(mxvar_sdriver, 0, sizeof(struct tty_driver));
 	mxvar_sdriver->magic = TTY_DRIVER_MAGIC;
 	mxvar_sdriver->name = "ttyM";
 	mxvar_sdriver->major = ttymajor;
@@ -714,12 +713,6 @@ static int mxser_init(void)
 	mxvar_sdriver->termios_locked = mxvar_termios_locked;
 
 	mxvar_diagflag = 0;
-	memset(mxser_boards, 0, sizeof(mxser_boards));
-	memset(&mxvar_log, 0, sizeof(struct mxser_log));
-
-	memset(&mxser_msr, 0, sizeof(unsigned char) * (MXSER_PORTS + 1));
-	memset(&mon_data_ext, 0, sizeof(struct mxser_mon_ext));
-	memset(&mxser_set_baud_method, 0, sizeof(int) * (MXSER_PORTS + 1));
 
 	m = 0;
 	/* Start finding ISA boards here */
