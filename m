Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWIIPhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWIIPhX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWIIPhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:37:23 -0400
Received: from outmx021.isp.belgacom.be ([195.238.4.202]:61607 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932273AbWIIPhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:37:20 -0400
Subject: [PATCH] alim15x3.c: M5229 (rev c8) support for DMA cd-writer
From: Michael De Backer <micdb@skynet.be>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, akpm@osdl.org
Content-Type: text/plain
Date: Sat, 09 Sep 2006 17:37:01 +0200
Message-Id: <1157816221.5998.51.camel@mws.local.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael De Backer <micdb@skynet.be>

Configuration bits are not set properly for DMA on some chipset
revisions. It has already been corrected for M5229 (rev c7) but not for
M5229 (rev c8). This leads to the bug described at
http://bugzilla.kernel.org/show_bug.cgi?id=5786 (lost interrupt + ide
bus hangs).

Signed-off-by: Michael De Backer <micdb@skynet.be>
---
This has been tested on ASUS A8R32-MVP motherboard (M5229 c8) with
2.6.18-rc6, 2.6.18-rc6-mm1, 2.6.18-rc5-mm1, 2.6.17.10 and two different
cd-writers. It completely solves the problem. 

The following patch is against the 2.6.18-rc6 or 2.6.18-rc6-mm1 kernel:

--- linux/drivers/ide/pci/alim15x3.c.orig       2006-09-09
16:07:07.000000000 +0200
+++ linux/drivers/ide/pci/alim15x3.c    2006-09-09 16:08:25.000000000
+0200
@@ -730,7 +730,7 @@ static unsigned int __devinit ata66_ali1

	if(m5229_revision <= 0x20)
		tmpbyte = (tmpbyte & (~0x02)) | 0x01;
-       else if (m5229_revision == 0xc7)
+       else if (m5229_revision == 0xc7 || 0xc8)
		tmpbyte |= 0x03;
	else
		tmpbyte |= 0x01;

