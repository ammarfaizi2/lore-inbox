Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUHHVkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUHHVkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUHHVkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:40:10 -0400
Received: from imap.gmx.net ([213.165.64.20]:24470 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263736AbUHHVkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:40:02 -0400
X-Authenticated: #1725425
Date: Sun, 8 Aug 2004 23:43:45 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Greg KH <greg@kroah.com>
Cc: albert@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: dynamic /dev security hole?
Message-Id: <20040808234345.7460a8ca.Ballarin.Marc@gmx.de>
In-Reply-To: <20040808162115.GA7597@kroah.com>
References: <1091969260.5759.125.camel@cube>
	<20040808175834.59758fc0.Ballarin.Marc@gmx.de>
	<20040808162115.GA7597@kroah.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Aug 2004 09:21:15 -0700
Greg KH <greg@kroah.com> wrote:

> Patches to the udev HOWTO and FAQ are always welcome.
> 

How about this? The first part is a spelling fix.

--- udev-FAQ.orig	2004-08-08 18:42:03.639348944 +0200
+++ udev-FAQ	2004-08-08 23:14:07.895684768 +0200
@@ -23,7 +23,7 @@
 	- the former had stayed around for many months with maintainer
 	  claiming that everything works fine
 	- the latter had stayed, period.
-	- the devfs maintainer/author disappeared and stoped maintaining
+	- the devfs maintainer/author disappeared and stopped maintaining
 	  the code.
 
 Q: But udev will not automatically load a driver if a /dev node is opened
@@ -98,6 +98,19 @@
    And don't have to be root but will get full permissions on /pendrive.
    This works even without udev if /udev/pendrive is replaced by
/dev/sda1
 
+Q: Are there any security issues that I should be aware of?
+A: When using dynamic device numbers, a given pair of major/minor numbers
may
+   point to different hardware over time. If a user has permission to
access a
+   specific device node directly and is able to create hard links to this
node,
+   he or she can do so to create a copy of the device node. When the
device is
+   unplugged and udev removes the device node, the user's hard link
remains.
+   If the device node is later recreated with different permissions the
hard 
+   link can still be used to access the device using the old permissions.
+   (The same problem exists when using PAM to change permissions on
login.)
+    
+   The simplest solution is to prevent the creation of hard links by
putting
+   /dev in a separate filesystem (tmpfs, ramfs, ...).
+    
 Q: I have other questions about udev, where do I ask them?
 A: The linux-hotplug-devel mailing list is the proper place for it.  The
    address for it is linux-hotplug-devel@lists.sourceforge.net
