Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268710AbRHFPDM>; Mon, 6 Aug 2001 11:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRHFPDD>; Mon, 6 Aug 2001 11:03:03 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:9744 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S268710AbRHFPCw>; Mon, 6 Aug 2001 11:02:52 -0400
Date: Mon, 6 Aug 2001 17:03:00 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] mxser broken since 2.4.5
Message-ID: <20010806170300.A10014@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.7-cvs20010804
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

The mxser driver (Moxar mutiple serial ports card) has been updated (and
broken) between the 2.4.4 and 2.4.5 kernels.
A doucle call of down() on a semaphore in mxser_write leads to a D state.

Please apply the attached patch.

Christophe

-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

--AWniW0JNca5xppdA
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="mxser.patch"

diff -u -b -B -r -N linux-2.4.7-vanilla/drivers/char/mxser.c linux-2.4.7/drivers/char/mxser.c
--- linux-2.4.7-vanilla/drivers/char/mxser.c	Wed May 16 19:31:27 2001
+++ linux-2.4.7/drivers/char/mxser.c	Mon Aug  6 16:55:13 2001
@@ -884,8 +884,6 @@
 	if (!tty || !info->xmit_buf || !mxvar_tmp_buf)
 		return (0);
 
-	if (from_user)
-		down(&mxvar_tmp_buf_sem);
 	save_flags(flags);
 	if (from_user) {
 		down(&mxvar_tmp_buf_sem);

--AWniW0JNca5xppdA--
