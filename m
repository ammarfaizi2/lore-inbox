Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264160AbUEHVWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264160AbUEHVWW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUEHVWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 17:22:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:65175 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264160AbUEHVWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 17:22:20 -0400
Date: Sun, 9 May 2004 02:49:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-ID: <20040508211920.GD4007@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <20040508135512.15f2bfec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040508135512.15f2bfec.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 01:55:12PM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > There are couple of issues that need to be checked -
> > 
> > 1. Re-doing the parent comparison and full name under ->d_lock
> > need to be benchmarked using dcachebench. That part of code
> > is extrememly performance sensitive and I remember that the
> > current d_movecount based solution was done after a lot of
> > benchmarking of various alternatives.
> 
> There's a speed-space tradeoff here as well.  Making the dentry smaller
> means that more can be cached, which reduces disk seeks.  On all
> machines...

Another thing that would help is the singly linked rcu patch.
It shaves off 8-bytes per-rcu_head on x86. Should I revive
that ?


> But yes, when I've finished mucking with this I'll be asking you to put it
> all through your performance/correctness/stress tests please.

Yes, sure.

> One thing which needs to be reviewed is the layout of the dentry, too.

IIRC, Maneesh did some experiments with this and found that any
changes in the layout he did only degraded performance :)

Thanks
Dipankar
