Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVKRDnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVKRDnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 22:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVKRDnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 22:43:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23956
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932249AbVKRDnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 22:43:11 -0500
Date: Thu, 17 Nov 2005 19:42:39 -0800 (PST)
Message-Id: <20051117.194239.37311109.davem@davemloft.net>
To: davej@redhat.com
Cc: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
 i386
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051118031751.GA2773@redhat.com>
References: <20051118024433.GN11494@stusta.de>
	<20051117185529.31d33192.akpm@osdl.org>
	<20051118031751.GA2773@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Thu, 17 Nov 2005 22:17:51 -0500

> On Thu, Nov 17, 2005 at 06:55:29PM -0800, Andrew Morton wrote:
> 
>  > > IMHO the warnings are the best solution for getting a vast amount fixed, 
>  > > and then it's time to think about the rest.
>  > 
>  > But the warnings don't *work*.  I'm *still* staring at stupid pm_register
>  > and intermodule_foo warnings.  How long has that been?
> 
> Too long.  I think the mtd stuff won't ever get fixed until after that
> function gets removed.

That's unfortunate considering we did cure the DRM cases :-)

My only thought is that virt_to_bus() and friends are a special case
because they mean compilation failure on most non-x86 platforms.

And frankly, __deprecated serves a different purpose as far as I'm
concerned.  It let's people working on stuff outside the tree know
that "oops you shouldn't be using that interface".

The deprecated warnings are so easy to filter out, so I don't think
noise is a good argument.  I see them all the time too.

The whole DMA API we have today was added 4+ years ago specifically
to get rid of virt_to_bus() and friends.  It's been mostly successful,
but one last nudge like this deprecation marking might help get us over
the edge and finally delete the thing for good. :-)

Anyways, my 2cents.
