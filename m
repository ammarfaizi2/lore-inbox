Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275268AbTHAS1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275272AbTHAS1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:27:09 -0400
Received: from lug.gage.org ([66.92.48.36]:48904 "EHLO lug.gage.org")
	by vger.kernel.org with ESMTP id S275268AbTHAS1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:27:06 -0400
Date: Fri, 1 Aug 2003 11:27:04 -0700
From: jeff <jeff-lk@gerard.st>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org, torvalds@osdl.org
Subject: [PATCH, trivial] dmesg ambiguity: CD/DVD
Message-ID: <20030801182704.GS15405@gage.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi-

i just spent too long barking up the wrong tree, wondering why i
couldn't read DVD+R discs in a read-only drive that look like this in dmesg:

% dmesg | grep hdc                                       ~
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
    hdc: Lite-On LTN486S 48x Max, ATAPI CD/DVD-ROM drive
                                        ^^^^^^^^^^
    hdc: attached ide-cdrom driver.
    hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)

why was i having trouble? because this drive does not read DVD-ROMs! now
i know to ignore the second line and pay attention to the last one, but
really, let us fix this ambiguity. "CD/DVD" seems commonly used to refer
to drives which read both formats- let's change this to "optical disc"
or "CD and/or DVD" for clarity. patchette follows. 

jeff


--- linux-2.4.21.orig/drivers/ide/ide-probe.c   2003-08-01 10:55:56.000000000 -0700
+++ linux-2.4.21/drivers/ide/ide-probe.c        2003-08-01 10:58:08.000000000 -0700
@@ -215,7 +215,7 @@
                                        break;
                                }
 #endif
-                               printk ("CD/DVD-ROM");
+                               printk ("optical disc");
                                break;
                        case ide_tape:
                                printk ("TAPE");
