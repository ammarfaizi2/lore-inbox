Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVGLV0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVGLV0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVGLV0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:26:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262445AbVGLVY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:24:57 -0400
Date: Tue, 12 Jul 2005 22:24:49 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: laurent.riffard@free.fr, linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Subject: [PATCH] device-mapper: Fix target suspension oops.
Message-ID: <20050712212449.GK12337@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, laurent.riffard@free.fr,
	linux-kernel@vger.kernel.org,
	Felipe Alfaro Solana <felipe.alfaro@gmail.com>
References: <20050712021724.13b2297a.akpm@osdl.org> <42D41177.9020300@free.fr> <20050712204751.GB12341@agk.surrey.redhat.com> <20050712140248.3cdcb9b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712140248.3cdcb9b8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This section got lost while refactoring the 'Fix deadlocks in core' set 
of patches I sent yesterday.  Without it, you'll have problems
activating any device-mapper devices.

The NULL detection is moved inside the functions instead of every 
caller having to do it.

--- drivers/md/dm-table.c	2005-07-12 22:10:20.000000000 +0100
+++ /data/kernels/pm-2612udm1/source/drivers/md/dm-table.c	2005-07-06 18:52:18.000000000 +0100
@@ -869,11 +869,17 @@
 
 void dm_table_presuspend_targets(struct dm_table *t)
 {
+	if (!t)
+		return;
+
 	return suspend_targets(t, 0);
 }
 
 void dm_table_postsuspend_targets(struct dm_table *t)
 {
+	if (!t)
+		return;
+
 	return suspend_targets(t, 1);
 }
 
