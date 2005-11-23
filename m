Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVKWMzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVKWMzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVKWMzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:55:03 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:18355 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750759AbVKWMzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:55:01 -0500
Date: Wed, 23 Nov 2005 18:22:13 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Greg KH <greg@kroah.com>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
Message-ID: <20051123125212.GD22714@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123081845.GA32021@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 09:18:45AM +0100, Ingo Molnar wrote:
> 
[..]
> on a related note - i've been carrying the patch below in -rt for 2 
> months (i.e. Steven's kernel has it too), as a workaround against the 
> crash described below.
> 
[..]

> i'm occasionally getting the crash below on a PREEMPT_RT kernel. Might 
> be a PREEMPT_RT bug, or might be some sysfs race only visible under 
> PREEMPT_RT. Any ideas? The crash is at:
> 
> (gdb) list *0xc01a2095
> 0xc01a2095 is in sysfs_hash_and_remove (fs/sysfs/inode.c:229).
> 224     }
> 225
> 226     void sysfs_hash_and_remove(struct dentry * dir, const char * name)
> 227     {
> 228             struct sysfs_dirent * sd;
> 229             struct sysfs_dirent * parent_sd = dir->d_fsdata;
> 230
> 231             if (dir->d_inode == NULL)
> 232                     /* no inode means this hasn't been made visible yet */
> 233                     return;
> (gdb)
> 
Looks like here it is crashing due to bogus dentry pointer in the kobject 
kobj->dentry. Could be some stale pointer? 

Just got the mbox.. will go thru it more closely..

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
