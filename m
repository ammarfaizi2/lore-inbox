Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUIGRFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUIGRFD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUIGRCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:02:21 -0400
Received: from waste.org ([209.173.204.2]:10173 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268175AbUIGQ7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 12:59:49 -0400
Date: Tue, 7 Sep 2004 11:59:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll trapped question
Message-ID: <20040907165942.GY31237@waste.org>
References: <16692.45331.968648.262910@segfault.boston.redhat.com> <20040906213502.GU31237@waste.org> <16701.58093.63886.734877@segfault.boston.redhat.com> <20040907165014.GX31237@waste.org> <16701.59261.688607.284454@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16701.59261.688607.284454@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 12:53:17PM -0400, Jeff Moyer wrote:
> mpm> A random lock private to a given driver, for instance one taken on
> mpm> entry to the IRQ handler. If said driver tries to do a printk inside
> mpm> that lock and we recursively call the handler in netconsole, we're in
> mpm> trouble.  These are the issues that will have to be cleaned up in
> mpm> individual drivers. So far, I haven't seen any reports, but I'm pretty
> mpm> sure such cases exist. I suppose it's also possible for us to disable
> mpm> recursion in netconsole instead of at the netpoll level.
> 
> Recursion in netconsole is protected by the console semaphore.

Yes, true. But we're still in trouble if we have nic irq handler ->
take private lock -> printk -> netconsole -> nic irq handler -> take
private lock. See?

-- 
Mathematics is the supreme nostalgia of our time.
