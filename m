Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSLCPFT>; Tue, 3 Dec 2002 10:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSLCPFT>; Tue, 3 Dec 2002 10:05:19 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:11539 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261524AbSLCPFS>; Tue, 3 Dec 2002 10:05:18 -0500
Date: Tue, 3 Dec 2002 15:12:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH][RESEND] POSIX message queues, 2.5.50
Message-ID: <20021203151238.A14315@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>
References: <Pine.GSO.4.40.0212031542100.11660-100000@Juliusz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.40.0212031542100.11660-100000@Juliusz>; from golbi@mat.uni.torun.pl on Tue, Dec 03, 2002 at 03:56:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 03:56:58PM +0100, Krzysztof Benedyczak wrote:
> +#ifndef _LINUX_MQUEUE_H
> +#define _LINUX_MQUEUE_H
> +
> +#include <linux/init.h>

I don't think you need this..

> +struct mq_attr {
> +	long mq_flags;		/* message queue flags */
> +	long mq_maxmsg;		/* maximum number of messages */
> +	long mq_msgsize;	/* maximum message size */
> +	long mq_curmsgs;	/* number of messages currently queued */

Please don't use longs as ioctl arguments, better s32.  (and why
can't this be unsigned, btw?)


> --- linux-2.5.50-org/ipc/mqueue.c	Thu Jan  1 01:00:00 1970
> +++ linux-2.5.50-patched/ipc/mqueue.c	Mon Dec  2 21:17:28 2002

No copyright statement at all?

> +	if (*off>=FILENT_SIZE)
> +		return 0;
> +	buffer = kmalloc(FILENT_SIZE,GFP_KERNEL);
> +	if (buffer==NULL)
> +		return -ENOMEM;
> +
> +	*((long *)buffer) = info->qsize;
> +	*((pid_t *)(buffer+sizeof(long))) = info->notify_pid;
> +	*((int *)(buffer+sizeof(long)+sizeof(pid_t))) =
> +					info->notify.sigev_signo;
> +	*((int *)(buffer+sizeof(long)+sizeof(pid_t)+sizeof(int))) =
> +					info->notify.sigev_notify;
> +	retval = FILENT_SIZE - *off;
> +	if (copy_to_user(data,buffer+*off,retval))
> +		return -EFAULT;
> +	*off += retval;
> +	return retval;

Where is the buffer freed?

