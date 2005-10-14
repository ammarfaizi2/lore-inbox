Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVJNEIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVJNEIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVJNEIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:08:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36547
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751162AbVJNEIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:08:23 -0400
Date: Thu, 13 Oct 2005 21:06:15 -0700 (PDT)
Message-Id: <20051013.210615.81985793.davem@davemloft.net>
To: aviro@redhat.com
Cc: torvalds@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: BLKSECTGET userland API breakage (2.4 and 2.6 incompatible)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051013234934.GB6711@devserv.devel.redhat.com>
References: <20051013234934.GB6711@devserv.devel.redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Viro <aviro@redhat.com>
Date: Thu, 13 Oct 2005 19:49:34 -0400

> all 2.4:      BLKSECTGET takes long * and is supported by several block drivers
> bio-14-pre9:  Takes BLKSECTGET to drivers/block/blkpg.c, defining it for all
>               block drivers *AND* making it take unsigned short *
> 2.5.1-pre2:   bio merge
> all 2.[56] kernels since then: BLKSECTGET takes unsigned short *
> 32bit compat: unchanged since 2.4 and thus broken on 2.[56]
> applications: we have seen ones using 2.6 ABI and getting buggered in
>               32bit compat.  Most likely there are some using 2.4 ABI...
> 
> IMO the least painful variant is to switch 2.6 compat code to match
> 2.6 native (i.e. use COMPATIBLE_IOCTL()), leave 2.4 as-is and live
> with the fact of userland ABI change between 2.4 and 2.6...

Well, what's the userland state and why in the world did this
happen in the first place?

I guess you're right that keeping the 2.6.x ABI for this ioctl
and fixing up the compat code is probably the least painful
thing to do.
