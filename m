Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291204AbSBGS1i>; Thu, 7 Feb 2002 13:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSBGS12>; Thu, 7 Feb 2002 13:27:28 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:65290 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S291204AbSBGS00>;
	Thu, 7 Feb 2002 13:26:26 -0500
Date: Thu, 7 Feb 2002 10:23:38 -0800
From: Greg KH <greg@kroah.com>
To: John Weber <weber@nyc.rr.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: PCI Hotplug and Linux 2.5.4-pre2
Message-ID: <20020207182338.GB18310@kroah.com>
In-Reply-To: <3C62C4AB.3040109@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C62C4AB.3040109@nyc.rr.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 10 Jan 2002 15:27:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 01:17:15PM -0500, John Weber wrote:
> I can't find the definition of pcihpfs_fs_type used in 
> pci_hotplug_core.c in register_filesystem(), unregister_filesystem(),
> and kern_mount().  This is causing a compilation error.

Here's the fix, I'll send it on.

thanks,

greg k-h


diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Thu Feb  7 10:22:25 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Thu Feb  7 10:22:25 2002
@@ -414,7 +414,7 @@
 	}
 
 	spin_unlock (&mount_lock);
-	mnt = kern_mount (&pcihpfs_fs_type);
+	mnt = kern_mount (&pcihpfs_type);
 	if (IS_ERR(mnt)) {
 		err ("could not mount the fs...erroring out!\n");
 		return -ENODEV;
@@ -1139,7 +1139,7 @@
 	spin_lock_init(&list_lock);
 
 	dbg("registering filesystem.\n");
-	result = register_filesystem(&pcihpfs_fs_type);
+	result = register_filesystem(&pcihpfs_type);
 	if (result) {
 		err("register_filesystem failed with %d\n", result);
 		goto exit;
@@ -1153,7 +1153,7 @@
 
 static void __exit pci_hotplug_exit (void)
 {
-	unregister_filesystem(&pcihpfs_fs_type);
+	unregister_filesystem(&pcihpfs_type);
 }
 
 module_init(pci_hotplug_init);
