Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268820AbTCCV3G>; Mon, 3 Mar 2003 16:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268824AbTCCV3G>; Mon, 3 Mar 2003 16:29:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:49654 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268820AbTCCV3F>;
	Mon, 3 Mar 2003 16:29:05 -0500
Date: Mon, 3 Mar 2003 13:35:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2.5.63] Teach page_mapped about the anon flag
Message-Id: <20030303133539.6594e0b6.akpm@digeo.com>
In-Reply-To: <107610000.1046726685@baldur.austin.ibm.com>
References: <20030227025900.1205425a.akpm@digeo.com>
	<200302280822.09409.kernel@kolivas.org>
	<20030227134403.776bf2e3.akpm@digeo.com>
	<118810000.1046383273@baldur.austin.ibm.com>
	<20030227142450.1c6a6b72.akpm@digeo.com>
	<103400000.1046725581@baldur.austin.ibm.com>
	<20030303131210.36645af6.akpm@digeo.com>
	<107610000.1046726685@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2003 21:39:24.0411 (UTC) FILETIME=[5BC704B0:01C2E1CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Monday, March 03, 2003 13:12:10 -0800 Andrew Morton <akpm@digeo.com>
> wrote:
> 
> > It is.  All callers which need to be 100% accurate are under
> > pte_chain_lock().
> 
> Hmm, good point.  Some places may not need perfect accuracy.  Also, if it
> gives a false positive it means someone else is doing an atomic op on it,
> so it's likely to be in transition to/from true anyway.
> 
> Ok, you've convinced me.  Please ignore the patch.  I'll hang onto it in
> case we get proved wrong at some point.

We do need a patch I think.  page_mapped() is still assuming that an
all-bits-zero atomic_t corresponds to a zero-value atomic_t.

This does appear to be true for all supported architectures, but it's a bit
grubby.

