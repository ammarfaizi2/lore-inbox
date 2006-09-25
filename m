Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWIYSR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWIYSR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWIYSR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:17:56 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:42903 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750793AbWIYSRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:17:55 -0400
Subject: Re: [PATCH] Advertise PPPoE MTU / avoid memory leak.
From: Michal Ostrowski <mostrows@earthlink.net>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       ppp-bugs@dp.samba.org
In-Reply-To: <20060924.184118.104036249.davem@davemloft.net>
References: <115903262344-git-send-email-mostrows@earthlink.net>
	 <20060923.145600.51855973.davem@davemloft.net>
	 <1159100966.23197.293.camel@brick.austin.ibm.com>
	 <20060924.184118.104036249.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 13:16:37 -0500
Message-Id: <1159208197.23197.303.camel@brick.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-24 at 18:41 -0700, David Miller wrote:
> From: Michal Ostrowski <mostrows@earthlink.net>
> Date: Sun, 24 Sep 2006 07:29:25 -0500
> 
> > I think the call path via dev->hard_start_xmit, if it fails, may result
> > in an skb not being freed.  This appears to be the case with the e100.c
> > driver.  The qdisc_restart path to dev->hard_start_xmit also appears
> > susceptible to this.  It appears that not all devices agree as to who
> > should clean-up an skb on error.
> 
> There is a well defined policy about who frees the SKB or has
> ownership of it based upon dev->hard_start_xmit() return values.
> 
> Any driver deviating from this set of rules should simply be
> audited and fixed, as needed.
> 
> But, no matter, your change is buggy and we can't apply your
> patch (even if it does fix a leak in some legitimate case)
> because it introduces an obvious double-free bug.
> 

Yup.  I'll resubmit a fixed one.


-- 
Michal Ostrowski <mostrows@earthlink.net>

