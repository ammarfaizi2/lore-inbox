Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTEIIlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTEIIlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:41:15 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32226 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262368AbTEIIlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:41:14 -0400
Date: Fri, 9 May 2003 01:54:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bump module ref during init.
Message-Id: <20030509015412.29237b08.akpm@digeo.com>
In-Reply-To: <20030509084045.792762C0F8@lists.samba.org>
References: <20030509084045.792762C0F8@lists.samba.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 08:53:47.0635 (UTC) FILETIME=[81008430:01C31608]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> +static void wait_for_zero_refcount(struct module *mod)
> +{
> +	/* Since we might sleep for some time, drop the semaphore first */
> +	up(&module_mutex);
> +	for (;;) {
> +		DEBUGP("Looking at refcount...\n");
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (module_refcount(mod) == 0)
> +			break;
> +		schedule();

What wakes the task up again?

