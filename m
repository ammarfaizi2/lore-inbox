Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUEQMIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUEQMIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbUEQMIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:08:41 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:45467 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264977AbUEQMIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:08:39 -0400
Date: Mon, 17 May 2004 17:34:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.6-mm3] sysfs backing store ver 0.6
Message-ID: <20040517120443.GB1249@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Please find the following patch set for sysfs backing store for 2.6.6-mm3 
kernel. I have fixed the rejects and there are also a few code changes.

The main change is related to providing protection against vulnerability of 
parent dentry going off before the sysfs file being deleted. If you have 
seen there was a oops message reported with 2.6.6-mm1 in which parent 
dentry's ref count is zero when it was trying to remove a sysfs link.

http://marc.theaimsgroup.com/?l=linux-kernel&m=108422899203505&w=2

The changes I did are in fs/sysfs/inode.c:sysfs_hash_and_remove() and
sysfs_remove_dir(), where it is now checking s_dentry field of the 
corresponding sysfs_dirent to get the dentry (if valid) of the file 
being deleted. Apart from being safe against parent dentry going off 
before the child, this change also avoids allocating the dentry in the 
removal path by not doing the lookup. 

Please include the following patches in the next -mm and also note that they
all depend on the fix-sysfs-symlinks.patch, I just mailed.
http://marc.theaimsgroup.com/?l=linux-kernel&m=108479506507825&w=2

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
