Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWBWLCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBWLCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 06:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWBWLCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 06:02:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:43702 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750708AbWBWLCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 06:02:07 -0500
Date: Thu, 23 Feb 2006 16:29:35 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, zanussi@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060223105934.GA6884@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20060219210733.GA3682@linux-sh.org> <20060219210757.GB3682@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219210757.GB3682@linux-sh.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 11:07:57PM +0200, Paul Mundt wrote:


> +
> +static struct dentry *
> +sysfs_create_buf_file(const char *filename, struct dentry *dentry, int mode,
> +		      struct rchan_buf *buf, int *is_global)
> +{
> +	struct relay_attribute *attr = (struct relay_attribute *)dentry;
> +	struct dentry *parent = attr->kobj->dentry;
> +	int ret;
> +
> +	attr->attr.mode = mode;
> +	attr->rchan_buf = buf;
> +
> +	ret = sysfs_add_file(parent, &attr->attr, SYSFS_KOBJ_RELAY_ATTR);
> +	if (unlikely(ret != 0))
> +		return NULL;
> +
> +	dentry = lookup_one_len(filename, parent, strlen(filename));

lookup_one_len() needs parent's i_mutex.


> +	if (IS_ERR(dentry))
> +		sysfs_hash_and_remove(parent, filename);

Also wondering if you have considered the case of -EEXIST?

> +
> +	return dentry;
> +}


Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
