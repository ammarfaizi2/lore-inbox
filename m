Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267288AbUBSOyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267305AbUBSOyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:54:12 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:63748 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267288AbUBSOxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:53:33 -0500
Date: Thu, 19 Feb 2004 14:53:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
Message-ID: <20040219145331.B23685@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>,
	Michal Wronski <wrona@mat.uni.torun.pl>
References: <Pine.GSO.4.58.0402191527030.18841@Juliusz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.58.0402191527030.18841@Juliusz>; from golbi@mat.uni.torun.pl on Thu, Feb 19, 2004 at 03:28:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifndef _LINUX_MQUEUE_H
> +#define _LINUX_MQUEUE_H
> +
> +#define MQ_PRIO_MAX 	32768
> +
> +typedef int mqd_t;
> +
> +struct mq_attr {
> +	long	mq_flags;	/* message queue flags			*/
> +	long	mq_maxmsg;	/* maximum number of messages		*/
> +	long	mq_msgsize;	/* maximum message size			*/
> +	long	mq_curmsgs;	/* number of messages currently queued	*/
> +};
> +
> +#define NOTIFY_NONE	0
> +#define NOTIFY_WOKENUP	1
> +#define NOTIFY_REMOVED	2
> +
> +#ifdef __KERNEL__
> +#include <linux/types.h>
> +#include <linux/time.h>

This looks like you want glibc to include it, please don't - add a copy
without the kernel part to glibc instead.

> +asmlinkage long sys_mq_open(const char __user *name, int oflag, mode_t mode, struct mq_attr __user *attr);
> +asmlinkage long sys_mq_unlink(const char __user *name);
> +asmlinkage long mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
> +asmlinkage ssize_t mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
> +asmlinkage long mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
> +asmlinkage long mq_getsetattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);

this probably fits better into randy's new syscall.h now in -mm.  Also
what do you need the prototypes for?

