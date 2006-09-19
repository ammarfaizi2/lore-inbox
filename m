Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWISUiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWISUiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWISUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:38:20 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:6157 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751278AbWISUiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:38:20 -0400
Date: Tue, 19 Sep 2006 16:38:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
In-Reply-To: <20060919200116.GJ1310@us.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0609191634480.4631-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Paul E. McKenney wrote:

> > Maybe I'm missing something. But if the same CPU loads the value
> > before the store becomes visible to cache coherency, it might see
> > the value out of any order any of the other CPUs sees.
> 
> Agreed.  But the CPUs would have to refer to a fine-grained synchronized
> timebase or to some other variable in order to detect the fact that there
> were in fact multiple different values for the same variable at the same
> time (held in the different store queues).

Even that wouldn't be illegal.  No one ever said that any particular write 
becomes visible to all CPUs at the same time.

> If the CPUs looked only at that one single variable being stored to,
> could they have inconsistent opinions about the order of values that
> this single variable took on?  My belief is that they could not.

Yes, I think this must be right.  If a store is hung up in a CPU's store 
buffer, it will mask later stores by other CPUs (i.e., prevent them from 
becoming visible to the CPU that owns the store buffer).  Hence all stores 
that _do_ become visible will appear in a consistent order.

But my knowledge of outlandish hardware is extremely limited, so don't 
take my word as gospel.

Alan

