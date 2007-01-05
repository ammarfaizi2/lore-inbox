Return-Path: <linux-kernel-owner+w=401wt.eu-S1161133AbXAEPLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbXAEPLI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 10:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbXAEPLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 10:11:07 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:43788 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161136AbXAEPLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 10:11:06 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 5 Jan 2007 10:03:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] Discuss a couple common errors in kernel-doc usage.
Message-ID: <Pine.LNX.4.64.0701051000560.3949@localhost.localdomain>
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


  Explain a couple of the most common errors in kernel-doc usage.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  seems useful to emphasize these issues since they occur occasionally
in the source.

diff --git a/Documentation/kernel-doc-nano-HOWTO.txt b/Documentation/kernel-doc-nano-HOWTO.txt
index 284e7e1..ba50129 100644
--- a/Documentation/kernel-doc-nano-HOWTO.txt
+++ b/Documentation/kernel-doc-nano-HOWTO.txt
@@ -107,10 +107,14 @@ The format of the block comment is like this:
  * (section header: (section description)? )*
 (*)?*/

-The short function description cannot be multiline, but the other
-descriptions can be (and they can contain blank lines). Avoid putting a
-spurious blank line after the function name, or else the description will
-be repeated!
+The short function description ***cannot be multiline***, but the other
+descriptions can be (and they can contain blank lines).  If you continue
+that initial short description onto a second line, that second line will
+appear further down at the beginning of the description section, which is
+almost certainly not what you had in mind.
+
+Avoid putting a spurious blank line after the function name, or else the
+description will be repeated!

 All descriptive text is further processed, scanning for the following special
 patterns, which are highlighted appropriately.
@@ -121,6 +125,31 @@ patterns, which are highlighted appropriately.
 '@parameter' - name of a parameter
 '%CONST' - name of a constant.

+NOTE 1:  The multi-line descriptive text you provide does *not* recognize
+line breaks, so if you try to format some text nicely, as in:
+
+  Return codes
+    0 - cool
+    1 - invalid arg
+    2 - out of memory
+
+this will all run together and produce:
+
+  Return codes 0 - cool 1 - invalid arg 2 - out of memory
+
+NOTE 2:  If the descriptive text you provide has lines that begin with
+some phrase followed by a colon, each of those phrases will be taken as
+a new section heading, which means you should similarly try to avoid text
+like:
+
+  Return codes:
+    0: cool
+    1: invalid arg
+    2: out of memory
+
+every line of which would start a new section.  Again, probably not
+what you were after.
+
 Take a look around the source tree for examples.


