Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272420AbRIKL5C>; Tue, 11 Sep 2001 07:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272422AbRIKL4v>; Tue, 11 Sep 2001 07:56:51 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:9250 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272417AbRIKL4e>; Tue, 11 Sep 2001 07:56:34 -0400
Date: Tue, 11 Sep 2001 13:57:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010911135735.T715@athlon.random>
In-Reply-To: <20010911172301.A2069@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010911172301.A2069@in.ibm.com>; from dipankar@in.ibm.com on Tue, Sep 11, 2001 at 05:23:01PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2001 at 05:23:01PM +0530, Dipankar Sarma wrote:
> In article <20010911131238.N715@athlon.random> you wrote:
> > many thanks. At the moment my biggest concern is about the need of
> > call_rcu not to be starved by RT threads (keventd can be starved so then
> > it won't matter if krcud is RT because we won't start using it).
> 
> > Andrea
> 
> I think we can avoid keventd altogether by using a periodic timer (say 10ms)
> to check for completion of an RC update. The timer may be active
> only if only if there is any RCU going on in the system - that way
> we still don't have any impact on the rest of the kernel.

the timer can a have bigger latency than keventd calling wait_for_rcu
so it should be a loss in a stright bench with light load, but OTOH we
only care about getting those callbacks executed eventually and the
advantage I can see is that the timer cannot get starved.

Andrea
