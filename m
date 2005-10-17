Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVJQUkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVJQUkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVJQUkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:40:19 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:64942 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932171AbVJQUkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:40:16 -0400
Date: Tue, 18 Oct 2005 02:03:56 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017203356.GH13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com> <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org> <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org> <4353FDE8.8070909@cosmosbay.com> <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 01:14:20PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 17 Oct 2005, Eric Dumazet wrote:
> > 
> > What about call_rcu_bh() which I left unchanged ? At least one of my
> > production machine cannot live very long unless I have maxbatch = 300, because
> > of an insane large tcp route cache (and one of its CPU almost filled by
> > softirq NIC processing)
> 
> I think we'll have to release 2.6.14 with maxbatch at the high value 
> (10000).

Is 10000 enough ? Eric seemed to find a problem even with this
after 90 minutes ?


> Yes, it may screw up some latency stuff, but quite frankly, even with your 
> patch and even ignoring the call_rcu_bh case, I'm convinced you can easily 
> get into the situation where softirqd just doesn't run soon enough.
> 
> But at least I think I understand _why_ rcu processing was delayed.
> 
> I think a real fix might have to involve more explicit knowledge of 
> tasklet behaviour and softirq interaction.

Agreed. I am now looking at characterizing the corner cases that
can get us into trouble and checking what pattern of processing
is appropriate to cover them all. It will take some time to
sort this out making sure that it satisfies most requirements
reasonably.

Thanks
Dipankar
