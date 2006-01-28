Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWA1CWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWA1CWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWA1CWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:23482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422801AbWA1CWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:15 -0500
Date: Fri, 27 Jan 2006 18:21:36 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Markus.Lidel@shadowconnect.com, theonetruekenny@yahoo.com
Subject: [patch 11/12] Fix i2o_scsi oops on abort
Message-ID: <20060128022136.GL17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-i2o_scsi-oops-on-abort.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Markus Lidel <Markus.Lidel@shadowconnect.com>

>From http://bugzilla.kernel.org/show_bug.cgi?id=5923

When a scsi command failed, an oops would result.

Back-to-back SMART queries would make the Seagate drives unhappy.  The
second SMART query would timeout, and the command would be aborted.

From: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: Kenny Simpson <theonetruekenny@yahoo.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/message/i2o/i2o_scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.1.orig/drivers/message/i2o/i2o_scsi.c
+++ linux-2.6.15.1/drivers/message/i2o/i2o_scsi.c
@@ -729,7 +729,7 @@ static int i2o_scsi_abort(struct scsi_cm
 	       &msg->u.head[1]);
 	writel(i2o_cntxt_list_get_ptr(c, SCpnt), &msg->body[0]);
 
-	if (i2o_msg_post_wait(c, m, I2O_TIMEOUT_SCSI_SCB_ABORT))
+	if (!i2o_msg_post_wait(c, msg, I2O_TIMEOUT_SCSI_SCB_ABORT))
 		status = SUCCESS;
 
 	return status;

--
