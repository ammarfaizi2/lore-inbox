Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbTLQXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264868AbTLQXs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 18:48:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:40577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264855AbTLQXs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 18:48:27 -0500
Date: Wed, 17 Dec 2003 15:49:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: mikem@beardog.cca.cpqcorp.net, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, mike.miller@hp.com, scott.benesh@hp.com
Subject: Re: cciss update for 2.4.24-pre1, 2 of 2
Message-Id: <20031217154919.6ab61960.akpm@osdl.org>
In-Reply-To: <20031217225007.GN2495@suse.de>
References: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net>
	<20031217225007.GN2495@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> > +	for (i=0; i < 1200; i++) {
> > +		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
> > +		if (scratchpad == 0xffff0000) {
> > +			ready = 1;
> > +			break;
> > +		}
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(HZ / 10); /* wait 100ms */
> > +	}
> > +	if (!ready) {
> > +		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
> > +		return -1;
> > +	}
> 
> Fine as well, aren't you happy you changed this to schedule_timeout()
> instead of busy looping? :)

It will still be a busy loop if this task has a signal pending. 
TASK_UNINTERRUPTIBLE may be more appropriate...
