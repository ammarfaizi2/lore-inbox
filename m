Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752043AbWISUA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbWISUA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWISUA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:00:26 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49026 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752043AbWISUAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:00:25 -0400
Date: Tue, 19 Sep 2006 13:01:16 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
Message-ID: <20060919200116.GJ1310@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44L0.0609191332470.4345-100000@iolanthe.rowland.org> <45102E21.2060301@yahoo.com.au> <20060919181919.GG1310@us.ibm.com> <45103B8D.1040006@yahoo.com.au> <20060919193604.GI1310@us.ibm.com> <45104970.40905@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45104970.40905@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 05:48:00AM +1000, Nick Piggin wrote:
> Paul E. McKenney wrote:
> >On Wed, Sep 20, 2006 at 04:48:45AM +1000, Nick Piggin wrote:
> >Sooner or later, the cacheline comes to the store queue, defining
> >the ordering.  All changes that occurred in the store queue while
> >waiting for the cache line appear to other CPUs as having happened
> >in very quick succession while the cacheline resides with the store
> >queue in question.
> >
> >So, what am I missing?
> 
> Maybe I'm missing something. But if the same CPU loads the value
> before the store becomes visible to cache coherency, it might see
> the value out of any order any of the other CPUs sees.

Agreed.  But the CPUs would have to refer to a fine-grained synchronized
timebase or to some other variable in order to detect the fact that there
were in fact multiple different values for the same variable at the same
time (held in the different store queues).

If the CPUs looked only at that one single variable being stored to,
could they have inconsistent opinions about the order of values that
this single variable took on?  My belief is that they could not.

						Thanx, Paul
