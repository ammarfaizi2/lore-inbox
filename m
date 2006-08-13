Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWHMRoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWHMRoR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 13:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWHMRoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 13:44:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35046 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751352AbWHMRoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 13:44:16 -0400
Date: Sun, 13 Aug 2006 10:44:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] fix use after free in netlink_kernel_create()
Message-Id: <20060813104405.a5c8db00.akpm@osdl.org>
In-Reply-To: <44DF129A.6060607@trash.net>
References: <20060813101535.GA8703@miraclelinux.com>
	<44DF129A.6060607@trash.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 13:52:58 +0200
Patrick McHardy <kaber@trash.net> wrote:

> Akinobu Mita wrote:
> > This patch invalidates nl_table by setting NULL when netlink
> > initialization failed. Otherwise netlink_kernel_create() would
> > access nl_table which has already been freed.
> 
> 
> Quite a few users of netlink_kernel_create will panic when creating
> the socket fails (rtnetlink for example, which is always present),
> so you might as well call panic here directly.

That's a bit lame.  Panicing at do_initcalls() time is OK (something is
seriously screwed anyway) but we usually try to handle the ENOMEM nicely if
it happens at modprobe-time.

(It's all pretty theoretical anyway - reasonable-sized GFP_KERNEL
allocations don't fail).

