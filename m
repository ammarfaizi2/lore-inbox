Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUEEMuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUEEMuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 08:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUEEMux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 08:50:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39928 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264641AbUEEMuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 08:50:08 -0400
Date: Wed, 5 May 2004 18:27:02 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>
Subject: [RFC 0/6] sysfs backing store ver 0.5
Message-ID: <20040505125702.GA1244@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch set contains ver 0.5 patches implementing sysfa backig 
store for leaf sysfs entries. There have been changed from previuos version 
based on the comments from Al Viro. The main changes are

1) Re-implemented file_operations method for sysfs directories. 
sysfs_dir_open(), sysfs_dir_close(), sysfs_read_dir() and sysfs_dir_lseek()
are changed to use sysfs_dirent based tree instead of dentry based VFS tree.
This provides cleaner code and also corrects the error path in sysfs_open_dir()
where it might end up in close entries, opened by some other thread. 

2) ->umount_begin() is removed as mount -o remount provides the same 
functionalities.

3) changes to accomodate current sysfs changes related to symlinks and
sysfs_rename_dir()

The patch set needs the following patches to get applied on top of 
2.6.6-rc3-mm1 in the sequence as mentioned.

1) sysfs-symlinks-fix.patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=108331963219401&w=2

2) kobject_set_name-cleanup-01.patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=108366251207999&w=2

3) sysfs_rename_dir-cleanup.patch
http://marc.theaimsgroup.com/?l=linux-kernel&m=108373318213824&w=2

BTW, all the patches apply cleany to 2.6.6.-rc3-mm2 also.


Al, please let me know any further changes/suggestions.

Thanks
Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
