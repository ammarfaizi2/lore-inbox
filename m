Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWEGT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWEGT6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWEGT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 15:58:08 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48865
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932219AbWEGT6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 15:58:07 -0400
From: Rob Landley <rob@landley.net>
To: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Small patch to bloat-o-meter.
Date: Sun, 7 May 2006 15:59:00 -0400
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605071559.00253.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Workaround for the fact that gcc 4.x no longer provides consistent names for 
static symbols.

Signed-off-by: Rob Landley <rob@landley.net>
---

When I added bloat-o-meter to busybox, I had to fix this to get useful 
results.  Since the kernel version seems to be the master, I thought you 
might be interested.

--- linux-old/scripts/bloat-o-meter	2006-05-07 15:47:23.000000000 -0400
+++ linux-2.6.16/scripts/bloat-o-meter	2006-05-07 15:08:31.000000000 -0400
@@ -18,7 +18,9 @@
     for l in os.popen("nm --size-sort " + file).readlines():
         size, type, name = l[:-1].split()
         if type in "tTdDbB":
-            sym[name] = int(size, 16)
+            if name.find(".") != -1: name = "static." + name.split(".")[0]
+            if name in sym: sym[name] += int(size, 16)
+            else :sym[name] = int(size, 16)
     return sym
 
 old = getsizes(sys.argv[1])


-- 
Never bet against the cheap plastic solution.
