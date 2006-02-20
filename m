Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWBTPXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWBTPXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWBTPXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:23:43 -0500
Received: from ozlabs.org ([203.10.76.45]:16103 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030287AbWBTPXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:23:41 -0500
Date: Tue, 21 Feb 2006 02:22:13 +1100
From: Anton Blanchard <anton@samba.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 21/22] ehca main file
Message-ID: <20060220152213.GD19895@krispykreme>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005759.13620.10968.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005759.13620.10968.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> What is ehca_show_flightrecorder() trying to do that snprintf() is
> not fast enough?  If you need to pass a binary structure back to
> userspace (with a kernel address in it??) then sysfs is not the right
> place to put it.  Look at debugfs; or relayfs might make the most
> sense for your flightrecorder stuff.

I agree debugfs or relayfs would be better suited. Of course as the
driver matures this form of debug is probably not required at all.

> +#include "hcp_sense.h"		/* TODO: later via hipz_* header file */
> +#include "hcp_if.h"		/* TODO: later via hipz_* header file */

I count 88 TODOs in the driver, it would be nice to get rid of some of
them like the two above, so we can concentrate on the important TODOs :)

> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,12)
> +#define EHCA_RESOURCE_ATTR_H(name)                                         \
> +static ssize_t  ehca_show_##name(struct device *dev,                       \
> +				 struct device_attribute *attr,            \
> +				 char *buf)
> +#else
> +#define EHCA_RESOURCE_ATTR_H(name)                                         \
> +static ssize_t  ehca_show_##name(struct device *dev,                       \
> +				 char *buf)
> +#endif

No need for kernel version ifdefs.

Anton
