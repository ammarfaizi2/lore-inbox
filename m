Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932769AbVLJHxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbVLJHxj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 02:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVLJHxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 02:53:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932769AbVLJHxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 02:53:38 -0500
Date: Fri, 9 Dec 2005 23:53:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 15/17] s390: convert /proc/cio_ignore.
Message-Id: <20051209235321.2281b7e6.akpm@osdl.org>
In-Reply-To: <20051209152909.GP6532@skybase.boeblingen.de.ibm.com>
References: <20051209152909.GP6532@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> +static void *
>  +cio_ignore_proc_seq_start(struct seq_file *s, loff_t *offset)
>  +{
>  +	struct ccwdev_iter *iter;
>  +
>  +	if (*offset > __MAX_SUBCHANNEL)
>  +		return NULL;
>  +	iter = kmalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
>  +	if (!iter)
>  +		return ERR_PTR(-ENOMEM);
>  +	memset(iter, 0, sizeof(struct ccwdev_iter));

kzalloc()

>  +	iter->devno = *offset;
>  +	return iter;
>  +}
>  +
>  +static void
>  +cio_ignore_proc_seq_stop(struct seq_file *s, void *it)
>  +{
>  +	if (!IS_ERR(it))
>  +		kfree(it);
>  +}
>  +
>  +static void *
>  +cio_ignore_proc_seq_next(struct seq_file *s, void *it, loff_t *offset)
>  +{
>  +	struct ccwdev_iter *iter;
>  +
>  +	if (*offset > __MAX_SUBCHANNEL)
>  +		return NULL;
>  +	iter = (struct ccwdev_iter *)it;

Unneeded (and undesirable) cast of void*.

>  +	iter->devno++;
>  +	(*offset)++;
>  +	return iter;
>  +}
