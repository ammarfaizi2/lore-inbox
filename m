Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbUL3Nja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbUL3Nja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 08:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUL3Nhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 08:37:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:43763 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261519AbUL3Ngm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 08:36:42 -0500
Date: Thu, 30 Dec 2004 19:04:59 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [Fake patch] Make sysfs_dirent.s_type an unsigned short
Message-ID: <20041230133459.GC3122@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200412030356.iB33uSg03460@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412030356.iB33uSg03460@adam.yggdrasil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 04:08:58AM +0000, Adam J. Richter wrote:
> 	Here is a fake patch against my heavily hacked sysfs tree
> to change sysfs_dirent.s_type from an int to an unsigned short.
> It appears next to another unsigned short (s_mode), so it should
> save 4 bytes per sysfs node.
> 
> 	Note that this patch will not apply to a pristine 2.6.10-rc2-bk15
> tree, because I've moved the declaration of struct sysfs_dirent
> from include/linux/sysfs.h to fs/sysfs/sysfs.h in a previous patch.
> 
> 	By the way, I have to sheepishly admit that somehow I previously
> underestimated the size of struct sysfs_dirent.  Only now
> with s_children and s_count removed and s_type shortened to 16 bits
> does sysfs_dirent occupy 32 bytes, according to /proc/slabinfo.
> This does not effect my previous statements about how much memory
> is saved by each of the patches that I've posted.  It just means
> the original amount of memory being used was more.
> 

Looks sane.

Thanks
Maneesh

> --- linux.prev/fs/sysfs/sysfs.h	2004-12-03 11:51:19.000000000 +0800
> +++ linux/fs/sysfs/sysfs.h	2004-12-03 00:51:44.000000000 +0800
> @@ -13,7 +13,7 @@
>  struct sysfs_dirent {
>  	struct list_head	s_sibling;
>  	void 			* s_element;
> -	int			s_type;
> +	unsigned short		s_type;
>  	umode_t			s_mode;
>  	struct dentry		* s_dentry;
>  };
> -

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
