Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUKFGUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUKFGUp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 01:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUKFGUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 01:20:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:11699 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261324AbUKFGUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 01:20:34 -0500
Date: Fri, 5 Nov 2004 22:20:48 -0800
From: Maneesh Soni <maneesh@in.ibm.com>
To: Milton Miller <miltonm@bga.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sysfs backing store error path confusion
Message-ID: <20041106062047.GA2513@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200411050749.iA57nXlP076996@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411050749.iA57nXlP076996@sullivan.realtime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 01:49:34AM -0600, Milton Miller wrote:
> 
> On Nov 3, 2004, at 3:42 PM, Greg KH wrote:
> 
> |On Tue, Nov 02, 2004 at 10:03:34AM -0600, Maneesh Soni wrote:
> ||On Tue, Nov 02, 2004 at 02:46:58AM -0600, Milton Miller wrote:
> |||sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
> |||were expecting NULL.  
> ||
> ||Thanks for spotting this. But as you said, I will prefer to change the callee.
> ||How about this patch? 
> ..
> ||-		return -ENOMEM;
> ||+		return NULL;
> |
> |Actually, this needs to be a 0, not NULL, otherwise the compiler
> |complains with a warning.  I've fixed it up and applied it.
> |
> |thanks,
> |
> |greg k-h
> 
> I wondered why greg thought the type was wrong.   After it was merged I 
> realized that the wrong function was changed.  Here's an attempt to fix
> both errors.
> 

Yes, it is correct now. Sorry about the confusion. I edited at the wrong
palce.

Thanks
Maneesh

> 
> ===== fs/sysfs/dir.c 1.27 vs edited =====
> --- 1.27/fs/sysfs/dir.c	2004-11-04 22:37:32 +01:00
> +++ edited/fs/sysfs/dir.c	2004-11-05 08:10:54 +01:00
> @@ -38,7 +38,7 @@ static struct sysfs_dirent * sysfs_new_d
>  
>  	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
>  	if (!sd)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  
>  	memset(sd, 0, sizeof(*sd));
>  	atomic_set(&sd->s_count, 1);
> @@ -56,7 +56,7 @@ int sysfs_make_dirent(struct sysfs_diren
>  
>  	sd = sysfs_new_dirent(parent_sd, element);
>  	if (!sd)
> -		return 0;
> +		return -ENOMEM;
>  
>  	sd->s_mode = mode;
>  	sd->s_type = type;
> 

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
