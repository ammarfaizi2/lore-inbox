Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbULFQsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbULFQsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 11:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULFQsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 11:48:19 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:21222 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261554AbULFQsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 11:48:17 -0500
Date: Mon, 6 Dec 2004 09:47:04 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Li Shaohua <shaohua.li@intel.com>
Subject: Re: Fw: [RFC] Strange code in cpu_idle()
In-Reply-To: <20041206160405.GB1271@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com> <20041206111634.44d6d29c.sfr@canb.auug.org.au>
 <20041205232007.7edc4a78.akpm@osdl.org> <Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
 <20041206160405.GB1271@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Paul E. McKenney wrote:

> I am not going to claim to thoroughly understand the power-management
> code, but do have an additional question.
> 
> What happens if the processor became aware of a new grace period just
> before entering pm_idle?  I could imagine this code simply refusing
> to power down the processor if there was a pending grace period, but
> I don't see any sign of this.  I could also imagine somehow deferring
> interrupts until pm_idle exits.  I don't see anything that looks like
> it does this, but don't claim to be any sort of power-management
> expert.

Are you referring to the synchronize_kernel side? That's basically unload 
module path so it's ok if it sits there for a bit, but it should only last 
for as long as the next interrupt, which would be a pretty short perid 
considering HZ=1000. But the usage still has a race and hence invalid as 
pointed out by Dipankar

Thanks,
	Zwane

