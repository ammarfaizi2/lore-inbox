Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWAZTHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWAZTHO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWAZTHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:07:14 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:22186 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S964822AbWAZTHM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:07:12 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix RocketPort driver.
Cc: mostrows@watson.ibm.com
Message-Id: <E1F2CSb-0000bo-B2@heater.watson.ibm.com>
From: Michal Ostrowski <mostrows@watson.ibm.com>
Date: Thu, 26 Jan 2006 14:07:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call "ld->receive_buf" using the start of the character and flag buffers,
rather than the ends.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

---

 drivers/char/rocket.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b4a5d3ca98e99986c157c8aed12f958fe99288fb
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
index 0949dce..7edc6a4 100644
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -433,7 +433,7 @@ static void rp_do_receive(struct r_port 
 		count += ToRecv;
 	}
 	/*  Push the data up to the tty layer */
-	ld->receive_buf(tty, cbuf, fbuf, count);
+	ld->receive_buf(tty, chead, fhead, count);
 done:
 	tty_ldisc_deref(ld);
 }
-- 
1.1.4.g0b63-dirty

