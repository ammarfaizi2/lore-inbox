Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWJQSjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWJQSjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWJQSji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:39:38 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:37320 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751424AbWJQSjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:39:33 -0400
Date: Tue, 17 Oct 2006 20:37:14 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Mingming Cao <cmm@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: config EXT4DEV_FS question
In-Reply-To: <1161088430.14171.2.camel@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.61.0610172034090.30104@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0610170100480.30479@yvahk01.tjqt.qr>
 <1161088430.14171.2.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> something I have seen during `make oldconfig`, in fs/Kconfig we find:
>> 
>> config EXT4DEV_FS
>>    ...
>> 
>>   To compile this file system support as a module, choose M here. The
>>   module will be called ext4dev.  Be aware, however, that the
>>   filesystem of your root partition (the one containing the directory
>>   /) cannot be compiled as a module, and so this could be dangerous.
>> 
>> Why can't this be compiled as a module when / is ext4? There are a lot
>> of people out there having no filesystem code included in the kernel at
>> all (includes at least SUSE users using the default vendor kernel), but
>> instead have them as modules in their initramfss (what's the proper
>> plural of initramfs?). What is it that makes ext4 different?
>
>That same paragraph is in the help text of both ext2 and ext3.  It is a
>bit outdated and should probably be cleaned up in all three.

Then I suggest removing the bogus part, as per following patch.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.19-rc2/fs/Kconfig
===================================================================
--- linux-2.6.19-rc2.orig/fs/Kconfig
+++ linux-2.6.19-rc2/fs/Kconfig
@@ -12,9 +12,7 @@ config EXT2_FS
 	  Ext2 is a standard Linux file system for hard disks.
 
 	  To compile this file system support as a module, choose M here: the
-	  module will be called ext2.  Be aware however that the file system
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this could be dangerous.
+	  module will be called ext2.
 
 	  If unsure, say Y.
 
@@ -98,9 +96,7 @@ config EXT3_FS
 	  (available at <http://sourceforge.net/projects/e2fsprogs/>).
 
 	  To compile this file system support as a module, choose M here: the
-	  module will be called ext3.  Be aware however that the file system
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this may be dangerous.
+	  module will be called ext3.
 
 config EXT3_FS_XATTR
 	bool "Ext3 extended attributes"
@@ -163,9 +159,7 @@ config EXT4DEV_FS
 	  features will be added to ext4dev gradually.
 
 	  To compile this file system support as a module, choose M here. The
-	  module will be called ext4dev.  Be aware, however, that the filesystem
-	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this could be dangerous.
+	  module will be called ext4dev.
 
 	  If unsure, say N.
 
#<EOF>


	-`J'
-- 
