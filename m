Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbUCWMkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 07:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbUCWMks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 07:40:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14268 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262535AbUCWMkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 07:40:47 -0500
Date: Tue, 23 Mar 2004 18:10:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, tiwai@suse.de,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323124002.GH3676@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040323123105.GI22639@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 01:31:05PM +0100, Andrea Arcangeli wrote:
> On Tue, Mar 23, 2004 at 11:35:06AM +0100, Arjan van de Ven wrote:
> > 
> > > Reduce bh processing time of rcu callbacks by using tunable per-cpu
> > > krcud daemeons.
> > 
> > why not just use work queues ?
> 
> I don't know if work queues are scheduler friendly, but definitely the
> rearming tasklets are. Running a dozen callbacks per pass and queueing
> any remining work to a rearming tasklet should fix it.

One problem that likely happen here is that under heavy interrupt
load, large number of softirqs still starve out user processes.
In my DoS testing setup, I see that limiting RCU softirqs 
and re-arming tasklets has no effect on user process starvation.

Thanks
Dipankar
