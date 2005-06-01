Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFAUMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFAUMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFAUMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:12:03 -0400
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:64931 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261201AbVFAUKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:10:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=2Xze9nrv9avqlYD3YRyIZ8kmww9L+9UhOVbRzq/YBOB65X52hSpy195iMf/cz6sGMYrEB2kktEFfNd3IxNhtVYEWE1roHKmDfmY1q17LQ9TN+YGYcFcwHYxZr0SV/WkovFaDH30MU83SkYs1wxwS9WcqyG5CUaIey+4x+jX/O1g=  ;
Message-ID: <429E162E.1000908@yahoo.com>
Date: Wed, 01 Jun 2005 13:10:22 -0700
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@lst.de>
Subject: [ANNOUNCE 7/7] Open-iSCSI/Linux-iSCSI-5 High-Performance Initiator:
 iscsi-Kconfig.patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	iscsi-Kconfig.patch - drivers/scsi/Kconfig changes.

	Signed-off-by: Alex Aizman <itn780@yahoo.com>
	Signed-off-by: Dmitry Yusupov <dmitry_yus@yahoo.com>
	Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

Index: drivers/scsi/Kconfig
===================================================================
--- 7570fde464d579ce455c865f07a613e967e9396c/drivers/scsi/Kconfig  (mode:100644 sha1:750b11cefd934349480d6237f6df564edf6d297b)
+++ uncommitted/drivers/scsi/Kconfig  (mode:100644)
@@ -205,12 +205,35 @@
 
 config SCSI_ISCSI_ATTRS
 	tristate "iSCSI Transport Attributes"
-	depends on SCSI
+	depends on SCSI && NET
 	help
 	  If you wish to export transport-specific information about
 	  each attached iSCSI device to sysfs, say Y.
 	  Otherwise, say N.
 
+config ISCSI_TCP
+	tristate "iSCSI Initiator over TCP/IP"
+	depends on SCSI && INET && SCSI_ISCSI_ATTRS
+	select CRYPTO
+	select CRYPTO_MD5
+	select CRYPTO_CRC32C
+	help
+	 The iSCSI Driver provides a host with the ability to access storage
+	 through an IP network. The driver uses the iSCSI protocol to transport
+	 SCSI requests and responses over a TCP/IP network between the host
+	 (the "initiator") and "targets".  Architecturally, the iSCSI driver
+	 combines with the host's TCP/IP stack, network drivers, and Network
+	 Interface Card (NIC) to provide the same functions as a SCSI or a
+	 Fibre Channel (FC) adapter driver with a Host Bus Adapter (HBA).
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called iscsi_tcp.
+
+	 The userspace component needed to initialize the driver, documentation,
+	 and sample configuration files can be found here:
+
+	 http://linux-iscsi.sf.net
+
 endmenu
 
 menu "SCSI low-level drivers"



