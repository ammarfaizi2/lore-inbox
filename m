Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVCTA2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVCTA2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 19:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVCTA2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 19:28:23 -0500
Received: from mail.autoweb.net ([198.172.237.26]:47887 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261931AbVCTA2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 19:28:15 -0500
Date: Sat, 19 Mar 2005 19:28:00 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Ajay Patel <patela@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [KBUILD] Bug in make deb-pkg when using seperate source and object directories
Message-ID: <20050320002800.GJ5318@mythryan2.michonline.com>
Mail-Followup-To: Ajay Patel <patela@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20050313060940.GB7828@mythryan2.michonline.com> <90f56e4805031411593fd945f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f56e4805031411593fd945f2@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:59:26AM -0800, Ajay Patel wrote:
> I had a similar problem building binrpm-pkg.
> Try following patch. It worked for me.

My problem wasn't actually resolved by this - the make in builddeb still
caused issues.

So, a normal, unified diff form of the patch, fixed up, is attached.

Signed-off-By: Ryan Anderson <ryan@michonline.com>

Index: local-quilt/scripts/package/Makefile
===================================================================
--- local-quilt.orig/scripts/package/Makefile	2005-03-19 19:25:03.000000000 -0500
+++ local-quilt/scripts/package/Makefile	2005-03-19 19:25:06.000000000 -0500
@@ -59,7 +59,7 @@ $(objtree)/binkernel.spec: $(MKSPEC) $(s
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $@
 	
 binrpm-pkg: $(objtree)/binkernel.spec
-	$(MAKE)
+	$(MAKE) KBUILD_SRC=
 	set -e; \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version
 	set -e; \
@@ -74,7 +74,7 @@ clean-files += $(objtree)/binkernel.spec
 #
 .PHONY: deb-pkg
 deb-pkg:
-	$(MAKE)
+	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
 clean-dirs += $(objtree)/debian/
Index: local-quilt/scripts/package/builddeb
===================================================================
--- local-quilt.orig/scripts/package/builddeb	2005-03-19 19:25:03.000000000 -0500
+++ local-quilt/scripts/package/builddeb	2005-03-19 19:25:27.000000000 -0500
@@ -25,7 +25,7 @@ cp .config "$tmpdir/boot/config-$version
 cp $KBUILD_IMAGE "$tmpdir/boot/vmlinuz-$version"
 
 if grep -q '^CONFIG_MODULES=y' .config ; then
-	INSTALL_MOD_PATH="$tmpdir" make modules_install
+	INSTALL_MOD_PATH="$tmpdir" make KBUILD_SRC= modules_install
 fi
 
 # Install the maintainer scripts

-- 

Ryan Anderson
  sometimes Pug Majere
