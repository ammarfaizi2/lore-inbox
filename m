Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbUKSWUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbUKSWUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 17:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKSWAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 17:00:44 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:42112 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261634AbUKSV7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:59:34 -0500
From: pmeda@akamai.com
Date: Fri, 19 Nov 2004 15:01:01 -0800
Message-Id: <200411192301.PAA20134@allur.sanmateo.akamai.com>
To: linux-kernel@vger.kernel.org
Subject: [ proc patch ] cmdline missing mmput 
Cc: akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix the mmput bug introduced while fixing cmdline race.

Signed-off-by: Prasanna Meda <pmeda@akamai.com>


--- a/fs/proc/base.c	Fri Nov 19 14:42:07 2004
+++ b/fs/proc/base.c	Fri Nov 19 14:45:19 2004
@@ -342,7 +342,7 @@
 	if (!mm)
 		goto out;
 	if (!mm->arg_end)
-		goto out;	/* Shh! No looking before we're done */
+		goto out_mm;	/* Shh! No looking before we're done */
 
  	len = mm->arg_end - mm->arg_start;
  
@@ -365,8 +365,8 @@
 			res = strnlen(buffer, res);
 		}
 	}
+out_mm:
 	mmput(mm);
-
 out:
 	return res;
 }
