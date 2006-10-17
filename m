Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWJQPzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWJQPzO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWJQPzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:55:14 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:46310 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751171AbWJQPzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:55:12 -0400
Date: Tue, 17 Oct 2006 16:55:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Make <linux/personality.h> userspace proof
Message-ID: <20061017155526.GA9888@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/personality.h> contains the constants for personality(2) but also
some defintions that are useless or even harmful in userspace such as
the personality() macro.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 include/linux/personality.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/personality.h b/include/linux/personality.h
index 80d780e..bf4cf20 100644
--- a/include/linux/personality.h
+++ b/include/linux/personality.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_PERSONALITY_H
 #define _LINUX_PERSONALITY_H
 
+#ifdef __KERNEL__
+
 /*
  * Handling of different ABIs (personalities).
  */
@@ -12,6 +14,8 @@ extern int		register_exec_domain(struct 
 extern int		unregister_exec_domain(struct exec_domain *);
 extern int		__set_personality(unsigned long);
 
+#endif /* __KERNEL__ */
+
 /*
  * Flags for bug emulation.
  *
@@ -71,6 +75,7 @@ enum {
 	PER_MASK =		0x00ff,
 };
 
+#ifdef __KERNEL__
 
 /*
  * Description of an execution domain.
@@ -111,4 +116,6 @@ #define get_personality		(current->perso
 #define set_personality(pers) \
 	((current->personality == pers) ? 0 : __set_personality(pers))
 
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_PERSONALITY_H */
