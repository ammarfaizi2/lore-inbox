Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTJFNlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTJFNlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:41:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53995 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262064AbTJFNls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:41:48 -0400
Date: Mon, 6 Oct 2003 14:41:47 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 1/6] sysfs-kobject.patch
Message-ID: <20031006134147.GO7665@parcelfarce.linux.theplanet.co.uk>
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090003.GF4220@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 02:30:03PM +0530, Maneesh Soni wrote:
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

Too bloated.  I suspect that we will be better off if we simply leave
current scheme for directories and have dentries allocated on demand
for everything else.
