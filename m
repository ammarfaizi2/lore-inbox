Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUAAMdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 07:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUAAMdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 07:33:22 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:5483 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261605AbUAAMdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 07:33:14 -0500
Date: Thu, 1 Jan 2004 04:33:33 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101043333.186a3268.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please consider applying the following patch.

This patch turns off all gcc warnings on comparing signed with unsigned
numbers, by setting the gcc option -Wno-sign-compare in the top
Makefile.

These warnings state:

  warning: comparison between signed and unsigned

This patch is a "personal preference" decision.  If you choose to
reject it, I seek no justifications.

I like it, and at least with the version of gcc I happen to be using
(3.3), find it really helps.  This version of gcc dumps out many such
complaints otherwise.

And one could make a case that Linus would like this patch, from his
remark of a couple months ago, on a thread with the Subject of:

  [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len

in which Linus wrote:
> That's why I hate the "sign compare" warning of gcc so much - it warns 
> about things that you CANNOT sanely write in any other way. That makes 
> that particular warning _evil_, since it encourages people to write crap 
> code.

But what Linus actually thinks of this, I've no further clues.

The patch was computed against 2.6.0-mm2.

Thank-you for your consideration.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1536  -> 1.1537 
#	            Makefile	1.441   -> 1.442  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/01	pj@sgi.com	1.1537
# ignore gcc sign compare warnings
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Jan  1 04:13:04 2004
+++ b/Makefile	Thu Jan  1 04:13:04 2004
@@ -161,7 +161,7 @@
 
 HOSTCC  	= gcc
 HOSTCXX  	= g++
-HOSTCFLAGS	= -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS	= -Wall -Wstrict-prototypes -Wno-sign-compare -O2 -fomit-frame-pointer
 HOSTCXXFLAGS	= -O2
 
 # 	Decide whether to build built-in, modular, or both.
@@ -275,7 +275,7 @@
 CPPFLAGS        := -D__KERNEL__ -Iinclude \
 		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
 
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-sign-compare -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
