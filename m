Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTL3FPY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 00:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbTL3FPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 00:15:24 -0500
Received: from havoc.gtf.org ([63.247.75.124]:49060 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265063AbTL3FPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 00:15:19 -0500
Date: Tue, 30 Dec 2003 00:15:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-ID: <20031230051519.GA6916@gtf.org>
References: <1072567054.4112.14.camel@gaston> <20031227170755.4990419b.davem@redhat.com> <3FF0FA6A.8000904@pobox.com> <20031229205157.4c631f28.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229205157.4c631f28.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 08:51:57PM -0800, David S. Miller wrote:
> On Mon, 29 Dec 2003 23:09:14 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > Not really...  pretty much _all_ TX queue packet freeing occurs inside 
> > an irq handler and inside the driver spinlock.  Further, we don't want 
> > to reinvent some sort of "queue skb for freeing" code in every driver.
> 
> There is one important detail not mentioned.
> 
> If we let the TX free occur in cpu IRQ disabled context, the
> BH to actually do the work will occur as some indeterminate
> time in the future after the top level IRQ spinlock release
> occurs.
> 
> Unlike local_bh_enable(), local_irq_enable() does not run
> softirq work.  Similarly when comparing IRQ handler return
> (which also runs softirq work if pending).
> 
> This is the most important reason why the suggested change is wrong.

OK, agreed.  But fixing it in the driver is still incorrect, also.

We need a single solution in the net stack, not a per-driver solution.

Look at the purpose behind his patch...

	Jeff



