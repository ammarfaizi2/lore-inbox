Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUD3KKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUD3KKw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 06:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUD3KKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 06:10:52 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:41344 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261378AbUD3KKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 06:10:50 -0400
Date: Fri, 30 Apr 2004 15:43:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC 0/2] kobject_set_name - error handling
Message-ID: <20040430101333.GB25296@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040417090712.B11481@flint.arm.linux.org.uk> <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040420161602.GB9603@kroah.com> <20040421101104.GA7921@in.ibm.com> <20040422213736.GL17014@parcelfarce.linux.theplanet.co.uk> <20040423085218.GB27638@in.ibm.com> <20040423092641.GM17014@parcelfarce.linux.theplanet.co.uk> <20040429130353.GC11624@in.ibm.com> <20040429154104.GI17014@parcelfarce.linux.theplanet.co.uk> <20040430100543.GA25296@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430100543.GA25296@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMO error handling/propogation is incorrect or not there in most of the places
in the users of kobject_set_name. sysfs_rename_dir is one of them.
                                                                                
1) sysfs_rename_dir ignores return code from kobject_set_name,
   and returns void
2) kobject_rename returns void
3) dev_change_name ignore return code from class_device_rename.
                                                                                
This can lead to mismatch in kobject name and the directory name. Now
correcting this will involve changing the APIs at this point of time.
Luckily we have just one user of sysfs_rename_dir as of now.
                                                                                
Like this there are 14 other users of kobject_set_name and only one checks
the return code. Out of them atleast following are problematic IMO.
                                                                                
bus_add_driver()
bus_register()
sys_dev_register()
sysfs_rename_dir()
                                                                                
Others are not because we have name length less than KOBJ_NAME_LEN and there
will be no allocation. I have corrected the above problems in the following
two patches.
                                                                                
Please comment.
                                                                                
Thanks,
Maneesh
                                                                                

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
