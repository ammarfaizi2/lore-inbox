Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVHOJYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVHOJYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 05:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbVHOJYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 05:24:47 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:32486 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S932332AbVHOJYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 05:24:46 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/23] Fix the arguments to machine_restart on cris
Date: Mon, 15 Aug 2005 11:24:31 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668030B4DC3@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668031D51FB@exmail1.se.axis.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, not really luck but anyway (the caller puts the first argument in
register r10 and the called function never uses it so no harm).

Acked-by: Mikael Starvik <starvik@axis.com>

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Eric W. Biederman
Sent: Tuesday, July 26, 2005 7:33 PM
To: Andrew Morton
Cc: Linus Torvalds; linux-kernel@vger.kernel.org
Subject: [PATCH 5/23] Fix the arguments to machine_restart on cris



It appears machine_restart has been working cris just
by luck.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/cris/kernel/process.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

bb30d3f0b58c6ecde77e7446b8bab12610fb5f97
diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
--- a/arch/cris/kernel/process.c
+++ b/arch/cris/kernel/process.c
@@ -113,6 +113,7 @@
 #include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/mqueue.h>
+#include <linux/reboot.h>
 
 //#define DEBUG
 
@@ -208,7 +209,7 @@ void cpu_idle (void)
 
 void hard_reset_now (void);
 
-void machine_restart(void)
+void machine_restart(char *cmd)
 {
 	hard_reset_now();
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

