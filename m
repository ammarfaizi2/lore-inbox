Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161028AbWARWBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbWARWBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161031AbWARWBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:01:04 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7641
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161028AbWARWBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:01:03 -0500
Date: Wed, 18 Jan 2006 14:00:56 -0800 (PST)
Message-Id: <20060118.140056.39962680.davem@davemloft.net>
To: stern@rowland.harvard.edu
Cc: bcrl@kvack.org, akpm@osdl.org, sekharan@us.ibm.com, kaos@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] Notifier chain update
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44L0.0601181656430.4974-100000@iolanthe.rowland.org>
References: <20060118214204.GG16285@kvack.org>
	<Pine.LNX.4.44L0.0601181656430.4974-100000@iolanthe.rowland.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 18 Jan 2006 16:57:30 -0500 (EST)

> On Wed, 18 Jan 2006, Benjamin LaHaise wrote:
> 
> > A notifier callee should not be sleeping, if anything it should be putting 
> > its work onto a workqueue and completing it when it gets scheduled if it 
> > has to do something that blocks.
> 
> Sez who?  If it's not documented in the kernel source, I don't believe 
> it.

Many notifiers even get run from software interrupt context,
making sleeping illegal.

For example, IPV6 addresses can get added/removed from a device
in response to packets, and these operations trigger the
inet6addr_chain notifier in net/ipv6/addrconf.c

So sleeping in a notifier is indeed illegal.
