Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVKOMQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVKOMQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVKOMQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:16:06 -0500
Received: from hera.kernel.org ([140.211.167.34]:34947 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932390AbVKOMQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:16:05 -0500
Date: Tue, 15 Nov 2005 05:05:03 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [RFC][Patch 0/4] Per-task delay accounting
Message-ID: <20051115070503.GC31904@logos.cnet>
References: <4379658E.1020707@watson.ibm.com> <20051114201741.3d5496b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114201741.3d5496b3.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 08:17:41PM -0800, Andrew Morton wrote:
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> >
> > They are made available through a connector interface which allows
> >  - stats for a given <pid> to be obtained in response to a command
> >  which specifies the <pid>. The need for dynamically obtaining delay
> >  stats is the reason why piggybacking delay stats onto BSD process
> >  accounting wasn't considered.
> 
> I think this is the first time that anyone has come out with real code
> which does per-task accounting via connector.
> 
> Which makes one wonder where this will end up.  If numerous different
> people add numerous different accounting messages, presumably via different
> connector channels then it may all end up a bit of a mess.  Given the way
> kernel development happens, that's pretty likely.
> 
> For example, should the next developer create a new message type, or should
> he tack his desired fields onto the back of yours?  If the former, we'll
> end up with quite a lot of semi-duplicated code and a lot more messages and
> resources than we strictly need.  If the latter, then perhaps the
> versioning you have in there will suffice - I'm not sure.
> 
> I wonder if at this stage we should take a shot at some overarching "how do
> do per-task accounting messages over connector" design which can at least
> incorporate the various things which people have been talking about
> recently?

Another point to be taken in consideration is that SystemTap should make
it possible to add such instrumentation on-the-fly.

Means you don't have to maintain such statistics code (which are likely
to change often due to users needs) in the mainline kernel.

The burden goes to userspace where the kernel hooks are compiled and
inserted.

OTOH, when you think of kernel's fast rate of change, that might not be
a very good option.

Just my two cents.
