Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSHUS0G>; Wed, 21 Aug 2002 14:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318622AbSHUS0F>; Wed, 21 Aug 2002 14:26:05 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:48644 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318608AbSHUSZl>;
	Wed, 21 Aug 2002 14:25:41 -0400
Date: Wed, 21 Aug 2002 11:24:21 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.4.20-pre4
Message-ID: <20020821182421.GC1553@kroah.com>
References: <20020821182346.GA1553@kroah.com> <20020821182406.GB1553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020821182406.GB1553@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 24 Jul 2002 17:19:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.588   -> 1.589  
#	drivers/hotplug/pci_hotplug_core.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/20	greg@kroah.com	1.589
# PCI Hotplug: fixed oops when accessing pcihpfs.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Wed Aug 21 11:23:25 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Wed Aug 21 11:23:25 2002
@@ -76,7 +76,6 @@
 };
 
 static struct super_operations pcihpfs_ops;
-static struct file_operations pcihpfs_dir_operations;
 static struct file_operations default_file_operations;
 static struct inode_operations pcihpfs_dir_inode_operations;
 static struct vfsmount *pcihpfs_mount;	/* one of the mounts of our fs for reference counting */
@@ -122,7 +121,7 @@
 			break;
 		case S_IFDIR:
 			inode->i_op = &pcihpfs_dir_inode_operations;
-			inode->i_fop = &pcihpfs_dir_operations;
+			inode->i_fop = &dcache_dir_ops;
 			break;
 		}
 	}
@@ -234,11 +233,6 @@
 
 	return 0;
 }
-
-static struct file_operations pcihpfs_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	dcache_readdir,
-};
 
 static struct file_operations default_file_operations = {
 	read:		default_read_file,
