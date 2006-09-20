Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWITVkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWITVkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWITVkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:40:16 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:51223 "EHLO
	dhcp119.mvista.com") by vger.kernel.org with ESMTP id S932139AbWITVkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:40:14 -0400
Date: Wed, 20 Sep 2006 14:43:54 -0700
Message-Id: <200609202143.k8KLhsxg007647@dhcp119.mvista.com>
Subject: [PATCH for 2.4] x86_64: Fix missing delay when the TSC counter just overflowed
From: Toyo Abe <toyoa@mvista.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd seen a problem that *delay functions return in too short delay.
It happens when the lower 32bit of TSC counter is overflowed.
This patch fixes the problem. This is back-port of Andi Kleen's
2.6 fix.

http://www.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=commit;h=6c51e28ffbbebf49437ec63ac4f9e385d60827e5

Signed-off-by: Toyo Abe <toyoa@mvista.com>

---

 arch/x86_64/lib/delay.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/lib/delay.c b/arch/x86_64/lib/delay.c
index cc845d2..91345ee 100644
--- a/arch/x86_64/lib/delay.c
+++ b/arch/x86_64/lib/delay.c
@@ -19,7 +19,7 @@ #endif
 
 void __delay(unsigned long loops)
 {
-	unsigned long bclock, now;
+	unsigned bclock, now;
 	
 	rdtscl(bclock);
 	do
