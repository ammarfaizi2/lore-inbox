Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVH1LYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVH1LYh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 07:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVH1LYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 07:24:37 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:51557 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751135AbVH1LYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 07:24:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EfeykpVitSu6NT5fUBi7GLwwVqno0tr6FIsMNWEK0DX6rOUdYCH+xV7OH7ntzPJMZ+8cPOOIQ3eeqLzWl6sExNXHIcWaxDBdNa3+wdm62erOe48NJ85wfareDgoW1o0Nn0NMBOi4clxqCH01np2S604j8F8GaslTZf9L/LoaS1M=
Date: Sun, 28 Aug 2005 15:33:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andreas Herrmann <aherrman@de.ibm.com>
Cc: James Bottomley <jejb@steeleye.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] zfcp: fix compilation due to rports changes
Message-ID: <20050828113353.GA7665@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

struct zfcp_port::scsi_id was removed by commit
3859f6a248cbdfbe7b41663f3a2b51f48e30b281

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/s390/scsi/zfcp_sysfs_port.c |    2 --
 1 files changed, 2 deletions(-)

--- linux-vanilla/drivers/s390/scsi/zfcp_sysfs_port.c
+++ linux-zfcp/drivers/s390/scsi/zfcp_sysfs_port.c
@@ -67,7 +67,6 @@ static DEVICE_ATTR(_name, S_IRUGO, zfcp_
 ZFCP_DEFINE_PORT_ATTR(status, "0x%08x\n", atomic_read(&port->status));
 ZFCP_DEFINE_PORT_ATTR(wwnn, "0x%016llx\n", port->wwnn);
 ZFCP_DEFINE_PORT_ATTR(d_id, "0x%06x\n", port->d_id);
-ZFCP_DEFINE_PORT_ATTR(scsi_id, "0x%x\n", port->scsi_id);
 ZFCP_DEFINE_PORT_ATTR(in_recovery, "%d\n", atomic_test_mask
 		      (ZFCP_STATUS_COMMON_ERP_INUSE, &port->status));
 ZFCP_DEFINE_PORT_ATTR(access_denied, "%d\n", atomic_test_mask
@@ -263,7 +262,6 @@ static struct attribute_group zfcp_port_
 static struct attribute *zfcp_port_no_ns_attrs[] = {
 	&dev_attr_unit_add.attr,
 	&dev_attr_unit_remove.attr,
-	&dev_attr_scsi_id.attr,
 	NULL
 };
 

