Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbTL2XQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTL2XQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:16:59 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:32835
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S265508AbTL2XQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:16:54 -0500
Date: Mon, 29 Dec 2003 18:16:53 -0500
From: Omkhar Arasaratnam <omkhar@rogers.com>
To: b.zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       kernel-janitors-disucss@lists.sf.net, trivial@rustcorp.com
Subject: [PATCH] drivers/ide/ide-probe.c MOD_INC/DEC_USE_COUNT fixup
Message-ID: <20031229231653.GA17346@omkhar.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.192.237.88] using ID <omkhar@rogers.com> at Mon, 29 Dec 2003 18:14:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor fixup to replace MOD_DEC_USE_COUNT/MOD_INC_USE_COUNT with module_put(THIS_MODULE)
and try_module_get(THIS_MODULE)

I am new are this so feel free to tell me if I have done something incorrectly.

This is mainly to clean up compiler #warnings since MOD_*_USE_COUNT macros are
depreciated in 2.6


--- linux-clean/drivers/ide/ide-probe.c.org	2003-12-29 18:06:21.000000000 -0500
+++ linux-clean/drivers/ide/ide-probe.c	2003-12-29 15:38:03.000000000 -0500
@@ -1323,7 +1323,7 @@
 	unsigned int index;
 	int probe[MAX_HWIFS];
 	
-	MOD_INC_USE_COUNT;
+	try_module_get(THIS_MODULE);
 	memset(probe, 0, MAX_HWIFS * sizeof(int));
 	for (index = 0; index < MAX_HWIFS; ++index)
 		probe[index] = !ide_hwifs[index].present;
@@ -1350,7 +1350,7 @@
 	}
 	if (!ide_probe)
 		ide_probe = &ideprobe_init;
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return 0;
 }


O
