Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWBVM0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWBVM0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWBVM0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:26:24 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54667 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751228AbWBVM0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:26:23 -0500
Date: Wed, 22 Feb 2006 13:26:13 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor attributes to sysfs
Message-ID: <20060222122613.GA9295@osiris.boeblingen.de.ibm.com>
References: <43FB2642.7020109@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB2642.7020109@us.ibm.com>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static ssize_t by_show(struct kobject * kobj,
> +		       struct attribute * attr,
> +		       char * page)
> +{
> +	int err = 0;
> +	struct xen_compile_info * info =
> +		kmalloc(sizeof(struct xen_compile_info), GFP_KERNEL);
> +	if (info ) {
> +		if (0 == HYPERVISOR_xen_version(XENVER_compile_info, info))
> +			return sprintf(page, "%s\n", info->compile_by);
> +		kfree(info);
> +	}
> +	return err;
> +}

Looks like you have a memory leak here. There's at least one more of the
same kind in your code.

Heiko
