Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbVKZFOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbVKZFOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 00:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVKZFOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 00:14:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2696 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932724AbVKZFOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 00:14:46 -0500
Date: Fri, 25 Nov 2005 21:14:54 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, levon@movementarian.org
Subject: Re: BUG: spinlock recursion on 2.6.14-mm2 when oprofiling
Message-ID: <20051126051454.GA3104@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051118152101.GA4690@mail.ustc.edu.cn> <20051125220117.GA1836@us.ibm.com> <20051125232829.GA2405@us.ibm.com> <20051126033955.GC7226@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126033955.GC7226@mail.ustc.edu.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 11:39:55AM +0800, Wu Fengguang wrote:
> On Fri, Nov 25, 2005 at 03:28:29PM -0800, Paul E. McKenney wrote:
> > And here is an alternative patch that assumes that the answer to both
> > questions above is "no".  It is shorter, though mostly due to use of
> > the list_splice_init() and list_for_each_entry_safe() primitives.
> 
> Ok, I'll try it. But it may take time.
> 
> Currently I'm running oprofile on linux-2.6.15-rc2-mm1. It seems the bug is not
> quite reproducible. I'll report again if there are any new findings.

Yep, the bug is indeed non-deterministic.  For it to happen, softirq
must interrupt a "task_mortuary" critical section, and that softirq
must execute a task-struct RCU callback.

						Thanx, Paul
