Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSJKM2u>; Fri, 11 Oct 2002 08:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262405AbSJKM2u>; Fri, 11 Oct 2002 08:28:50 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.130]:17345 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262372AbSJKM2u>; Fri, 11 Oct 2002 08:28:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: usbfs race while mounting/umounting
From: Wolfram Gloger <wg@malloc.de>
X-URL: http://www.malloc.de/
In-Reply-To: <E17zvS7-00041g-00@mrvdomng.kundenserver.de>
Message-Id: <E17zz00-0001BI-00@mrvdomng.kundenserver.de>
Date: Fri, 11 Oct 2002 14:34:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum made me look more closely and I think the
usb_bus_list_lock needs to stay, appended is a corrected patch for
2.4.x.

Regards,
Wolfram.

--- drivers/usb/inode.c.orig	Sat Aug  3 02:39:45 2002
+++ drivers/usb/inode.c	Fri Oct 11 14:33:34 2002
@@ -628,6 +628,7 @@
         s->s_root = d_alloc_root(root_inode);
         if (!s->s_root)
                 goto out_no_root;
+	lock_kernel();
 	list_add_tail(&s->u.usbdevfs_sb.slist, &superlist);
 	for (i = 0; i < NRSPECIAL; i++) {
 		if (!(inode = iget(s, IROOT+1+i)))
@@ -646,6 +647,7 @@
 		recurse_new_dev_inode(bus->root_hub, s);
 	}
 	up (&usb_bus_list_lock);
+	unlock_kernel();
         return s;
 
  out_no_root:

