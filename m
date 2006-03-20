Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWCTGQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWCTGQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 01:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWCTGQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 01:16:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932073AbWCTGQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 01:16:32 -0500
Date: Sun, 19 Mar 2006 22:13:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 2/2] Validate and sanitze itimer timeval from userspace
Message-Id: <20060319221322.3e01f4fe.akpm@osdl.org>
In-Reply-To: <20060319102013.976854000@localhost.localdomain>
References: <20060319102009.817820000@localhost.localdomain>
	<20060319102013.976854000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> +static void fixup_timeval(struct timeval *tv, int interval)
>  +{
> ...
>  +	tmp = (unsigned long) tv->tv_usec;
>  +	if (tmp >= USEC_PER_SEC)
>  +		tv->tv_usec = USEC_PER_SEC - 1;
>  +
>  +	tmp = (unsigned long) tv->tv_sec;
>  +	if (tmp > (LONG_MAX >> 1))
>  +		tv->tv_sec = (LONG_MAX >> 1);
>  +}

Earlier kernels normalised the time, but this code truncates it.

For compatibility, shouldn't we be doing

	tv->tv_sec += tv->tv_usec / USEC_PER_SEC;

?
