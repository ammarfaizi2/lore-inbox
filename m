Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVCMClG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVCMClG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 21:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVCMClG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 21:41:06 -0500
Received: from mail.autoweb.net ([198.172.237.26]:63751 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261780AbVCMCkv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 21:40:51 -0500
Date: Sat, 12 Mar 2005 21:40:14 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       Ryan Anderson <ryan@michonline.com>, Jeff Dike <jdike@addtoit.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] UML - Restore proper descriptions in make deb-pkg target
Message-ID: <20050313024014.GZ7828@mythryan2.michonline.com>
Mail-Followup-To: Blaisorblade <blaisorblade@yahoo.it>,
	user-mode-linux-devel@lists.sourceforge.net,
	Ryan Anderson <ryan@michonline.com>, Jeff Dike <jdike@addtoit.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20050307182828.GS7828@mythryan2.michonline.com> <200503091003.02120.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503091003.02120.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:03:01AM +0100, Blaisorblade wrote:
> 
> Yes, it must go in... only the Description is a bit problematic, since you'll 
> get with the below:
> Description: Linux kernel, version linux-2.6.11
> 
> Description: Linux kernel, version user-mode-linux-2.6.11

Good point.

This pulls the description from the Debian user-mode-linux package, and
puts $version back in the appropriate places for both descriptions.

Incremental on top of the previous patch.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

Index: local-quilt/scripts/package/builddeb
===================================================================
--- local-quilt.orig/scripts/package/builddeb	2005-03-12 20:36:24.000000000 -0500
+++ local-quilt/scripts/package/builddeb	2005-03-12 20:40:50.000000000 -0500
@@ -73,6 +73,29 @@
 EOF
 
 # Generate a control file
+if [ "$ARCH" == "um" ]; then
+
+cat <<EOF > debian/control
+Source: linux
+Section: base
+Priority: optional
+Maintainer: $name
+Standards-Version: 3.6.1
+
+Package: $packagename
+Architecture: any
+Description: User Mode Linux kernel, version $version
+ User-mode Linux is a port of the Linux kernel to its own system call
+ interface.  It provides a kind of virtual machine, which runs Linux
+ as a user process under another Linux kernel.  This is useful for
+ kernel development, sandboxes, jails, experimentation, and
+ many other things.
+ .
+ This package contains the Linux kernel, modules and corresponding other
+ files version $version
+EOF
+
+else
 cat <<EOF > debian/control
 Source: linux
 Section: base
@@ -82,10 +105,11 @@
 
 Package: $packagename
 Architecture: any
-Description: Linux kernel, version $packagename
+Description: Linux kernel, version $version
  This package contains the Linux kernel, modules and corresponding other
- files version $packagename
+ files version $version
 EOF
+fi
 
 # Fix some ownership and permissions
 chown -R root:root "$tmpdir"

-- 

Ryan Anderson
  sometimes Pug Majere
