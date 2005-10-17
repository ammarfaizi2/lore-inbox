Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVJQHkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVJQHkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVJQHkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:40:45 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:59586 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932104AbVJQHko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:40:44 -0400
Date: Mon, 17 Oct 2005 03:38:49 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Matt Mackall <mpm@selenic.com>
Subject: ketchup+rt with ktimers added.
Message-ID: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another update patch to ketchup based on Michal Schmidts patched
version of Matt Mackall's ketchup at
http://www.uamt.feec.vutbr.cz/rizeni/pom/ketchup-0.9+rt
This patch adds Thomas Gleixner's ktimers (both base kt and HRT versions).

Since the base version of Michal Schmidt's ketchup-0.9+rt didn't include
Esben Nielsen's addition of handling Ingo's older kernels, I again
included it with this patch.

-- Steve

--- ketchup-0.9+rt	2005-08-16 08:25:40.000000000 -0400
+++ ketchup	2005-10-17 03:09:53.000000000 -0400
@@ -311,7 +311,15 @@
     '2.6-rt': (latest_dir,
                 "http://people.redhat.com/mingo/realtime-preempt/patch-%(full)s",
 		r'patch-(2.6.*?)',
-		0, "Ingo Molnar's realtime-preempt kernel")
+		0, "Ingo Molnar's realtime-preempt kernel"),
+    '2.6-kt': (latest_dir,
+                "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
+		r'patch-(2.6.*?)',
+		0, "Thomas Gleixner's ktimers."),
+    '2.6-kthrt': (latest_dir,
+                "http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
+		r'patch-(2.6.*?)',
+		0, "Thomas Gleixner's ktimers and HRT patches.")
     }

 def version_url(ver, sign = 0):
@@ -363,6 +371,7 @@

     # the jgarzik memorial hack
     url2 = re.sub("/snapshots/", "/snapshots/old/", url)
+    url2 = re.sub("/realtime-preempt/", "/realtime-preempt/older/", url2)
     if url2 != url:
         if download(url2, file): return file
         if url2[-4:] == ".bz2":
