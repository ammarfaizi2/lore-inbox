Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVJaSJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVJaSJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVJaSJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:09:53 -0500
Received: from silver.veritas.com ([143.127.12.111]:58934 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932348AbVJaSJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:09:53 -0500
Date: Mon, 31 Oct 2005 18:08:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org, tytso@us.ibm.com,
       sripathi@in.ibm.com, dipankar@in.ibm.com, oleg@tv-sign.ru
Subject: Re: [RFC,PATCH] RCUify single-thread case of clock_gettime()
In-Reply-To: <20051031174416.GA2762@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0510311802550.9631@goblin.wat.veritas.com>
References: <20051031174416.GA2762@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 Oct 2005 18:09:52.0850 (UTC) FILETIME=[4A79CB20:01C5DE46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Paul E. McKenney wrote:
> 
> The attached patch uses RCU to avoid the need to acquire tasklist_lock
> in the single-thread case of clock_gettime().  Still acquires tasklist_lock
> when asking for the time of a (potentially multithreaded) process.
> 
> Experimental, has been touch-tested on x86 and POWER.  Requires RCU on
> task_struct.  Further more focused testing in progress.
> 
> Thoughts?  (Why?  Some off-list users want to be able to monitor CPU
> consumption of specific threads.  They need to do so quite frequently,
> so acquiring tasklist_lock is inappropriate.)

Not my area at all, but this looks really dodgy to me, Paul:
could you explain it further?

First off, I don't see what's "RCU" about it at all.  Essentially,
you're replacing read_lock(&tasklist_lock) by preempt_disable(),
but calling it by the fancier rcu_read_lock() alias.  I thought there
would need to be some more infrastructure to make this RCU and safe?

Hugh
