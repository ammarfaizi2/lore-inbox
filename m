Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVJQQfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVJQQfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVJQQfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:35:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37605 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750754AbVJQQfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:35:41 -0400
Date: Mon, 17 Oct 2005 21:59:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017162930.GC13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com> <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 09:16:25AM -0700, Linus Torvalds wrote:
> 
> > Absolutely. Keeping a count of (percpu) queued items is basically free if kept
> > in the cache line used by list head, so the 'queue length on this cpu' is a
> > cheap metric.
> 
> The only downside to TIF_RCUUPDATE is that those damn TIF-flags are 
> per-architecture (probably largely unnecessary, but while most 
> architectures don't care at all, others seem to have optimized their 
> layout so that they can test the work bits more efficiently). So it's a 
> matter of each architecture being updated with its TIF_xyz flag and their 
> work function.
> 
> Anybody willing to try? Dipankar apparently has a lot on his plate, this 
> _should_ be fairly straightforward. Eric?

I *had*, when this hit me :) It was one those spurt things. I am going to
look at this, but I think we will need to do this with some careful
benchmarking.

At the moment however I do have another concern - open/close taking too
much time as I mentioned in an earlier email. It is nearly 4 times
slower than 2.6.13. So, that is first up in my list of things to
do at the moment.

Thanks
Dipankar
