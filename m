Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbTJJNVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTJJNVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:21:49 -0400
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:10514 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S262626AbTJJNVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:21:47 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 10 Oct 2003 08:21:41 -0500
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] Make mrproper skip private repo directories in 2.4
Message-ID: <20031010132141.GA3934@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch changes 'make mrproper' to skip the BitKeeper, CVS,
and subversion directories when that command is removing files. A
similar patch is in the 2.6 makefile. The 'mrproper' command removes
0-byte sized files, but removing these files from the repository
private directories can mess things up.

Art Haas

Index: Makefile
===================================================================
--- Makefile	(revision 4144)
+++ Makefile	(working copy)
@@ -455,7 +455,7 @@
 	$(MAKE) -C Documentation/DocBook clean
 
 mrproper: clean archmrproper
-	find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
+	find . \( -name SCCS -o -name .svn -o -name BitKeeper -o -name CVS \) -prune -o \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
 	rm -f $(MRPROPER_FILES)
 	rm -rf $(MRPROPER_DIRS)
 	$(MAKE) -C Documentation/DocBook mrproper
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
