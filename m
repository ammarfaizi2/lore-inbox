Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVIRH0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVIRH0B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 03:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVIRH0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 03:26:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41449
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751314AbVIRH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 03:26:00 -0400
Date: Sun, 18 Sep 2005 00:25:48 -0700 (PDT)
Message-Id: <20050918.002548.92592728.davem@davemloft.net>
To: akpm@osdl.org
Cc: fmalita@gmail.com, linux-kernel@vger.kernel.org,
       ctindel@users.sourceforge.net, fubar@us.ibm.com, netdev@vger.kernel.org
Subject: Re: [PATCH] bond_main.c: fix device deregistration in init
 exception path
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050917233224.2d4b3652.akpm@osdl.org>
References: <432D0612.7070408@gmail.com>
	<20050917233224.2d4b3652.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 17 Sep 2005 23:32:24 -0700

> The fix is solid enough, although a better comment is needed.  Let's
> let Dave decide whether that was a sane thing to go BUG over..

The fix is fine and so is the BUG() check.

Usually, you're supposed to make sure that the very last thing
you do is register_netdev(), and that all possible errors are
possible only before that call.

And that's what BOND basically does, except that it must register
multiple devices in a loop and therefore cannot follow that rule
precisely.

So I've added the patch to my tree, it's fine to do this for a
special case usage like this one.
