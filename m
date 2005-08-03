Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVHCGs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVHCGs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVHCGs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:48:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVHCGsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:48:12 -0400
Date: Tue, 2 Aug 2005 23:47:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
       george@mvista.com, sam@ravnborg.org
Subject: [01/13] kbuild: build TAGS problem with O=
Message-ID: <20050803064717.GP7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

For inclusion into 2.6.12.stable, extracted from current Linus git:

[PATCH] kbuild: build TAGS problem with O=

  make O=/dir TAGS

  fails with:

    MAKE   TAGS
  find: security/selinux/include: No such file or directory
  find: include: No such file or directory
  find: include/asm-i386: No such file or directory
  find: include/asm-generic: No such file or directory

  The problem is in this line:
  ifeq ($(KBUILD_OUTPUT),)

KBUILD_OUTPUT is not defined (ever) after make reruns itself.  This line is
used in the TAGS, tags, and cscope makes.

Signed-off-by: George Anzinger <george@mvista.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12.3.orig/Makefile	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/Makefile	2005-07-28 11:17:04.000000000 -0700
@@ -1149,7 +1149,7 @@
 #(which is the most common case IMHO) to avoid unneeded clutter in the big tags file.
 #Adding $(srctree) adds about 20M on i386 to the size of the output file!
 
-ifeq ($(KBUILD_OUTPUT),)
+ifeq ($(src),$(obj))
 __srctree =
 else
 __srctree = $(srctree)/
