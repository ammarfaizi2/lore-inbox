Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVCJCEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVCJCEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVCJCCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:02:14 -0500
Received: from smtp105.rog.mail.re2.yahoo.com ([206.190.36.83]:9556 "HELO
	smtp105.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262607AbVCJCA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:00:58 -0500
Subject: Exuberant ctags can tag files names too
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: sam@ravnborg.org, kai.germaschewski@unh.edu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1110420068.5526.39.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Mar 2005 21:01:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exuberant ctags can tag file names too. I find this extremely useful
when browsing kernel source, and so would like to share it with
everyone. (You can now type ":tag oprof.c" for example, and jump to the
file with that name.)

I previously sent a patch which naively just appended an "--extra=+f" to
the ctags line. Here's a much smarter patch that works by first
querrying if ctags is exuberant, and if so, whether the --extra
functionality is available before adding the line. Please apply.
Signed-off-by: John Kacur jkacur@rogers.com

--- Makefile.orig	2005-03-08 23:34:16.000000000 -0500
+++ Makefile	2005-03-09 20:25:06.710159432 -0500
@@ -1167,12 +1167,13 @@
 cmd_TAGS = $(all-sources) | etags -
 
 # 	Exuberant ctags works better with -I
-
+#	Exuberant ctags can tag file names with --extra=+f
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I
__initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL"`; \
-	$(all-sources) | xargs ctags $$CTAGSF -a
+	CTAGSF=`ctags --version | grep -iq exuberant && echo "-I
__initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL"`; \
+	CTAGSF_EXTRA=`ctags --version | grep -iq exuberant && ctags --help |
grep -q "\--extra" && echo "--extra=+f"`; \
+	$(all-sources) | xargs ctags $$CTAGSF -a $$CTAGSF_EXTRA
 endef
 
 TAGS: FORCE

This second patch is a trivial spelling correction. Please apply
Signed-off-by: John Kacur jkacur@rogers.com

--- Makefile.orig	2005-03-08 23:34:16.000000000 -0500
+++ Makefile	2005-03-09 20:26:29.063639800 -0500
@@ -18,7 +18,7 @@
 #
 # Most importantly: sub-Makefiles should only ever modify files in
 # their own directory. If in some directory we have a dependency on
-# a file in another dir (which doesn't happen often, but it's of
+# a file in another dir (which doesn't happen often, but it's often
 # unavoidable when linking the built-in.o targets which finally
 # turn into vmlinux), we will call a sub make in that other dir, and
 # after that we are sure that everything which is in that other dir


Kai, your e-mail address which I found in the list is different than the
one listed in the MAINTAINERS file.


