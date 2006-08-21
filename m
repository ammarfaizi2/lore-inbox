Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWHUVcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWHUVcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWHUVcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:32:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12438 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750707AbWHUVcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:32:33 -0400
Date: Mon, 21 Aug 2006 14:32:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] copy_process: cosmetic ->ioprio tweak
Message-Id: <20060821143224.62018aba.akpm@osdl.org>
In-Reply-To: <20060820145321.GA775@oleg>
References: <20060820145321.GA775@oleg>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2006 18:53:21 +0400
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> copy_process:
> // holds tasklist_lock + ->siglock
>        /*
>         * inherit ioprio
>         */
>        p->ioprio = current->ioprio;
> 
> Why? ->ioprio was already copied in dup_task_struct().

It might just be a thinko.

> I guess this is needed
> to ensure that the child can't escape sys_ioprio_set(IOPRIO_WHO_{PGRP,USER}),
> yes?

How could the child escape that if this assignment was not present?

> In that case we don't need ->siglock held, and the comment should be updated.

Surely.
