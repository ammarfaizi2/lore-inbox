Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbTKTQl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 11:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTKTQl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 11:41:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:35001 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262061AbTKTQl4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 11:41:56 -0500
Date: Thu, 20 Nov 2003 22:10:13 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-ID: <20031120164012.GA1760@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20031120054707.GA1724@in.ibm.com> <20031120054957.GD24159@parcelfarce.linux.theplanet.co.uk> <20031120055655.GB1724@in.ibm.com> <20031120102525.GD1367@in.ibm.com> <20031120071709.0acf35aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120071709.0acf35aa.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 07:17:09AM -0800, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >  cpu 0						cpu 1
> >  dcache_dir_open()
> >  --> adds the cursor dentry
> > 
> >  					sysfs_remove_dir()
> >  					--> list_del_init cursor dentry
> > 
> >  dcache_readdir()
> >  --> loops forever on inititalized cursor dentry.
> > 
> > 
> >  Though all these operations happen under parent's i_sem, but it is dropped 
> >  between ->open() and ->readdir() as both are different calls. 
> > 
> >  I think people will also agree that there is no need for sysfs_remove_dir() 
> >  to modify d_subdirs list.
> 
> Seems to me that the libfs code is fragile.
> 
> What happens if the dentry at filp->f_private_data gets moved to a
> different directory after someone did dcache_dir_open()?  Does the loop
> in dcache_readdir() go infinite again?

I am not sure if it is that bad. AFAICS, private_data points to a dummy
dentry marking the current directory read position, that dentry cannot
be moved to a different directory.

Thanks
Dipankar
