Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbVJ1NgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbVJ1NgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 09:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbVJ1NgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 09:36:00 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:9962 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751450AbVJ1NgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 09:36:00 -0400
Subject: [ketchup] patch to alt urls for local trees
From: Steven Rostedt <rostedt@goodmis.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1130504043.9574.56.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
	 <20051017213915.GN26160@waste.org>
	 <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
	 <20051018063031.GR26160@waste.org>
	 <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
	 <20051018072927.GU26160@waste.org>
	 <1130504043.9574.56.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 28 Oct 2005 09:35:46 -0400
Message-Id: <1130506546.9574.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Here's another patch.  This one allows for local alternative url paths.
As you know, I use ketchup for Thomas Gleixner's ktimers.  He also
stores his archives differently than everyone else.  So I have as
my .ketchuprc the following.

local_trees = {
	'2.6-kt': (latest_dir,
		"http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
		r'patch-(2.6.*?)',
		0, "Thomas Gleixner's ktimers."),
	'2.6-kthrt': (latest_dir,
		"http://www.tglx.de/projects/ktimers/patch-%(full)s.patch",
		r'patch-(2.6.*?)',
		0, "Thomas Gleixner's ktimers and HRT patches.")
}

local_alturls = {
	'/ktimers/' : "/ktimers/archive/"
}



With the below patch to grab the older ktimer patches.

Now, I would like to let you know that I've only written one program in
python for all my life.  So I am not very comfortable writing code for
it. So if you can clean this up, I wouldn't mind.  For now, this works
for me.

-- Steve

Index: Ketchup-d9503020b3c1/ketchup
===================================================================
--- Ketchup-d9503020b3c1.orig/ketchup	2005-10-28 08:48:37.000000000 -0400
+++ Ketchup-d9503020b3c1/ketchup	2005-10-28 09:27:31.000000000 -0400
@@ -89,6 +89,7 @@
 precommand = postcommand = None
 default_tree = None
 local_trees = {}
+local_alturls = {}
 
 def qprint(*args):
     if not options["quiet"]:
@@ -355,6 +356,9 @@
     # the jgarzik memorial hack
     url2 = re.sub("/snapshots/", "/snapshots/old/", url)
     url2 = re.sub("/realtime-preempt/", "/realtime-preempt/older/", url2)
+    for exp,rep in local_alturls.items():
+        if url2 != url: break
+        url2 = re.sub(exp, rep, url2)
     if url2 != url:
         if download(url2, file): return file
         if url2[-4:] == ".bz2":


