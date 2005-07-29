Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVG2TBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVG2TBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVG2TB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:01:27 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37513 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262723AbVG2S7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:59:23 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] forcedeth: Write back the misordered mac address
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 12:58:59 -0600
Message-ID: <m1vf2t30cs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This keeps the forcedepth driver from loosing it's mac
address over a kexec reboot.  Other kinds of reboot
may benefit as well.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 drivers/net/forcedeth.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

67de481a8bcb2912201ad61e637db1980d1a4d1b
diff --git a/drivers/net/forcedeth.c b/drivers/net/forcedeth.c
--- a/drivers/net/forcedeth.c
+++ b/drivers/net/forcedeth.c
@@ -1942,6 +1942,12 @@ static int nv_close(struct net_device *d
 	if (np->wolenabled)
 		nv_start_rx(dev);
 
+	/* special op: write back the misordered MAC address - otherwise
+	 * the next nv_probe would see a wrong address.
+	 */
+	writel(np->orig_mac[0], base + NvRegMacAddrA);
+	writel(np->orig_mac[1], base + NvRegMacAddrB);
+
 	/* FIXME: power down nic */
 
 	return 0;
