Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVCPLFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVCPLFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVCPLFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:05:50 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40903 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262544AbVCPLFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:05:34 -0500
Date: Wed, 16 Mar 2005 06:05:09 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
In-Reply-To: <20050316024022.6d5c4706.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain> <20050315120053.GA4686@elte.hu>
 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain> <20050315133540.GB4686@elte.hu>
 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain> <20050316085029.GA11414@elte.hu>
 <20050316011510.2a3bdfdb.akpm@osdl.org> <20050316095155.GA15080@elte.hu>
 <20050316020408.434cc620.akpm@osdl.org> <20050316101906.GA17328@elte.hu>
 <20050316024022.6d5c4706.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Mar 2005, Andrew Morton wrote:

>
> Those two are in the journal, actually.  You refer to jbd_lock_bh_state()
> and jbd_lock_bh_journal_head().  I think they both need to be in the
> buffer_head.  jbd_lock_bh_journal_head() can probably go away (just use
> caller's jbd_lock_bh_state()).
>
> Or make them global, or put them in the journal.

The jbd_lock_bh_journal_head can be one global lock without a problem. But
when I made jbd_lock_bh_state a global lock, I believe it deadlocked on
me.  So this one has to go into the buffer head.  What do you mean with
"put them in the journal", do you mean the journal_s structure? Is there a
safe way to get to that structure from the buffer head?  The state lock is
used quite a bit and it gets tricky trying to figure out how to use other
structures wrt buffer_heads at all the locations that use
jbd_lock_bh_state.

-- Steve
