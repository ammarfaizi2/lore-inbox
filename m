Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbULWXLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbULWXLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 18:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbULWXLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 18:11:10 -0500
Received: from mail.dif.dk ([193.138.115.101]:4800 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261339AbULWXKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 18:10:46 -0500
Date: Fri, 24 Dec 2004 00:21:35 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: Robin Holt <holt@sgi.com>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AB-BA deadlock between uidhash_lock and tasklist_lock.
In-Reply-To: <20041223145433.596db88c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412240019540.3504@dragon.hygekrogen.localhost>
References: <20041222220800.GB6213@lnx-holt.americas.sgi.com>
 <20041223173749.GA18887@lnx-holt.americas.sgi.com> <20041223145433.596db88c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Andrew Morton wrote:

> +/*
> + * uidhash_lock is taken inside write_lock_irq(&tasklist_lock).  If a timer
> + * interrupt were to occur while we hold uidhash_lock, and that interrupt takes
> + * read_lock(&tasklist_lock) then we have an ab/ba deadlock scenario.  Hence
> + * uidhash_lock must always be taken in an ir-qsafe manner to hold off the
> + * timer interrupt.
> + */

Miniature nit: You write "... ir-qsafe manner ...", I'm fairly certain you 
mean "... irq-safe manner ..." :-)


-- 
Jesper Juhl

