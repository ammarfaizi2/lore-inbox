Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVANTIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVANTIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVANTGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:06:31 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:34512 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261392AbVANS4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:56:47 -0500
Date: Fri, 14 Jan 2005 19:56:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/8] s390: use nonseekable_open in z/VM log reader.
Message-ID: <20050114185641.GH6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/8] s390: use nonseekable_open in z/VM log reader.

From: Stefan Bader <shbader@de.ibm.com>

Disable seek on z/VM log reader misc device by using
nonseekable_open().

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/char/vmlogrdr.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urN linux-2.6/drivers/s390/char/vmlogrdr.c linux-2.6-patched/drivers/s390/char/vmlogrdr.c
--- linux-2.6/drivers/s390/char/vmlogrdr.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6-patched/drivers/s390/char/vmlogrdr.c	2005-01-14 19:45:22.000000000 +0100
@@ -403,7 +403,7 @@
 		goto not_connected;
 	}
 
-	return 0;
+ 	return nonseekable_open(inode, filp);
 
 not_connected:
 	iucv_unregister_program(logptr->iucv_handle);
