Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161279AbWF0USq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161279AbWF0USq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161280AbWF0USp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:18:45 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:16257 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161279AbWF0USm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:18:42 -0400
Message-Id: <20060627201630.295399000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:20 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, B.Zolnierkiewicz@elka.pw.edu.pl,
       a1426z@gawab.com, BZolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH 20/25] ide-io: increase timeout value to allow for slave wakeup
Content-Disposition: inline; filename=ide-io-increase-timeout-value-to-allow-for-slave-wakeup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Boldi <a1426z@gawab.com>

During an STR resume cycle, the ide master disk times-out when there is
also a slave present (especially CD).  Increasing the timeout in ide-io
from 10,000 to 100,000 fixes this problem.

Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/ide/ide-io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/drivers/ide/ide-io.c
+++ linux-2.6.17.1/drivers/ide/ide-io.c
@@ -932,7 +932,7 @@ static ide_startstop_t start_request (id
 			printk(KERN_WARNING "%s: bus not ready on wakeup\n", drive->name);
 		SELECT_DRIVE(drive);
 		HWIF(drive)->OUTB(8, HWIF(drive)->io_ports[IDE_CONTROL_OFFSET]);
-		rc = ide_wait_not_busy(HWIF(drive), 10000);
+		rc = ide_wait_not_busy(HWIF(drive), 100000);
 		if (rc)
 			printk(KERN_WARNING "%s: drive not ready on wakeup\n", drive->name);
 	}

--
