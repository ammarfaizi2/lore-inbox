Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbTJWP2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbTJWP2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:28:55 -0400
Received: from [62.81.235.112] ([62.81.235.112]:55766 "EHLO smtp12.eresmas.com")
	by vger.kernel.org with ESMTP id S263592AbTJWP2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:28:47 -0400
Message-ID: <3F97F35D.30101@wanadoo.es>
Date: Thu, 23 Oct 2003 17:27:25 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: [patch] 2.4.23-pre8: link error with both megaraid drivers
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070706090603000102060209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070706090603000102060209
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:

> The patch below fixes this issue by disalllowing the static inclusion of
> both drivers at the same time.

IMO this patch makes a better job. It only allows one in kernel,
and it allows two modules at same time.

xconfig and menuconfig work ok.

-thanks-
--
HTML mails are going to trash automatically

--------------070706090603000102060209
Content-Type: text/plain;
 name="config-megaraid.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config-megaraid.diff"

--- linux/drivers/scsi/Config.in	2003-10-23 16:56:13.000000000 +0200
+++ new/drivers/scsi/Config.in	2003-10-23 17:00:51.000000000 +0200
@@ -66,8 +66,14 @@
 dep_tristate 'AdvanSys SCSI support' CONFIG_SCSI_ADVANSYS $CONFIG_SCSI
 dep_tristate 'Always IN2000 SCSI support' CONFIG_SCSI_IN2000 $CONFIG_SCSI
 dep_tristate 'AM53/79C974 PCI SCSI support' CONFIG_SCSI_AM53C974 $CONFIG_SCSI $CONFIG_PCI
-dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
-dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+
+if [ "$CONFIG_SCSI_MEGARAID2" != "y" ]; then
+	dep_tristate 'AMI MegaRAID support' CONFIG_SCSI_MEGARAID $CONFIG_SCSI
+fi
+
+if [ "$CONFIG_SCSI_MEGARAID" != "y" ]; then
+	dep_tristate 'AMI MegaRAID2 support' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
+fi
 
 dep_tristate 'BusLogic SCSI support' CONFIG_SCSI_BUSLOGIC $CONFIG_SCSI
 if [ "$CONFIG_SCSI_BUSLOGIC" != "n" ]; then


--------------070706090603000102060209--

