Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWIYBlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWIYBlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWIYBlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:41:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13515
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932216AbWIYBlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:41:16 -0400
Date: Sun, 24 Sep 2006 18:41:18 -0700 (PDT)
Message-Id: <20060924.184118.104036249.davem@davemloft.net>
To: mostrows@earthlink.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       ppp-bugs@dp.samba.org
Subject: Re: [PATCH] Advertise PPPoE MTU / avoid memory leak.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1159100966.23197.293.camel@brick.austin.ibm.com>
References: <115903262344-git-send-email-mostrows@earthlink.net>
	<20060923.145600.51855973.davem@davemloft.net>
	<1159100966.23197.293.camel@brick.austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Ostrowski <mostrows@earthlink.net>
Date: Sun, 24 Sep 2006 07:29:25 -0500

> I think the call path via dev->hard_start_xmit, if it fails, may result
> in an skb not being freed.  This appears to be the case with the e100.c
> driver.  The qdisc_restart path to dev->hard_start_xmit also appears
> susceptible to this.  It appears that not all devices agree as to who
> should clean-up an skb on error.

There is a well defined policy about who frees the SKB or has
ownership of it based upon dev->hard_start_xmit() return values.

Any driver deviating from this set of rules should simply be
audited and fixed, as needed.

But, no matter, your change is buggy and we can't apply your
patch (even if it does fix a leak in some legitimate case)
because it introduces an obvious double-free bug.
