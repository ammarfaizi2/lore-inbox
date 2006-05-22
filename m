Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWEVKhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWEVKhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEVKhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:37:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbWEVKhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:37:13 -0400
Date: Mon, 22 May 2006 03:36:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add user taint flag
Message-Id: <20060522033644.26d47a00.akpm@osdl.org>
In-Reply-To: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
References: <E1FhwyO-0001YQ-O1@candygram.thunk.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> wrote:
>
> 
> Allow taint flags to be set from userspace by writing to
> /proc/sys/kernel/tainted, and add a new taint flag, TAINT_USER, to be
> used when userspace is potentially doing something naughty that might
> compromise the kernel.

What sort of userspace actions are you thinking of here?

And how is other userspace to detect what the naughty userspace is doing?

Someone's done something and you're not telling us what it was ;)

> 
> ...
>
> +/*
> + *	Taint values can only be increased
> + */
> +int proc_dointvec_taint(ctl_table *table, int write, struct file *filp,
> +			void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int op;
> +
> +	if (!capable(CAP_SYS_ADMIN)) {
> +		return -EPERM;
> +	}

Aren't the /proc file permissions sufficient?

