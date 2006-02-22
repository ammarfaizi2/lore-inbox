Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWBVSsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWBVSsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBVSsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:48:54 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:32903
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750810AbWBVSsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:48:53 -0500
Date: Wed, 22 Feb 2006 10:48:53 -0800
From: Greg KH <gregkh@suse.de>
To: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Cc: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH 1/3] sysfs representation of stacked devices (common) (rev.2)
Message-ID: <20060222184853.GB13638@suse.de>
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D8C.1060904@ce.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC8D8C.1060904@ce.jp.nec.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 11:13:00AM -0500, Jun'ichi Nomura wrote:
> +/* This is a mere directory in sysfs. No methods are needed. */
> +static struct kobj_type bd_holder_ktype = {
> +	.release	= NULL,
> +	.sysfs_ops	= NULL,
> +	.default_attrs	= NULL,
> +};

That doesn't look right.  You always need a release function.

> +static inline void add_holder_dir(struct block_device *bdev)
> +{
> +	struct kobject *kobj = &bdev->bd_holder_dir;
> +
> +	kobj->ktype = &bd_holder_ktype;
> +	kobject_set_name(kobj, "holders");
> +	kobj->parent = bdev_get_kobj(bdev);
> +	kobject_init(kobj);
> +	kobject_add(kobj);
> +	kobject_put(kobj->parent);
> +}
> +
> +static inline void del_holder_dir(struct block_device *bdev)
> +{
> +	/*
> +	 * Don't kobject_unregister to avoid memory allocation
> +	 * in kobject_hotplug.
> +	 */
> +	kobject_del(&bdev->bd_holder_dir);
> +	kobject_put(&bdev->bd_holder_dir);
> +}

No, do it correctly please.

thanks,

greg k-h
