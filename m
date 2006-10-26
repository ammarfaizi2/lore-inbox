Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWJZJBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWJZJBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbWJZJBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:01:45 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:13540 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752122AbWJZJBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:01:44 -0400
Date: Thu, 26 Oct 2006 11:01:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Initialize interval value to 0.
Message-ID: <20061026090141.GA16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Initialize interval value to 0.

sscanf() could leave the interval value unchanged in which case it
would be used uninitialized.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-10-26 10:43:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-10-26 10:44:01.000000000 +0200
@@ -310,6 +310,7 @@ appldata_interval_handler(ctl_table *ctl
 	if (copy_from_user(buf, buffer, len > sizeof(buf) ? sizeof(buf) : len)) {
 		return -EFAULT;
 	}
+	interval = 0;
 	sscanf(buf, "%i", &interval);
 	if (interval <= 0) {
 		P_ERROR("Timer CPU interval has to be > 0!\n");
