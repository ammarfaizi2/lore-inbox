Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUBSSug (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267477AbUBSSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:50:35 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:54351 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267368AbUBSSuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:50:25 -0500
Date: Thu, 19 Feb 2004 20:07:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
Message-ID: <20040219190720.GA2421@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
	linux-kernel@vger.kernel.org,
	Manfred Spraul <manfred@colorfullife.com>,
	Michal Wronski <wrona@mat.uni.torun.pl>
References: <Pine.GSO.4.58.0402191527030.18841@Juliusz> <20040219145331.B23685@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219145331.B23685@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 02:53:31PM +0000, Christoph Hellwig wrote:
> > +#ifndef _LINUX_MQUEUE_H
> > +#define _LINUX_MQUEUE_H
> > +
> > +#define MQ_PRIO_MAX 	32768
> > +
> > +typedef int mqd_t;
> > +
> > +struct mq_attr {
> > +	long	mq_flags;	/* message queue flags			*/
> > +	long	mq_maxmsg;	/* maximum number of messages		*/
> > +	long	mq_msgsize;	/* maximum message size			*/
> > +	long	mq_curmsgs;	/* number of messages currently queued	*/
> > +};
> > +
> > +#define NOTIFY_NONE	0
> > +#define NOTIFY_WOKENUP	1
> > +#define NOTIFY_REMOVED	2
> > +
> > +#ifdef __KERNEL__
> > +#include <linux/types.h>
> > +#include <linux/time.h>
> 
> This looks like you want glibc to include it, please don't - add a copy
> without the kernel part to glibc instead.

In the previous threads about this the concept of kernel-only and shared
user and kernel headers has been seen as a good solution.
So a split in a kernel-only part, and another kernel+user part seems more
worth-while. And less error-prone.

Maybe something like:
mqueue.h	for kernel-only
mqueue_abi.h	for kernel+user

	Sam
