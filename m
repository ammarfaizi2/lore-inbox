Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUC2NpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUC2NpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:45:17 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:33722 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262882AbUC2MQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:16:57 -0500
Date: Mon, 29 Mar 2004 04:16:14 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT:  finish physids_complement() conversion  [19/22]
Message-Id: <20040329041614.6cc97cb7.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_19_of_22 - Convert physids_complement() to really use both args
	Provide for specifying distinct source and dest args to the
	physids_complement().  No one actually uses this macro yet.
	The physid_mask type would be a good candidate to convert to
	using this new mask ADT as a base.

diffstat Patch_19_of_22:
 asm-i386/mpspec.h   |    2 +-
 asm-x86_64/mpspec.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1725  -> 1.1726 
#	include/asm-i386/mpspec.h	1.18    -> 1.19   
#	include/asm-x86_64/mpspec.h	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/29	pj@sgi.com	1.1726
# Change physids_complement() macro to take both source and dest args,
# inline with underlying bitmap_complement() change.  This change is
# untested, unreviewed.  Feedback welcome.  Consider changing physid_mask
# to be based on the new linux/mask.h ADT.
# --------------------------------------------
#
diff -Nru a/include/asm-i386/mpspec.h b/include/asm-i386/mpspec.h
--- a/include/asm-i386/mpspec.h	Mon Mar 29 01:04:04 2004
+++ b/include/asm-i386/mpspec.h	Mon Mar 29 01:04:04 2004
@@ -60,7 +60,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask, (src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)
diff -Nru a/include/asm-x86_64/mpspec.h b/include/asm-x86_64/mpspec.h
--- a/include/asm-x86_64/mpspec.h	Mon Mar 29 01:04:04 2004
+++ b/include/asm-x86_64/mpspec.h	Mon Mar 29 01:04:04 2004
@@ -214,7 +214,7 @@
 #define physids_and(dst, src1, src2)		bitmap_and((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_or(dst, src1, src2)		bitmap_or((dst).mask, (src1).mask, (src2).mask, MAX_APICS)
 #define physids_clear(map)			bitmap_clear((map).mask, MAX_APICS)
-#define physids_complement(map)			bitmap_complement((map).mask, (map).mask, MAX_APICS)
+#define physids_complement(dst, src)		bitmap_complement((dst).mask, (src).mask, MAX_APICS)
 #define physids_empty(map)			bitmap_empty((map).mask, MAX_APICS)
 #define physids_equal(map1, map2)		bitmap_equal((map1).mask, (map2).mask, MAX_APICS)
 #define physids_weight(map)			bitmap_weight((map).mask, MAX_APICS)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
