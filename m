Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbTEUJhU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 05:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTEUJhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 05:37:20 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51931 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262032AbTEUJhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 05:37:19 -0400
Date: Wed, 21 May 2003 15:23:14 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Paul.McKenney@us.ibm.com
Subject: Re: [patch 1/2] vfsmount_lock
Message-ID: <20030521095313.GA2861@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030521092502.GD1198@in.ibm.com> <20030521023523.655bc8f2.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521023523.655bc8f2.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 02:35:23AM -0700, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> >  struct vfsmount *lookup_mnt(struct vfsmount *mnt, struct dentry *dentry)
> >   {
> >  +	spin_lock(&vfsmount_lock);
> >   	for (;;) {
> >   		tmp = tmp->next;
> >   		p = NULL;
> >   		if (tmp == head)
> >   			break;
> >   		p = list_entry(tmp, struct vfsmount, mnt_hash);
> >  -		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry)
> >  +		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
> >  +			found = mntget(p);
> >   			break;
> >  +		}
> >   	}
> >  -	return p;
> >  +	spin_lock(&vfsmount_lock);
> >  +	return found;
> >   }
> 
> err, how many times do you want to spin that lock?

None, if you apply the second patch ;-)

Thanks
Dipankar
