Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTIZICN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTIZICN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:02:13 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:13839 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261982AbTIZICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:02:10 -0400
Date: Fri, 26 Sep 2003 09:02:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (2/19): common i/o layer.
Message-ID: <20030926090204.A9195@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20030925171542.GC2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030925171542.GC2951@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Thu, Sep 25, 2003 at 07:15:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void
> +__ccwgroup_remove_symlinks(struct ccwgroup_device *gdev)
> +{
> +	int i;
> +	char str[8];
> +
> +	for (i = 0; i < gdev->count; i++) {
> +		sprintf(str, "cdev%d", i);
> +		sysfs_remove_link(&gdev->dev.kobj, str);
> +		/* Hack: Make sure we act on still valid subdirs. */
> +		if (atomic_read(&gdev->cdev[i]->dev.kobj.dentry->d_count))
> +			sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
> +					  "group_device");
> +	}

This looks like you have a bad refcounting problem somewhere.  I'd rather
see it fixed than hacked around..


