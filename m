Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936934AbWLDOw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936934AbWLDOw5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936943AbWLDOw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:52:57 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:8471 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S936934AbWLDOw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:52:27 -0500
Date: Mon, 4 Dec 2006 15:52:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] Use diag instead of ccw reipl.
Message-ID: <20061204145222.GK32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] Use diag instead of ccw reipl.

Since the diag 308 reipl method is superior to the ccw method, we should
use it whenever it is possible. We can do that, if the user has not
specified a new reipl ccw device and the system has been ipled from
a ccw device.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-04 14:50:39.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-04 14:50:41.000000000 +0100
@@ -664,6 +664,8 @@ void do_reipl(void)
 	switch (reipl_method) {
 	case IPL_METHOD_CCW_CIO:
 		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
+		if (ipl_get_type() == IPL_TYPE_CCW && devid.devno == ipl_devno)
+			diag308(DIAG308_IPL, NULL);
 		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
