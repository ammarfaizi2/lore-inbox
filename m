Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbULCHHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbULCHHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 02:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbULCHHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 02:07:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:2012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261681AbULCHG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 02:06:58 -0500
Date: Thu, 2 Dec 2004 23:06:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nathan Scott <nathans@sgi.com>
Cc: zaphodb@zaphods.net, xhejtman@mail.muni.cz, marcelo.tosatti@cyclades.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041202230620.4de4ec82.akpm@osdl.org>
In-Reply-To: <20041203061835.GF1228@frodo>
References: <20041113144743.GL20754@zaphods.net>
	<20041116093311.GD11482@logos.cnet>
	<20041116170527.GA3525@mail.muni.cz>
	<20041121014350.GJ4999@zaphods.net>
	<20041121024226.GK4999@zaphods.net>
	<20041202195422.GA20771@mail.muni.cz>
	<20041202122546.59ff814f.akpm@osdl.org>
	<20041202210348.GD20771@mail.muni.cz>
	<20041202223146.GA31508@zaphods.net>
	<20041202145610.49e27b49.akpm@osdl.org>
	<20041203061835.GF1228@frodo>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott <nathans@sgi.com> wrote:
>
> > Nathan, it would be a worthwhile exercise to consider replacing GFP_ATOMIC
>  > with (GFP_ATOMIC & ~ __GFP_HIGH) where appropriate.
>  > ...
> 
>  (i.e. zero?  so future-proofing for if GFP_ATOMIC != __GFP_HIGH?)

yup.  (GFP_ATOMIC & ~ __GFP_HIGH) would mean "allocate atomically, but if
this means use emergency pools, then don't bother with that".

>  > If there are places in XFS where it only needs one of these two behaviours,
>  > it would be good to select just that one.
> 
>  OK, I took a quick look through - there's two places where we use
>  GFP_ATOMIC at the moment.  One is a log debug/tracing chunk of code,
>  wont be coming into play here, I'll go back and rework that later.
>  The second is in the metadata buffering code, and is in a spot where
>  we can cope with a failure (don't need to dip into emergency pools
>  at all) but looks like we're avoiding sleeping there.

Just two callsites?  That's less that I imagined.  Looks like my theory
comes unstuck.

