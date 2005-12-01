Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVLAUPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVLAUPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVLAUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:15:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5250
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932435AbVLAUPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:15:52 -0500
Date: Thu, 01 Dec 2005 12:15:54 -0800 (PST)
Message-Id: <20051201.121554.130875743.davem@davemloft.net>
To: davej@redhat.com
Cc: lkml@rtr.ca, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Fix bytecount result from printk()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051201175732.GD19433@redhat.com>
References: <438F1D05.5020004@rtr.ca>
	<20051201175732.GD19433@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Thu, 1 Dec 2005 12:57:32 -0500

> On Thu, Dec 01, 2005 at 10:55:49AM -0500, Mark Lord wrote:
>  > printk() returns a bytecount, which nothing actually appears to use.
> 
> We do check it in a few places.
> 
> arch/x86_64/kernel/traps.c:                             i += printk(" "); \
> arch/x86_64/kernel/traps.c:                     i += printk(" <%s> ", id);
> arch/x86_64/kernel/traps.c:                     i += printk(" <EOE> ");
> arch/x86_64/kernel/traps.c:                             i += printk(" <IRQ> ");
> arch/x86_64/kernel/traps.c:                             i += printk(" <EOI> ");
> drivers/char/mem.c:             ret = printk("%s", tmp);

Wow, that's amazing. :)

I bet these can easily be removed, and since printk() is such
a core thing, simplifying it should trump whatever benfits
these few call sites have from getting a return byte count.
