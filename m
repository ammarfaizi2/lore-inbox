Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUFADO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUFADO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 23:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbUFADO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 23:14:57 -0400
Received: from handhelds.org ([192.58.209.91]:23005 "EHLO handhelds.org")
	by vger.kernel.org with ESMTP id S261576AbUFADOz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 23:14:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: George France <france@handhelds.org>
To: Cpqarray-discuss@lists.sourceforge.net
Subject: [Patch] - 2.6.6 - cpqarray.c - trivial
Date: Mon, 31 May 2004 23:10:08 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200405312310.08754.france@handhelds.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just upgrade my Compaq Prolient Server to 2.6.x.  This system is mostly
a http server and does not have a keyboard or mouse attached.  This
system hangs on reboot, when generating SSL keys due to /dev/random
having zero entropy.

It is my understanding that /dev/random uses the keyboard, mouse and
block devices to generate entropy.  Since this system does not have a
keyboard or mouse, I am having to rely upon the cpqarray (block) driver
for entropy.  It appears that in the 2.4.x kernel somebody added the
SA_SAMPLE_RANDOM flag to request_irq() in cpqarray.c to fix this
problem.  Below is a patch against 2.6.6, which corrects this issue.

Best Regards,


--George

--- linux-2.6.6/drivers/block/cpqarray.c-orig   2004-05-31 22:54:35.000000000 -0400
+++ linux-2.6.6/drivers/block/cpqarray.c        2004-05-31 22:56:07.000000000 -0400
@@ -418,7 +418,7 @@
        }
        hba[i]->access.set_intr_mask(hba[i], 0);
        if (request_irq(hba[i]->intr, do_ida_intr,
-               SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
+               SA_INTERRUPT|SA_SHIRQ|SA_SAMPLE_RANDOM, hba[i]->devname, hba[i]))
        {
                printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n",
                                hba[i]->intr, hba[i]->devname);

