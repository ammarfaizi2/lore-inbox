Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUJKHyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUJKHyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268710AbUJKHyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:54:11 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:19369
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268709AbUJKHyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:54:05 -0400
Message-ID: <416A3C0A.9070606@ppp0.net>
Date: Mon, 11 Oct 2004 09:53:46 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040918 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gibbs@scsiguy.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: aic7xxx remove warnings
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts the aic7xxx driver to use module_param instead
of MODULE_PARM and therefore gets rid of two warning in the
non-modular build case.
Also I see there is lots of
#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)
checks in there. Would you accept a patch to remove those?

Thanks,

Jan


diff -u linus/drivers/scsi/aic7xxx/aic7xxx_osm.c pcirescan/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- linus/drivers/scsi/aic7xxx/aic7xxx_osm.c    2004-10-06 19:58:34.000000000 +0200
+++ pcirescan/drivers/scsi/aic7xxx/aic7xxx_osm.c        2004-10-11 09:48:10.000000000 +0200
@@ -449,7 +449,7 @@
 MODULE_DESCRIPTION("Adaptec Aic77XX/78XX SCSI Host Bus Adapter driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(AIC7XXX_DRIVER_VERSION);
-MODULE_PARM(aic7xxx, "s");
+module_param(aic7xxx, charp, 0444);
 MODULE_PARM_DESC(aic7xxx,
 "period delimited, options string.\n"
 "      verbose                 Enable verbose/diagnostic logging\n"
@@ -863,7 +863,6 @@
                return (0);
        }
        ahc_linux_size_nseg();
-#ifdef MODULE
        /*
         * If we've been passed any parameters, process them now.
         */
@@ -875,7 +874,6 @@
 "aic7xxx: to see the proper way to specify options to the aic7xxx module\n"
 "aic7xxx: Specifically, don't use any commas when passing arguments to\n"
 "aic7xxx: insmod or else it might trash certain memory areas.\n");
-#endif

 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)
        template->proc_name = "aic7xxx";
