Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUHMT62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUHMT62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267447AbUHMT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:56:06 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:61010 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267335AbUHMTtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:49:15 -0400
Date: Fri, 13 Aug 2004 21:51:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [10/12] kbuild: Fix hostprogs-y
Message-ID: <20040813195135.GJ10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/10 21:56:40+02:00 sam@mars.ravnborg.org 
#   kbuild: Fix hostprogs-y
#   
#   Allow the same target to be specified more than once without causing a warnign from make.
#   The same target may be specified twice when using the following pattern:
#   hostprogs-$(CONFIG_FOO) += program
#   hostprogs-$(CONFIG_BAR) += program
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.host
#   2004/08/10 21:56:24+02:00 sam@mars.ravnborg.org +1 -1
#   Allow same target to be specified more than once
# 
diff -Nru a/scripts/Makefile.host b/scripts/Makefile.host
--- a/scripts/Makefile.host	2004-08-13 21:07:50 +02:00
+++ b/scripts/Makefile.host	2004-08-13 21:07:50 +02:00
@@ -30,7 +30,7 @@
 # libkconfig.so as the executable conf.
 # Note: Shared libraries consisting of C++ files are not supported
 
-__hostprogs := $(hostprogs-y)$(hostprogs-m)
+__hostprogs := $(sort $(hostprogs-y)$(hostprogs-m))
 
 # hostprogs-y := tools/build may have been specified. Retreive directory
 obj-dirs += $(foreach f,$(__hostprogs), $(if $(dir $(f)),$(dir $(f))))
