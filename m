Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbTJFQRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTJFQRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:17:17 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:19080 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262384AbTJFQRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:17:09 -0400
Date: Mon, 6 Oct 2003 09:16:40 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 1/6] sysfs-kobject.patch
Message-ID: <20031006161639.GC4125@us.ibm.com>
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090003.GF4220@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test6-bk5 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 02:30:03PM +0530, Maneesh Soni wrote:
> diff -puN include/linux/kobject.h~sysfs-kobject include/linux/kobject.h
> --- linux-2.6.0-test6/include/linux/kobject.h~sysfs-kobject	2003-10-06 11:48:37.000000000 +0530
> +++ linux-2.6.0-test6-maneesh/include/linux/kobject.h	2003-10-06 11:48:51.000000000 +0530
> @@ -32,6 +32,12 @@ struct kobject {
>  	struct kset		* kset;
>  	struct kobj_type	* ktype;
>  	struct dentry		* dentry;
> + 	struct list_head	k_sibling;
> + 	struct list_head	k_children;
> +	struct list_head	attr;
> +	struct list_head	attr_group;
> +	struct rw_semaphore	k_rwsem;
> +	char 			*k_symlink;
>  };

Ouch.  Like Al said, this is too bloated.  Remember, not all kobjects
are registered for use in sysfs.  This makes the overhead for such
usages pretty high :(

thanks,

greg k-h
