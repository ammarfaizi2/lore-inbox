Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262808AbVGHTin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262808AbVGHTin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVGHTgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:36:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22445 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262785AbVGHTdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:33:25 -0400
Date: Fri, 8 Jul 2005 20:32:04 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       "goggin, edward" <egoggin@emc.com>
Subject: [PATCH] device-mapper multipath: Flush workqueue when destroying
Message-ID: <20050708193204.GE12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Lars Marowsky-Bree <lmb@suse.de>,
	"goggin, edward" <egoggin@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The multipath destructor must flush its workqueue.
Otherwise items that reference the destroyed object could remain.

From: "goggin, edward" <egoggin@emc.com>
Signed-off-by: Lars Marowsky-Bree <lmb@suse.de>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm-mpath.c	2005-07-08 19:01:41.000000000 +0100
+++ source/drivers/md/dm-mpath.c	2005-07-08 19:11:11.000000000 +0100
@@ -752,6 +752,8 @@
 static void multipath_dtr(struct dm_target *ti)
 {
 	struct multipath *m = (struct multipath *) ti->private;
+
+	flush_workqueue(kmultipathd);
 	free_multipath(m);
 }
 
