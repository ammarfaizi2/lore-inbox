Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTKFMF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 07:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTKFMF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 07:05:56 -0500
Received: from linux-bt.org ([217.160.111.169]:36756 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S263537AbTKFMFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 07:05:37 -0500
Subject: Re: 2.4 Firmware Loader does not work builtin
From: Marcel Holtmann <marcel@holtmann.org>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubert Mantel <mantel@suse.de>
In-Reply-To: <5.1.0.14.2.20031106114658.00a881f8@pop.t-online.de>
References: <5.1.0.14.2.20031106114658.00a881f8@pop.t-online.de>
Content-Type: multipart/mixed; boundary="=-shS501ordsxa50wfSTef"
Message-Id: <1068120313.25167.55.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 13:05:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-shS501ordsxa50wfSTef
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Margit,

> Either it is not supposed to work builtin, in which case, the make
> should only offer it as a module, - or , somebody forgot to adjust
> lib/Makefile and kernel/ksyms.c

the attached patch should fix this problem. Please confirm it and I
resend it to Marcelo.

Regards

Marcel


--=-shS501ordsxa50wfSTef
Content-Disposition: attachment; filename=patch-2.4.23-pre9-fix-builtin-fw-loader
Content-Type: text/x-patch; name=patch-2.4.23-pre9-fix-builtin-fw-loader; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -urN linux-2.4.23-pre9/kernel/ksyms.c linux-2.4.23-pre9-mh/kernel/ksyms.c
--- linux-2.4.23-pre9/kernel/ksyms.c	Thu Nov  6 12:55:27 2003
+++ linux-2.4.23-pre9-mh/kernel/ksyms.c	Thu Nov  6 12:57:17 2003
@@ -49,6 +49,7 @@
 #include <linux/seq_file.h>
 #include <linux/dnotify.h>
 #include <linux/crc32.h>
+#include <linux/firmware.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -572,6 +573,13 @@
 EXPORT_SYMBOL(crc32_le);
 EXPORT_SYMBOL(crc32_be);
 EXPORT_SYMBOL(bitreverse);
+#endif
+
+#ifdef CONFIG_FW_LOADER
+EXPORT_SYMBOL(release_firmware);
+EXPORT_SYMBOL(request_firmware);
+EXPORT_SYMBOL(request_firmware_nowait);
+EXPORT_SYMBOL(register_firmware);
 #endif
 
 /* software interrupts */
diff -urN linux-2.4.23-pre9/lib/firmware_class.c linux-2.4.23-pre9-mh/lib/firmware_class.c
--- linux-2.4.23-pre9/lib/firmware_class.c	Thu Nov  6 12:55:27 2003
+++ linux-2.4.23-pre9-mh/lib/firmware_class.c	Thu Nov  6 12:56:11 2003
@@ -565,7 +565,9 @@
 module_init(firmware_class_init);
 module_exit(firmware_class_exit);
 
+#ifndef CONFIG_FW_LOADER
 EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
 EXPORT_SYMBOL(register_firmware);
+#endif

--=-shS501ordsxa50wfSTef--

