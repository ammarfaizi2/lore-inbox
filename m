Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUA0WGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265634AbUA0WGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:06:30 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:16302 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265594AbUA0WGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:06:25 -0500
To: marcelo.tosatti@cyclades.com
Cc: lkml <linux-kernel@vger.kernel.org>, kkeil@suse.de,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de
Subject: [TRIVIAL PATCH] 2.4 make dep and hisax/Makefile md5sum warning fix
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 27 Jan 2004 22:13:19 +0100
Message-ID: <m3y8rtccy8.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

The following patch suppresses the "md5sum: WARNING: 1 of 13 computed
checksums did NOT match" warning from make dep.

The "md5sum -c" status is still used by the drivers (some certification
requirement for ISDN equipment in Germany).

Unless they are objections please apply to 2.4 kernel tree. Thanks.
-- 
Krzysztof Halasa, B*FH

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hisax-md5sum-2.4.25pre7.patch

--- linux-2.4.orig/drivers/isdn/hisax/Makefile	2003-06-13 16:51:34.000000000 +0200
+++ linux-2.4/drivers/isdn/hisax/Makefile	2004-01-27 22:05:31.000000000 +0100
@@ -66,7 +66,7 @@
 obj-$(CONFIG_HISAX_FRITZ_PCIPNP)        += hisax_isac.o hisax_fcpcipnp.o
 obj-$(CONFIG_USB_AUERISDN)	        += isdnhdlc.o
 
-CERT := $(shell md5sum -c md5sums.asc >> /dev/null;echo $$?)
+CERT := $(shell md5sum --status -c md5sums.asc >> /dev/null;echo $$?)
 CFLAGS_cert.o := -DCERTIFICATION=$(CERT)
 
 include $(TOPDIR)/Rules.make

--=-=-=--
