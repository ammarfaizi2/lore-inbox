Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTAHCqv>; Tue, 7 Jan 2003 21:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267673AbTAHCqv>; Tue, 7 Jan 2003 21:46:51 -0500
Received: from fmr05.intel.com ([134.134.136.6]:37098 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267672AbTAHCqt>; Tue, 7 Jan 2003 21:46:49 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601F11721@pdsmsx32.pd.intel.com>
From: "Wang, Stanley" <stanley.wang@intel.com>
To: "'Rusty Russell'" <rusty@rustcorp.com.au>
Cc: levon@movementarian.org, "Zhuang, Louis" <louis.zhuang@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'trivial@rustcorp.com.au'" <trivial@rustcorp.com.au>
Subject: [TRIVIAl]RE: Kernel module version support. 
Date: Wed, 8 Jan 2003 10:53:09 +0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, and the module's state (LOADING, UNLOADING or LIVE).  There might
> be others, too.
Is thiw what you want ? And when would you like to export the module's state
information?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.893   -> 1.894  
#	     kernel/module.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/08	stanley@manticore.sh.intel.com	1.894
# Print module state
# --------------------------------------------
#
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Wed Jan  8 10:33:28 2003
+++ b/kernel/module.c	Wed Jan  8 10:33:29 2003
@@ -486,6 +486,14 @@
 	return ret;
 }
 
+static void print_module_info(struct seq_file *m, struct module *mod)
+{
+	seq_printf(m, " %s", mod->state == MODULE_STATE_LIVE ? "Live":
+			mod->state == MODULE_STATE_COMING ? "Loading":
+			"Unloading");
+	seq_printf(m, " 0x%p", mod->module_core);
+}
+
 static void print_unload_info(struct seq_file *m, struct module *mod)
 {
 	struct module_use *use;
@@ -1422,6 +1430,7 @@
 	seq_printf(m, "%s %lu",
 		   mod->name, mod->init_size + mod->core_size);
 	print_unload_info(m, mod);
+	print_module_info(m, mod);
 	seq_printf(m, "\n");
 	return 0;
 }


Regards,

Your Sincerely,
Stanley Wang 

SW Engineer, Intel Corporation.
Intel China Software Lab. 
Tel: 021-52574545 ext. 1171 
iNet: 8-752-1171 
 
Opinions expressed are those of the author and do not represent Intel
Corporation
