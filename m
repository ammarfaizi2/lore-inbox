Return-Path: <linux-kernel-owner+w=401wt.eu-S1751483AbWLRRsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWLRRsP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbWLRRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 12:48:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56319 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbWLRRsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 12:48:14 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 12:43:35 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Add a new section to CodingStyle, promoting include/linux/kernel.h.
Message-ID: <Pine.LNX.4.64.0612181238210.27907@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Add a new section to the CodingStyle file, encouraging people not to
re-invent available kernel macros such as ARRAY_SIZE(),
FIELD_SIZEOF(), min() and max(), among others.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  NOTE:  at the moment, there is not a single invocation of the
FIELD_SIZEOF() macro anywhere in the entire source tree, so if someone
had a hankering to rename it to something more catchy, now would be a
good time and i can always resubmit the patch i sent in yesterday.



diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index 0ad6dcb..a736333 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -682,6 +682,24 @@ result.  Typical examples would be functions that return pointers; they use
 NULL or the ERR_PTR mechanism to report failure.


+		Chapter 17:  Don't re-invent the kernel macros
+
+The header file include/linux/kernel.h contains a number of macros that
+you should use, rather than explicitly coding some variant of them yourself.
+For example, if you need to calculate the length of an array, take advantage
+of the macro
+
+  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+Similarly, if you need to calculate the size of some structure member, use
+
+  #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
+
+There are also min() and max() macros that do strict type checking if you
+need them.  Feel free to peruse that header file to see what else is already
+defined that you shouldn't reproduce in your code.
+
+

 		Appendix I: References



