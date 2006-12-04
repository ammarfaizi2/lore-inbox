Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936938AbWLDOwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936938AbWLDOwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936934AbWLDOwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:52:24 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:8629 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S936938AbWLDOwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:52:22 -0500
Date: Mon, 4 Dec 2006 15:52:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] Add MODALIAS= to the uevent for the ap bus.
Message-ID: <20061204145210.GJ32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] Add MODALIAS= to the uevent for the ap bus.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/crypto/ap_bus.c linux-2.6-patched/drivers/s390/crypto/ap_bus.c
--- linux-2.6/drivers/s390/crypto/ap_bus.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/ap_bus.c	2006-12-04 14:50:40.000000000 +0100
@@ -431,7 +431,15 @@ static int ap_uevent (struct device *dev
 			   ap_dev->device_type);
 	if (buffer_size - length <= 0)
 		return -ENOMEM;
-	envp[1] = 0;
+	buffer += length;
+	buffer_size -= length;
+	/* Add MODALIAS= */
+	envp[1] = buffer;
+	length = scnprintf(buffer, buffer_size, "MODALIAS=ap:t%02X",
+			   ap_dev->device_type);
+	if (buffer_size - length <= 0)
+		return -ENOMEM;
+	envp[2] = NULL;
 	return 0;
 }
 
