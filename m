Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSGXTHR>; Wed, 24 Jul 2002 15:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317904AbSGXTHQ>; Wed, 24 Jul 2002 15:07:16 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:28679 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317624AbSGXTHM>;
	Wed, 24 Jul 2002 15:07:12 -0400
Date: Wed, 24 Jul 2002 12:10:10 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.5.27
Message-ID: <20020724191010.GB11015@kroah.com>
References: <20020724190922.GA11015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724190922.GA11015@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 17:59:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.403.129.5 -> 1.403.129.6
#	drivers/hotplug/pci_hotplug_core.c	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/07	greg@kroah.com	1.403.129.6
# PCI Hotplug: fix i_nlink for root inode in pcihpfs
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Wed Jul 24 12:00:11 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Wed Jul 24 12:00:11 2002
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
