Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTKLMZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 07:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbTKLMZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 07:25:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:31191 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261298AbTKLMZH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 07:25:07 -0500
Date: Wed, 12 Nov 2003 17:53:44 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       Patrick Mochel <mochel@osdl.org>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 0/5] Backing Store for sysfs (Overhauled)
Message-ID: <20031112122344.GD14580@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following patch set has the overhauled prototype for sysfs backing store
for comments. I have tried to keep all the comments and suggestions from the 
last time in mind.

The main complaint was of over bloating kobject structure which becomes more
painful when kobject is not part of sysfs. So now I have changed the data
structures entirely. There is _no_ increase in the size of kobject structure.
The kobject hierarchy is represented in the form of a new structure called
sysfs_dirent (size 48 - bytes). sysfs_dirent will be there only for kobject
elements (kobject, attribute, attribute group, symlink) which are represented 
in sysfs. kobject structre has just one change. Now kobject has a field
pointing to its sysfs_dirent instead of dentry.

struct sysfs_dirent {
        struct list_head        s_sibling;
        struct list_head        s_children;
        void                    * s_element;
        struct dentry           * s_dentry;
        int                     s_type;
        struct rw_semaphore     s_rwsem;
};

The concept is still the same that in this prototype also we create dentry and 
inode on the fly when they are first looked up. This is done for both leaf or 
non-leaf dentries. The generic nature of sysfs_dirent makes it easy to do for 
both leaf or non-leaf dentries. 

Please review the patches following this posting. For testing apply all
the patches as they are splitted just for review.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
