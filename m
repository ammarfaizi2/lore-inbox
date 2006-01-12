Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWALRT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWALRT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWALRT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:19:29 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:13280 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751449AbWALRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:19:27 -0500
Date: Thu, 12 Jan 2006 18:19:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 12/13] s390: chps[] array too short.
Message-ID: <20060112171912.GM16629@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 12/13] s390: chps[] array too short.

The chps[] array in struct channel_subsystem is one too short;
therefore the code doesn't realize the chpid ff is already known.
When several devices on chpid ff become available, the message
"new_channel_path: could not register ff" is displayed for every
device but the first one.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/cio/css.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-01-12 15:43:26.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-01-12 15:44:02.000000000 +0100
@@ -143,7 +143,7 @@ extern int for_each_subchannel(int(*fn)(
 struct channel_subsystem {
 	u8 cssid;
 	int valid;
-	struct channel_path *chps[__MAX_CHPID];
+	struct channel_path *chps[__MAX_CHPID + 1];
 	struct device device;
 	struct pgid global_pgid;
 };
