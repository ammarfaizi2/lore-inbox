Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUCSRZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263075AbUCSRZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:25:56 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:58248 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S263041AbUCSRZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:25:54 -0500
Date: Fri, 19 Mar 2004 10:25:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tim Waugh <twaugh@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix scripts/kernel-doc to handle __attribute__
Message-ID: <20040319172553.GF4569@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  The following patch is needed so that kernel-doc can handle
functions which have __attribute__'s on them (such as __attribute__
((weak))).  The following is against 2.6.4, but I suspect applies to any
2.6 or recent'ish 2.4.

Index: linux-2.6.4/scripts/kernel-doc
===================================================================
--- linux-2.6.4.orig/scripts/kernel-doc	2004-03-10 19:55:26.000000000 -0700
+++ linux-2.6.4/scripts/kernel-doc	2004-03-19 10:19:28.437288679 -0700
@@ -1376,6 +1376,7 @@
     $prototype =~ s/^inline +//;
     $prototype =~ s/^__inline__ +//;
     $prototype =~ s/^#define +//; #ak added
+    $prototype =~ s/__attribute__ \(\([a-z,]*\)\)//;
 
     # Yes, this truly is vile.  We are looking for:
     # 1. Return type (may be nothing if we're looking at a macro)

-- 
Tom Rini
http://gate.crashing.org/~trini/
