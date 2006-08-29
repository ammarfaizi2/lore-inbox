Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWH2HLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWH2HLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 03:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWH2HLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 03:11:46 -0400
Received: from brick.kernel.dk ([62.242.22.158]:2370 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932103AbWH2HLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 03:11:46 -0400
Date: Tue, 29 Aug 2006 09:14:29 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit_io_context: don't disable irqs
Message-ID: <20060829071429.GQ30609@kernel.dk>
References: <20060826203142.GA333@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826203142.GA333@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27 2006, Oleg Nesterov wrote:
> We don't need to disable irqs to clear current->io_context, it is
> protected by ->alloc_lock. Even IF it was possible to submit I/O from
> IRQ on behalf of current this irq_disable() can't help:
> current_io_context() will re-instantiate ->io_context after
> irq_enable().
> 
> We don't need task_lock() or local_irq_disable() to clear ioc->task.
> This can't prevent other CPUs from playing with our io_context anyway.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Applied, thanks.

-- 
Jens Axboe

