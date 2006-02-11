Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWBKAds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWBKAds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 19:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWBKAds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 19:33:48 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:17543
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932276AbWBKAdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 19:33:47 -0500
Date: Fri, 10 Feb 2006 16:33:33 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
Message-ID: <20060211003333.GA18575@kroah.com>
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com> <20051123081845.GA32021@elte.hu> <20051123125212.GD22714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123125212.GD22714@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 06:22:13PM +0530, Maneesh Soni wrote:
> On Wed, Nov 23, 2005 at 09:18:45AM +0100, Ingo Molnar wrote:
> > 
> [..]
> > on a related note - i've been carrying the patch below in -rt for 2 
> > months (i.e. Steven's kernel has it too), as a workaround against the 
> > crash described below.
> > 
> [..]
> 
> > i'm occasionally getting the crash below on a PREEMPT_RT kernel. Might 
> > be a PREEMPT_RT bug, or might be some sysfs race only visible under 
> > PREEMPT_RT. Any ideas? The crash is at:
> > 
> > (gdb) list *0xc01a2095
> > 0xc01a2095 is in sysfs_hash_and_remove (fs/sysfs/inode.c:229).
> > 224     }
> > 225
> > 226     void sysfs_hash_and_remove(struct dentry * dir, const char * name)
> > 227     {
> > 228             struct sysfs_dirent * sd;
> > 229             struct sysfs_dirent * parent_sd = dir->d_fsdata;
> > 230
> > 231             if (dir->d_inode == NULL)
> > 232                     /* no inode means this hasn't been made visible yet */
> > 233                     return;
> > (gdb)
> > 
> Looks like here it is crashing due to bogus dentry pointer in the kobject 
> kobj->dentry. Could be some stale pointer? 

Did you ever figure anything out here?  I'm seeing a lot more reports of
this problem lately, especially if you enable slab debugging.  For
example:
	http://bugzilla.kernel.org/show_bug.cgi?id=5876

thanks,

greg k-h
