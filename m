Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267694AbUG3PMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267694AbUG3PMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267699AbUG3PMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:12:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13970 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267694AbUG3PMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:12:01 -0400
Date: Fri, 30 Jul 2004 10:11:52 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: Andreas Schwab <schwab@suse.de>
Cc: kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add ia64 support to rpm Makefile target
Message-ID: <20040730151151.GE24472@sgi.com>
References: <20040729180732.GA15920@sgi.com> <jek6wmz80u.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jek6wmz80u.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 01:52:01AM +0200, Andreas Schwab wrote:
|
| How about using %ifarch ia64 in the generated spec file?

Yeah, I think I like that better, too.  New patch attached below.

Greg

Signed-off-by: Greg Edwards <edwardsg@sgi.com>


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/29 13:00:54-05:00 edwardsg@attica.americas.sgi.com 
#   Add ia64 support to the rpm Makefile target.
# 
# scripts/package/mkspec
#   2004/07/29 13:00:41-05:00 edwardsg@attica.americas.sgi.com +13 -2
#   On ia64, only the EFI (fat) partition is available to boot from.  The
#   rpm needs to install the kernel under /boot/efi to be useable on ia64.
# 
# mkspec |    9 +++++++++
# 1 files changed, 9 insertions(+)
#
Index: work-26x-bk/scripts/package/mkspec
===================================================================
--- work-26x-bk.orig/scripts/package/mkspec	2004-07-29 15:40:16.000000000 -0500
+++ work-26x-bk/scripts/package/mkspec	2004-07-30 09:44:51.000000000 -0500
@@ -43,10 +43,19 @@ echo "%build"
 echo "make clean && make"
 echo ""
 echo "%install"
+echo "%ifarch ia64"
+echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+echo "%else"
 echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+echo "%endif"
 
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make modules_install'
+echo "%ifarch ia64"
+echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/efi/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo 'ln -s '"efi/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION" '$RPM_BUILD_ROOT'"/boot/"
+echo "%else"
 echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
+echo "%endif"
 
 echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$VERSION.$PATCHLEVEL.$SUBLEVEL$EXTRAVERSION"
 
