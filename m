Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWARWEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWARWEG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWARWEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:04:06 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:30642 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932356AbWARWEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:04:05 -0500
Date: Wed, 18 Jan 2006 17:04:04 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "David S. Miller" <davem@davemloft.net>
cc: bcrl@kvack.org, <akpm@osdl.org>, <sekharan@us.ibm.com>, <kaos@sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
In-Reply-To: <20060118.140056.39962680.davem@davemloft.net>
Message-ID: <Pine.LNX.4.44L0.0601181702260.14074-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, David S. Miller wrote:

> From: Alan Stern <stern@rowland.harvard.edu>
> Date: Wed, 18 Jan 2006 16:57:30 -0500 (EST)
> 
> > On Wed, 18 Jan 2006, Benjamin LaHaise wrote:
> > 
> > > A notifier callee should not be sleeping, if anything it should be putting 
> > > its work onto a workqueue and completing it when it gets scheduled if it 
> > > has to do something that blocks.
> > 
> > Sez who?  If it's not documented in the kernel source, I don't believe 
> > it.
> 
> Many notifiers even get run from software interrupt context,
> making sleeping illegal.
> 
> For example, IPV6 addresses can get added/removed from a device
> in response to packets, and these operations trigger the
> inet6addr_chain notifier in net/ipv6/addrconf.c
> 
> So sleeping in a notifier is indeed illegal.

Correction: sleeping in an atomic notifier (like inet6addr_chain) callout 
is illegal.

But there are plenty of notifier chains that are always invoked in process 
context and where the callout routines may indeed block.

Alan Stern

