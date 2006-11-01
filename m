Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946601AbWKAGAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946601AbWKAGAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946600AbWKAGAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:00:46 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:179
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946596AbWKAGAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:00:44 -0500
Date: Tue, 31 Oct 2006 22:00:47 -0800 (PST)
Message-Id: <20061031.220047.08324824.davem@davemloft.net>
To: andy@greyhouse.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] 2.6.19-rc4 - netlink messages created with bad flags
 in soft_irq context
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061031220559.GA10119@gospo.rdu.redhat.com>
References: <20061031220559.GA10119@gospo.rdu.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Gospodarek <andy@greyhouse.net>
Date: Tue, 31 Oct 2006 17:06:00 -0500

> I've got a kernel built where 
> 
> CONFIG_DEBUG_SPINLOCK_SLEEP=y
> 
> is in the config and I've noticed some interesting behavior when
> bringing up bonds in balance-alb mode.  When I start to enslave devices
> to a bond I get the following in the ring buffer:
> 
> BUG: sleeping function called from invalid context at mm/slab.c:3007
> in_atomic():1, irqs_disabled():0

As Herbert mentioned, the bonding layer calls into the networking
in atomic contexts when that is illegal.
