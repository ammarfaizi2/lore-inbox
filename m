Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161545AbWAMK2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161545AbWAMK2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161546AbWAMK2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:28:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41954 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161171AbWAMK2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:28:39 -0500
Date: Fri, 13 Jan 2006 02:28:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH 1/5] sched-cleanup_task_activated.patch
Message-Id: <20060113022819.432a1b6d.akpm@osdl.org>
In-Reply-To: <200601132123.01338.kernel@kolivas.org>
References: <200601132123.01338.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> +enum sleep_type {
> +	SLEEP_NORMAL,
> +	SLEEP_NONINTERACTIVE,
> +	SLEEP_INTERACTIVE,
> +	SLEEP_INTERRUPTED,
> +};

If you make these 1, 2, 4 and 8

> +static inline int interactive_sleep(enum sleep_type sleep_type)
> +{
> +	return (sleep_type == SLEEP_INTERACTIVE ||
> +		sleep_type == SLEEP_INTERRUPTED);
> +}

then this can be

	return sleep_type & (SLEEP_INTERACTIVE|SLEEP_INTERRUPTED);

which would save, oh, about nothing.

