Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbUKCVwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUKCVwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUKCVug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:50:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:47233 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261919AbUKCVpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:45:25 -0500
Date: Wed, 3 Nov 2004 13:42:09 -0800
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Milton Miller <miltonm@bga.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: sysfs backing store error path confusion
Message-ID: <20041103214209.GB30482@kroah.com>
References: <200411020846.iA28kw3g051219@sullivan.realtime.net> <20041102160334.GB3191@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102160334.GB3191@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 10:03:34AM -0600, Maneesh Soni wrote:
> On Tue, Nov 02, 2004 at 02:46:58AM -0600, Milton Miller wrote:
> > sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
> > were expecting NULL.  
> > 
> > Compile & link tested.  (Yes, changing the callee would be a smaller change).
> > 
> 
> Thanks for spotting this. But as you said, I will prefer to change the callee.
> How about this patch? 
> 
> Andrew, Greg, please include this if found ok.
> 
> Thanks
> Maneesh
> 
> 
> 
> o sysfs_new_dirent to retrun NULL if kmalloc fails. Thanks to Milton Miller 
>   for spotting this.
> 
> Signed-off-by: <maneesh@in.ibm.com>
> ---
> 
>  linux-2.6.10-rc1-bk12-maneesh/fs/sysfs/dir.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN fs/sysfs/dir.c~fix-sysfs_new_dirent-return fs/sysfs/dir.c
> --- linux-2.6.10-rc1-bk12/fs/sysfs/dir.c~fix-sysfs_new_dirent-return	2004-11-02 08:38:57.000000000 -0600
> +++ linux-2.6.10-rc1-bk12-maneesh/fs/sysfs/dir.c	2004-11-02 09:17:18.000000000 -0600
> @@ -38,7 +38,7 @@ static struct sysfs_dirent * sysfs_new_d
>  
>  	sd = kmalloc(sizeof(*sd), GFP_KERNEL);
>  	if (!sd)
> -		return -ENOMEM;
> +		return NULL;

Actually, this needs to be a 0, not NULL, otherwise the compiler
complains with a warning.  I've fixed it up and applied it.

thanks,

greg k-h
