Return-Path: <linux-kernel-owner+w=401wt.eu-S964851AbXADNU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXADNU7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbXADNU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:20:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:57306 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964851AbXADNU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:20:58 -0500
Date: Thu, 4 Jan 2007 14:20:53 +0100
From: Olaf Hering <olh@suse.de>
To: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix logic error in AIX detection
Message-ID: <20070104132053.GA24903@suse.de>
References: <20061206211630.GB27857@krispykreme> <20061206222213.GA17446@localhost.localdomain> <20070104084049.GA19959@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070104084049.GA19959@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct the AIX magic check to let 'echo > /dev/sdb' actually work.

Signed-off-by: Olaf Hering <olh@suse.de>

---
 fs/partitions/msdos.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.20-rc3/fs/partitions/msdos.c
===================================================================
--- linux-2.6.20-rc3.orig/fs/partitions/msdos.c
+++ linux-2.6.20-rc3/fs/partitions/msdos.c
@@ -68,10 +68,10 @@ static int aix_magic_present(unsigned ch
 	unsigned char *d;
 	int slot, ret = 0;
 
-	if (p[0] != AIX_LABEL_MAGIC1 &&
-		p[1] != AIX_LABEL_MAGIC2 &&
-		p[2] != AIX_LABEL_MAGIC3 &&
-		p[3] != AIX_LABEL_MAGIC4)
+	if (!(p[0] == AIX_LABEL_MAGIC1 &&
+		p[1] == AIX_LABEL_MAGIC2 &&
+		p[2] == AIX_LABEL_MAGIC3 &&
+		p[3] == AIX_LABEL_MAGIC4))
 		return 0;
 	/* Assume the partition table is valid if Linux partitions exists */
 	for (slot = 1; slot <= 4; slot++, pt++) {
