Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263525AbTDMOhX (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTDMOhX (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:37:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:11489 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263525AbTDMOhW (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 10:37:22 -0400
Date: Sun, 13 Apr 2003 07:49:06 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 578] New: gdth driver unresolved symbols 
Message-ID: <244100000.1050245346@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=578

           Summary: gdth driver unresolved symbols
    Kernel Version: 2.5.67
            Status: NEW
          Severity: blocking
             Owner: andmike@us.ibm.com
         Submitter: hostmaster@taunusstein.net


Distribution: Debian Woody
Hardware Environment: All
Software Environment: All
Compiler: gcc 2.95.4

Problem Description:
unresolved symbols in gdth driver

Steps to reproduce:
.config contains
CONFIG_SCSI_GDTH=m

/sbin/depmod -ae -F System.map  2.5.67
shows
scsi_get_command and scsi_put_command
as unresolved

Solution:
Apply following patch:

--- linux-2.5.67/drivers/scsi/scsi_syms.c.orig  2003-04-13 08:40:04.794555992 +0200
+++ linux-2.5.67/drivers/scsi/scsi_syms.c       2003-04-13 08:41:09.093781024 +0200
@@ -78,6 +78,8 @@
 EXPORT_SYMBOL(scsi_slave_detach);
 EXPORT_SYMBOL(scsi_device_get);
 EXPORT_SYMBOL(scsi_device_put);
+EXPORT_SYMBOL(scsi_get_command);
+EXPORT_SYMBOL(scsi_put_command);
 EXPORT_SYMBOL(scsi_add_device);
 EXPORT_SYMBOL(scsi_remove_device);
 EXPORT_SYMBOL(scsi_set_device_offline);

driver compiles without any problems then.
aha152x driver may have same problem, but I did not verify that, because I do
not have such a SCSI card.


