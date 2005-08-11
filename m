Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVHKIMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVHKIMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 04:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbVHKIMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 04:12:42 -0400
Received: from NS4.Sony.CO.JP ([137.153.0.44]:3011 "EHLO ns4.sony.co.jp")
	by vger.kernel.org with ESMTP id S1030219AbVHKIMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 04:12:41 -0400
Date: Thu, 11 Aug 2005 17:07:50 +0900 (JST)
Message-Id: <20050811.170750.26993208.kaminaga@sm.sony.co.jp>
To: rusty@rustcorp.com.au, adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Aug_11_17_07_50_2005_223)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Thu_Aug_11_17_07_50_2005_223)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

I don't know if this is a bug, but on kernel src code, `-' and `,' is
substituted to `_' in scripts/Makefile.lib but, in latest
module-init-tools-3.2-pre9, only `-' is handled, but not ','.

Attached is the patch for this problem against module-init-tools.

Regards,

HK.
--
----Next_Part(Thu_Aug_11_17_07_50_2005_223)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="module-init-tools.patch"

diff -uNrp module-init-tools-3.2-pre9-orig/rmmod.c module-init-tools-3.2-pre9/rmmod.c
--- module-init-tools-3.2-pre9-orig/rmmod.c	Wed Feb 25 16:10:51 2004
+++ module-init-tools-3.2-pre9/rmmod.c	Thu Aug 11 16:50:32 2005
@@ -165,6 +165,8 @@ static void filename2modname(char *modna
 	for (i = 0; afterslash[i] && afterslash[i] != '.'; i++) {
 		if (afterslash[i] == '-')
 			modname[i] = '_';
+		else if (afterslash[i] == ',')
+			modname[i] = '_';
 		else
 			modname[i] = afterslash[i];
 	}

----Next_Part(Thu_Aug_11_17_07_50_2005_223)----
