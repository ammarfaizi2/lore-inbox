Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSGGTnF>; Sun, 7 Jul 2002 15:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSGGTnE>; Sun, 7 Jul 2002 15:43:04 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:27662 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316538AbSGGTnC>;
	Sun, 7 Jul 2002 15:43:02 -0400
Date: Sun, 7 Jul 2002 12:43:25 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.5.25
Message-ID: <20020707194324.GO17922@kroah.com>
References: <20020707193331.GA17922@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020707193331.GA17922@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 09 Jun 2002 18:28:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For those people without BK, I'm including the patches here, like I've
been doing with the USB patches.  They are also all available in my
kernel.org directory if you don't like patches through email :)

greg k-h


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.628   -> 1.629  
#	drivers/hotplug/pci_hotplug_core.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/07	greg@kroah.com	1.629
# PCI Hotplug: fix i_nlink for root inode in pcihpfs
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Sun Jul  7 12:24:42 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Sun Jul  7 12:24:42 2002
@@ -109,6 +109,9 @@
 		case S_IFDIR:
 			inode->i_op = &pcihpfs_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inode->i_nlink++;
 			break;
 		}
 	}

