Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274948AbTGaXVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274932AbTGaXSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:18:13 -0400
Received: from ns.suse.de ([213.95.15.193]:43014 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S274929AbTGaXRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:17:53 -0400
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
References: <20030731224604.GA24887@tsunami.ccur.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2003 01:17:34 +0200
In-Reply-To: <20030731224604.GA24887@tsunami.ccur.com.suse.lists.linux.kernel>
Message-ID: <p73vftinv5c.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:
>  
> diff -Nura linux-2.6.0-test2/include/linux/sched.h.orig linux-2.6.0-test2/include/linux/sched.h
> --- linux-2.6.0-test2/include/linux/sched.h.orig	2003-07-27 12:57:39.000000000 -0400
> +++ linux-2.6.0-test2/include/linux/sched.h	2003-07-31 15:52:25.000000000 -0400
> @@ -488,6 +488,7 @@
>  #define PF_LESS_THROTTLE 0x01000000	/* Throttle me less: I clena memory */
>  #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
>  #define PF_READAHEAD	0x00400000	/* I am doing read-ahead */
> +#define PF_CPULOCK	0x00800000	/* lock users out from changing cpus_allowed */

It would be probably better to just check for ->mm == NULL

This should catch all kernel threads that use daemonize

-Andi
