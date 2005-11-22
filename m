Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbVKVVGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVKVVGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbVKVVGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:06:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2718 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965184AbVKVVGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:06:48 -0500
Date: Tue, 22 Nov 2005 13:06:19 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, petero2@telia.com
Subject: [patch 04/23] [PATCH] packet writing oops fix
Message-ID: <20051122210619.GE28140@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="packet-writing-oops-fix.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

There is an old bug in the pkt_count_states() function that causes stack
corruption.  When compiling with gcc 3.x or 2.x it is harmless, but gcc 4
allocates local variables differently, which makes the bug visible.

Signed-off-by: Peter Osterlund <petero2@telia.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/block/pktcdvd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14.2.orig/drivers/block/pktcdvd.c
+++ linux-2.6.14.2/drivers/block/pktcdvd.c
@@ -1191,7 +1191,7 @@ static void pkt_count_states(struct pktc
 	struct packet_data *pkt;
 	int i;
 
-	for (i = 0; i <= PACKET_NUM_STATES; i++)
+	for (i = 0; i < PACKET_NUM_STATES; i++)
 		states[i] = 0;
 
 	spin_lock(&pd->cdrw.active_list_lock);

--
