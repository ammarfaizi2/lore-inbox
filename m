Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUIGR3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUIGR3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268334AbUIGRZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:25:37 -0400
Received: from waste.org ([209.173.204.2]:43972 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268172AbUIGRWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 13:22:32 -0400
Date: Tue, 7 Sep 2004 12:22:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll trapped question
Message-ID: <20040907172212.GZ31237@waste.org>
References: <16692.45331.968648.262910@segfault.boston.redhat.com> <20040906213502.GU31237@waste.org> <16701.58093.63886.734877@segfault.boston.redhat.com> <20040907165014.GX31237@waste.org> <16701.59261.688607.284454@segfault.boston.redhat.com> <20040907165942.GY31237@waste.org> <16701.60264.560942.236743@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16701.60264.560942.236743@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 01:10:00PM -0400, Jeff Moyer wrote:
> ==> Regarding Re: netpoll trapped question; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> On Tue, Sep 07, 2004 at 12:53:17PM -0400, Jeff Moyer wrote: A random
> mpm> lock private to a given driver, for instance one taken on entry to the
> mpm> IRQ handler. If said driver tries to do a printk inside that lock and
> mpm> we recursively call the handler in netconsole, we're in trouble.
> mpm> These are the issues that will have to be cleaned up in individual
> mpm> drivers. So far, I haven't seen any reports, but I'm pretty sure such
> mpm> cases exist. I suppose it's also possible for us to disable recursion
> mpm> in netconsole instead of at the netpoll level.
> >> Recursion in netconsole is protected by the console semaphore.
> 
> mpm> Yes, true. But we're still in trouble if we have nic irq handler ->
> mpm> take private lock -> printk -> netconsole -> nic irq handler -> take
> mpm> private lock. See?
> 
> Okay, so that one has to be addressed on a per-driver basis.  There's no
> way for us to detect that situation.  And how do drivers address this?
> Simply don't printk inside the lock?  I think that's reasonable.

That or drop the lock where possible.

-- 
Mathematics is the supreme nostalgia of our time.
