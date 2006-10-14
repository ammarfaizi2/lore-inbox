Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWJNC1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWJNC1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 22:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWJNC1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 22:27:38 -0400
Received: from mx2.rowland.org ([192.131.102.7]:44804 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1030202AbWJNC1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 22:27:37 -0400
Date: Fri, 13 Oct 2006 22:27:36 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20061013223925.GH1722@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610132216290.22133-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Paul E. McKenney wrote:

> Ewww...  How about __kfifo_get() and __kfifo_put()?  These have no atomic
> operations.  Ah, but they are restricted to pairs of tasks, so pairwise
> memory barriers should suffice.

Tasks can migrate from one CPU to another, of course.  But that involves
context switching and plenty of synchronization operations in the kernel,
so you're okay in that respect.

> For the pairwise memory barriers, I really like "conditionally precedes",
> which makes it very clear that the observation of order is not automatic.
> On both CPUs, and explicit memory barrier is required (with the exception
> of MMIO, where the communication is instead with an I/O device).
> 
> For the single-variable case and for the single-CPU case, just plain
> "precedes" works, at least as long as you are not doing fine-grained
> timings that can allow you to observe cache lines in motion.  But if
> you are doing that, you had better know what you are doing anyway.  ;-)

The reason I don't like "conditionally precedes" is because it suggests
the ordering is not automatic even in the single-CPU case.

Alan

