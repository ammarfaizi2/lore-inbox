Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261434AbTCGH4S>; Fri, 7 Mar 2003 02:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbTCGH4S>; Fri, 7 Mar 2003 02:56:18 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:46351 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261434AbTCGH4P>; Fri, 7 Mar 2003 02:56:15 -0500
To: akpm@digeo.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix fs/binfmt_elf.c build
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 07 Mar 2003 09:05:26 +0100
Message-ID: <wrpy93r61q1.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

The stack reducing patch that recently went in prevent alpha from
building (missing some ELF_CORE_COPY_XFPREGS ifdefs). The excluded
patch fixes it.

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1046  -> 1.1047 
#	     fs/binfmt_elf.c	1.39    -> 1.40   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/07	maz@hina.wild-wind.fr.eu.org	1.1047
# fs/binfmt_elf.c : #ifdef XFPREGS stuff when needed.
# --------------------------------------------
#
diff -Nru a/fs/binfmt_elf.c b/fs/binfmt_elf.c
--- a/fs/binfmt_elf.c	Fri Mar  7 09:00:08 2003
+++ b/fs/binfmt_elf.c	Fri Mar  7 09:00:08 2003
@@ -1194,7 +1194,9 @@
  	LIST_HEAD(thread_list);
  	struct list_head *t;
 	elf_fpregset_t *fpu = NULL;
+#ifdef ELF_CORE_COPY_XFPREGS
 	elf_fpxregset_t *xfpu = NULL;
+#endif
 	int thread_status_size = 0;
 
 	/*
@@ -1400,7 +1402,9 @@
 	kfree(psinfo);
 	kfree(notes);
 	kfree(fpu);
+#ifdef ELF_CORE_COPY_XFPREGS
 	kfree(xfpu);
+#endif
 	return has_dumped;
 #undef NUM_NOTES
 }

-- 
Places change, faces change. Life is so very strange.
