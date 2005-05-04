Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVEDSYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVEDSYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVEDSWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:22:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:26808 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261300AbVEDSVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:21:48 -0400
Date: Wed, 4 May 2005 20:21:43 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: avoid infinite loop in x86_64 interrupt return
Message-ID: <20050504182142.GE28441@wotan.suse.de>
References: <20050504050132.GA3899@opteron.random> <200505041100.33099.rjw@sisk.pl> <20050504133129.GD3899@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504133129.GD3899@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 03:31:29PM +0200, Andrea Arcangeli wrote:
> On Wed, May 04, 2005 at 11:00:32AM +0200, Rafael J. Wysocki wrote:
> > You also need to add two missing clis.  Please have a look at the attached
> > patch from Andi.
> 
> Those two clis seems unrelated, so I don't see why I should mix them in
> the same patch. I couldn't trigger the other problems, only the one with
> rdi corruption.

THere was a second patch which essentially got the line you posted
together with the missing clis.

I originally fixed it in a slightly different way (in the version
that got lost), but this one was equivalent.

> 
> Note that those clis seems superflous, cli is only needed before swapgs,
> so adding cli before swapgs in retint_swapgs sounds a better idea than
> to keep irq off for a longer time for no apparent good reason. But I've
> no real idea why those cli are needed so I guess I must be missing
> something. there's no commentary attached to your patch that can exlain
> why the cli are needed _way_ before calling swapgs.

To avoid losing schedule events and signals. Between checking for them
and returning to user space interrupts need to be off. When they are
reenabled everything needs to be rechecked.

-Andi
