Return-Path: <linux-kernel-owner+w=401wt.eu-S1030431AbWLaTiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWLaTiK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 14:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWLaTiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 14:38:10 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:34479 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030431AbWLaTiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 14:38:09 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 31 Dec 2006 14:32:25 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
Message-ID: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Add an explanation for defining multi-line macros using the ({ })
notation to CodingStyle.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 9069189..1d0ddb8 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -549,13 +549,24 @@ may be named in lower case.

 Generally, inline functions are preferable to macros resembling functions.

-Macros with multiple statements should be enclosed in a do - while block:
+There are two techniques for defining macros that contain multiple
+statements.

-#define macrofun(a, b, c) 			\
-	do {					\
+ (a) Enclose those statements in a do - while block:
+
+	#define macrofun(a, b, c) 		\
+		do {				\
+			if (a == 5)		\
+				do_this(b, c);	\
+		} while (0)
+
+ (b) Use the gcc extension that a compound statement enclosed in
+     parentheses represents an expression:
+
+	#define macrofun(a, b, c) ({		\
 		if (a == 5)			\
 			do_this(b, c);		\
-	} while (0)
+	})

 Things to avoid when using macros:

