Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263036AbVCQJ7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbVCQJ7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 04:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVCQJ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 04:59:43 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49545 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263036AbVCQJ7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 04:59:09 -0500
Date: Thu, 17 Mar 2005 04:58:59 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503170456410.17019@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu>
 <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
 <20050316020408.434cc620.akpm@osdl.org> <20050316101906.GA17328@elte.hu>
 <20050316024022.6d5c4706.akpm@osdl.org> <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
 <20050316031909.08e6cab7.akpm@osdl.org> <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Mar 2005, Steven Rostedt wrote:
> [...]  There's a couple of places that
> jbd_trylock_bh_state is used in checkpoint.c, but this is the one place
> that it definitely deadlocks the system.  I believe that the
> code in checkpoint.c also has this problem.
>

I've examined the code in checkpoint.c, and I now believe that it doesn't
have this problem.  When it fails a lock, it just falls out of the while
loops.

-- Steve
