Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWEPPlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEPPlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWEPPlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:41:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51717 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932097AbWEPPlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:41:20 -0400
Date: Tue, 16 May 2006 11:41:17 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "David S. Miller" <davem@davemloft.net>
cc: akpm@osdl.org, <sekharan@us.ibm.com>, <jes@sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Allow raw_notifier callouts to unregister themselves
In-Reply-To: <20060511.115740.30658747.davem@davemloft.net>
Message-ID: <Pine.LNX.4.44L0.0605161136380.21386-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2006, David S. Miller wrote:

> From: Andrew Morton <akpm@osdl.org>
> Date: Thu, 11 May 2006 11:25:09 -0700
> 
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > Since raw_notifier chains don't benefit from any centralized locking
> > > protections, they shouldn't suffer from the associated limitations.  
> > > Under some circumstances it might make sense for a raw_notifier callout
> > > routine to unregister itself from the notifier chain.  This patch (as678)
> > > changes the notifier core to allow for such things.
> > 
> > ok...  Can you see any reason why 2.6.17 needs this?
> 
> If this patch makes raw notifiers behave more closely to the
> way notifiers did before the notifier patch went into 2.6.17,
> we should seriouly consider it.  We've had enough regressions
> from that patch, and anything which minimizes any possible other
> such regressions would be a plus.

Sorry I'm a little late replying to this...

Actually this patch makes raw notifiers behave a little _less_ like the
original pre-2.6.17 notifiers.  With the original code, a notifier callout
routine could unregister itself and deallocate its notifier_block, thereby
causing an oops when it returned.  With this patch, the oops will not
occur.

That's the only difference.

Alan Stern

