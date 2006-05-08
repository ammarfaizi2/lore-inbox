Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWEHFKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWEHFKm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEHFKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:10:42 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:742 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932304AbWEHFKm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:10:42 -0400
From: Rob Landley <rob@landley.net>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] Small patch to bloat-o-meter.
Date: Mon, 8 May 2006 01:11:34 -0400
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <200605071559.00253.rob@landley.net> <200605080043.51415.rob@landley.net> <20060508044800.GV15445@waste.org>
In-Reply-To: <20060508044800.GV15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605080111.34985.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second try: patch to upgrade scripts/bloat-o-meter to handle the names gcc 4 
gives static symbols.

Signed-off-by: Rob Landley <rob@landley.net>
---

--- linux-2.6.16/scripts/bloat-o-meter	2006-05-08 01:04:06.000000000 -0400
+++ linux-rob/scripts/bloat-o-meter	2006-05-08 01:02:36.000000000 -0400
@@ -18,7 +18,8 @@
     for l in os.popen("nm --size-sort " + file).readlines():
         size, type, name = l[:-1].split()
         if type in "tTdDbB":
-            sym[name] = int(size, 16)
+            if "." in name: name = "static." + name.split(".")[0]
+            sym[name] = sym.get(name, 0) + int(size, 16)
     return sym
 
 old = getsizes(sys.argv[1])

-- 
Never bet against the cheap plastic solution.
