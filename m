Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266874AbUHDPMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266874AbUHDPMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHDPMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:12:21 -0400
Received: from waste.org ([209.173.204.2]:29612 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266874AbUHDPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:11:17 -0400
Date: Wed, 4 Aug 2004 10:11:06 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix netpoll cleanup on abort without dev
Message-ID: <20040804151105.GM16310@waste.org>
References: <20040804142049.GL16310@waste.org> <16656.63625.650665.626364@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16656.63625.650665.626364@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 10:54:01AM -0400, Jeff Moyer wrote:
> ==> Regarding [PATCH] Fix netpoll cleanup on abort without dev; Matt Mackall <mpm@selenic.com> adds:
> 
> mpm> If netpoll attempts to use a device without polling support, it will
> mpm> oops when shutting down. This adds a check that we've actually
> mpm> attached to a device.
> 
> Hi, Matt,
> 
> Perhaps I'm missing something, but how do we successfully return from
> netpoll_setup without np->dev filled in?  Netpoll_setup has the following:
> 
>         if (!ndev->poll_controller) {
>                 printk(KERN_ERR "%s: %s doesn't support polling, aborting.\n",
>                        np->name, np->dev_name);
>                 goto release;
>         }

We don't. What happens is netconsole is blindly calling
netpoll_cleanup on module exit. I could move the np->dev check up to
that point, but it seems to me that netpoll_cleanup should be made
harmless instead.

ps: you still owe me a netpoll patch

-- 
Mathematics is the supreme nostalgia of our time.
