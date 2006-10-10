Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWJJHcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWJJHcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWJJHcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:32:18 -0400
Received: from havoc.gtf.org ([69.61.125.42]:52878 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965078AbWJJHcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:32:16 -0400
Date: Tue, 10 Oct 2006 03:32:15 -0400
From: Jeff Garzik <jeff@garzik.org>
To: chas@cmf.nrl.navy.mil, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] atm/firestream: handle thrown error
Message-ID: <20061010073215.GA23340@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc emits the following warning:

drivers/atm/firestream.c: In function ‘fs_open’:
drivers/atm/firestream.c:870: warning: ‘tmc0’ may be used uninitialized in this function

This indicates a real bug.  We should check make_rate() return value for
potential errors.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/atm/firestream.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index 40ab9b6..697ad82 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1002,6 +1002,10 @@ static int fs_open(struct atm_vcc *atm_v
 					r = ROUND_UP;
 				}
 				error = make_rate (pcr, r, &tmc0, NULL);
+				if (error) {
+					kfree(tc);
+					return error;
+				}
 			}
 			fs_dprintk (FS_DEBUG_OPEN, "pcr = %d.\n", pcr);
 		}
