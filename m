Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWCVQjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCVQjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWCVQjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:39:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33927 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751363AbWCVQjs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:39:48 -0500
Message-ID: <44217DBD.8030201@us.ibm.com>
Date: Wed, 22 Mar 2006 10:39:25 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
CC: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063809.005748000@sorel.sous-sol.org>
In-Reply-To: <20060322063809.005748000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> The block device frontend driver allows the kernel to access block
> devices exported exported by a virtual machine containing a physical
> block device driver.
>   

> +
> +static struct xlbd_type_info xlbd_ide_type = {
> +	.partn_shift = 6,
> +	.disks_per_major = 2,
> +	.devname = "ide",
> +	.diskname = "hd",
> +};
> +
> +static struct xlbd_type_info xlbd_scsi_type = {
> +	.partn_shift = 4,
> +	.disks_per_major = 16,
> +	.devname = "sd",
> +	.diskname = "sd",
> +};
> +
> +static struct xlbd_type_info xlbd_vbd_type = {
> +	.partn_shift = 4,
> +	.disks_per_major = 16,
> +	.devname = "xvd",
> +	.diskname = "xvd",
> +};
>   

This is another thing that has always put me off.  The virtual block 
device driver has the ability to masquerade as other types of block 
devices.  It actually claims to be an IDE or SCSI device allocating the 
appropriate major/minor numbers.

This seems to be pretty evil and creating interesting failure conditions 
for users who load IDE or SCSI modules.  I've seen it trip up a number 
of people in the past.  I think we should only ever use the major number 
that was actually allocated to us.

Regards,

Anthony Liguori

