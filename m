Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVAYBAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVAYBAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYA4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:56:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:3808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261755AbVAYAyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:54:15 -0500
Date: Mon, 24 Jan 2005 16:58:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH] BUG in io_destroy (fs/aio.c:1248)
Message-Id: <20050124165856.02ac0c50.akpm@osdl.org>
In-Reply-To: <1106613801.11633.2.camel@localhost.localdomain>
References: <41F04D73.20800@us.ibm.com>
	<20050124085805.GA4462@in.ibm.com>
	<20050124155613.3a741825.akpm@osdl.org>
	<1106613801.11633.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Darrick J. Wong" <djwong@us.ibm.com> wrote:
>
> Andrew Morton wrote:
> 
> > So...  Will someone be sending a new patch?
> 
> Here's a cheesy patch that simply marks the ioctx as dead before
> destroying it.

super-cheesy, given that `ctx' is an unsigned long.

> +		spin_lock_irq(&ctx->ctx_lock);
> +		ctx->dead = 1;
> +		spin_unlock_irq(&ctx->ctx_lock);
> +

Even with this fixed up, the locking looks very odd.

Needs more work, please.  Or we just run with the original patch which I
assume was tested.  It's a rare error path and performance won't matter.
