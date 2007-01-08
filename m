Return-Path: <linux-kernel-owner+w=401wt.eu-S1030503AbXAHTPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbXAHTPv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbXAHTPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:15:51 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:13363 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030503AbXAHTPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:15:50 -0500
Date: Mon, 8 Jan 2007 20:16:41 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Patch 1/2] driver core: Remove device_is_registered() in
 device_move().
Message-ID: <20070108201641.141b2240@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

device_is_registered() will always be false for a device with no bus. Remove
this check and trust the caller to know what they're doing.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/core.c |    4 ----
 1 files changed, 4 deletions(-)

--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -1066,10 +1066,6 @@ int device_move(struct device *dev, stru
 	if (!dev)
 		return -EINVAL;
 
-	if (!device_is_registered(dev)) {
-		error = -EINVAL;
-		goto out;
-	}
 	new_parent = get_device(new_parent);
 	if (!new_parent) {
 		error = -EINVAL;
