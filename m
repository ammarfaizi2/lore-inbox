Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSLMQev>; Fri, 13 Dec 2002 11:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSLMQev>; Fri, 13 Dec 2002 11:34:51 -0500
Received: from comtv.ru ([217.10.32.4]:35500 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S265099AbSLMQeu>;
	Fri, 13 Dec 2002 11:34:50 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] minor bug fix in sym53c8xx_2
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 13 Dec 2002 19:36:08 +0300
Message-ID: <m37kedzxjb.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day!

There is minor bug in sym53c8xx_2. Because of it you may not
exclude some HBA from scanning. Thus, kernel parameter
sym53c8xx=excl:0xe400 won't work. Please, apply path:

--- linux-2.5.51/drivers/scsi/sym53c8xx_2/sym_glue.c	Fri Dec 13 19:30:27 2002
+++ linux-2.5.51n/drivers/scsi/sym53c8xx_2/sym_glue.c	Fri Dec 13 19:23:48 2002
@@ -2481,7 +2487,8 @@
 	 */
 	if (base_io) {
 		for (i = 0 ; i < 8 ; i++) {
-			if (sym_driver_setup.excludes[i] == base_io)
+			if (sym_driver_setup.excludes[i] ==
+			    (base_io & PCI_BASE_ADDRESS_IO_MASK))
 				return -1;
 		}
 	}

sym53c8xx_2 in 2.4 has this bug too and this patch may by applied.

