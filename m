Return-Path: <linux-kernel-owner+w=401wt.eu-S1754727AbXAAX2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbXAAX2q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXAAX2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:28:46 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:54603 "EHLO
	ppsw-2.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbXAAX2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:28:45 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 1 Jan 2007 23:28:42 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] Export invalidate_mapping_pages() to modules.
Message-ID: <Pine.LNX.4.64.0701012322050.1218@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus and Andrew,

Please apply below patch which exports invalidate_mapping_pages() to 
modules.  It makes no sense to me to export invalidate_inode_pages() and 
not invalidate_mapping_pages() and I actually need 
invalidate_mapping_pages() because of its range specification ability...

It would be great if this could make it into 2.6.20!

Thanks a lot in advance!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/

---

Export invalidate_mapping_pages() to modules.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
---

diff --git a/mm/truncate.c b/mm/truncate.c
index ecdfdcc..26acee6 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -303,6 +303,7 @@ unlock:
 	}
 	return ret;
 }
+EXPORT_SYMBOL(invalidate_mapping_pages);
 
 unsigned long invalidate_inode_pages(struct address_space *mapping)
 {
