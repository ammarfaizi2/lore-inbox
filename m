Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVDSNAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDSNAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDSNAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:00:49 -0400
Received: from orb.pobox.com ([207.8.226.5]:30085 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261494AbVDSNAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:00:39 -0400
Date: Tue, 19 Apr 2005 06:00:36 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] fix ultrastor.c compile error
Message-ID: <20050419130036.GC8541@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is against linux-2.6 head 9d469ee9f21c680c41dbffe5b0f36ab5010ca8b1:

  CC [M]  drivers/scsi/ultrastor.o
drivers/scsi/ultrastor.c: In function `ultrastor_queuecommand':
drivers/scsi/ultrastor.c:302: warning: matching constraint does not
allow a register
drivers/scsi/ultrastor.c:302: warning: matching constraint does not
allow a register
drivers/scsi/ultrastor.c: In function `ultrastor_abort':
drivers/scsi/ultrastor.c:948: error: `FAILURE' undeclared (first use in
this function)
drivers/scsi/ultrastor.c:948: error: (Each undeclared identifier is
reported only once
drivers/scsi/ultrastor.c:948: error: for each function it appears in.)
make[2]: *** [drivers/scsi/ultrastor.o] Error 1
make[1]: *** [drivers/scsi] Error 2
make: *** [drivers] Error 2

This patch fixes the compile error, but not the warning. I have
compile-tested this patch but I do not have the hardware so I don't
believe I can execute this code.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>

--- linux-2.6.12-rc2-9d469ee9f21c680c41dbffe5b0f36ab5010ca8b1-bkn1/drivers/scsi/ultrastor.c	2005-04-19 00:46:13.689904927 -0700
+++ linux-2.6.12-rc2-9d469ee9f21c680c41dbffe5b0f36ab5010ca8b1-bkn2/drivers/scsi/ultrastor.c	2005-04-19 05:56:12.135432363 -0700
@@ -945,7 +945,7 @@
 	       config.mscp[mscp_index].SCint, SCpnt);
 #endif
     if (config.mscp[mscp_index].SCint == 0)
-	return FAILURE;
+	return FAILED;
 
     if (config.mscp[mscp_index].SCint != SCpnt) panic("Bad abort");
     config.mscp[mscp_index].SCint = NULL;
