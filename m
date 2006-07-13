Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWGMJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWGMJXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWGMJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 05:23:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53439 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964861AbWGMJXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 05:23:14 -0400
Date: Thu, 13 Jul 2006 02:23:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: pbadari@us.ibm.com, HOLZHEU@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 hypfs fixes for 2.6.18-rc1-mm1
Message-Id: <20060713022304.9291852d.akpm@osdl.org>
In-Reply-To: <44B5C971.7030403@us.ibm.com>
References: <44B5C7CE.6090606@us.ibm.com>
	<44B5C971.7030403@us.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 21:17:53 -0700
Badari Pulavarty <pbadari@us.ibm.com> wrote:

> +static ssize_t hypfs_aio_read(struct kiocb *iocb, const struct iovec *iov,
> +			      unsigned long nr_segs, loff_t offset)
>  {
>  	char *data;
>  	size_t len;
>  	struct file *filp = iocb->ki_filp;
> +	/* XXX: temporary */
> +	char __user *buf = iov[0].iov_base;
> +	size_t count = iov[0].iov_len;
> +
> +	if (nr_segs != 1) {
> +		count = -EINVAL;
> +		goto out;
> +	}

err, "temporary" things tend to become permanent.  What's the real fix?
