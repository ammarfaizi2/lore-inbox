Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268658AbUI3Jzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268658AbUI3Jzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 05:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268695AbUI3Jzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 05:55:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:1448 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S268658AbUI3Jza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 05:55:30 -0400
Date: Thu, 30 Sep 2004 11:55:28 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/isdn/i4l/isdn_tty.c in BK HEAD doesn't compile
Message-ID: <20040930095528.GA19457@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello everyone,

(excalibur) [/scratch/src/excalibur] make
  CHK     include/linux/version.h
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      drivers/isdn/i4l/isdn_tty.o
drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_modem_result':
drivers/isdn/i4l/isdn_tty.c:2676: error: `tty' undeclared (first use in this function)
drivers/isdn/i4l/isdn_tty.c:2676: error: (Each undeclared identifier is reported only once
drivers/isdn/i4l/isdn_tty.c:2676: error: for each function it appears in.)
make[3]: *** [drivers/isdn/i4l/isdn_tty.o] Error 1
make[2]: *** [drivers/isdn/i4l] Error 2
make[1]: *** [drivers/isdn] Error 2
make: *** [drivers] Error 2


patch applied.

	Thomas

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

===== drivers/isdn/i4l/isdn_tty.c 1.60 vs edited =====
--- 1.60/drivers/isdn/i4l/isdn_tty.c	2004-09-29 17:02:20 +02:00
+++ edited/drivers/isdn/i4l/isdn_tty.c	2004-09-30 11:49:48 +02:00
@@ -2673,7 +2673,7 @@
 		if ((info->flags & ISDN_ASYNC_CLOSING) || (!info->tty)) {
 			return;
 		}
-		tty_ldisc_flush(tty);
+		tty_ldisc_flush(info->tty);
 		if ((info->flags & ISDN_ASYNC_CHECK_CD) &&
 		    (!((info->flags & ISDN_ASYNC_CALLOUT_ACTIVE) &&
 		       (info->flags & ISDN_ASYNC_CALLOUT_NOHUP)))) {

--mYCpIKhGyMATD0i+--
