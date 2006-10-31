Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423030AbWJaJr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423030AbWJaJr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWJaJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:47:57 -0500
Received: from brick.kernel.dk ([62.242.22.158]:55051 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423035AbWJaJr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:47:56 -0500
Date: Tue, 31 Oct 2006 10:49:38 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
Message-ID: <20061031094938.GF14055@kernel.dk>
References: <1162199005.24143.169.camel@taijtu> <20061030224802.f73842b8.akpm@osdl.org> <4546FA81.1020804@cosmosbay.com> <45471A05.20205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45471A05.20205@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Nick Piggin wrote:
> Eric Dumazet wrote:
> >This patch deletes two calls to smp_mb() that were done after 
> >mutex_unlock() that contains an implicit memory barrier.
> 
> Uh, there is nothing that says mutex_unlock or any unlock
> functions contain an implicit smp_mb(). What is given is that the
> lock and unlock obey aquire and release memory ordering,
> respectively.
> 
> a = x;
> xxx_unlock
> b = y;
> 
> In this situation, the load of y can be executed before that of x.
> And some architectures will even do so (i386 can, because the
> unlock is an unprefixed store; ia64 can, because it uses a release
> barrier in the unlock).
> 
> Whenever you rely on orderings of things *outside* locks (even
> partially outside), you do need to be very careful about barriers
> and can't rely on locks to do the right thing for you.

Good point, we should not make any assumptions on the way the
architecture implements the mutexes.

-- 
Jens Axboe

