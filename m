Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWHAOoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWHAOoH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWHAOoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:44:06 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:31902 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751446AbWHAOni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:43:38 -0400
Date: Tue, 1 Aug 2006 07:44:03 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: synchronous signal in the blocked signal context
Message-ID: <20060801144403.GA1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060731191449.B4592@unix-os.sc.intel.com> <Pine.LNX.4.64.0607312152240.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607312152240.4168@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 09:54:47PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 31 Jul 2006, Siddha, Suresh B wrote:
> >
> > This patch (b0423a0d9cc836b2c3d796623cd19236bfedfe63)
> > 
> > [PATCH] Remove duplicate code in signal.c
> > 
> > reverts a patch introduced by Linus long time back.
> 
> Good catch.
> 
> > Was this intentional?
> > 
> > With the current mainline code, SIGSEGV inside a SIGSEGV handler will endup
> > in linux handling endless recursive faults.
> > 
> > Just wondering if this has been discussed before and is intentional.
> 
> It certainly wasn't discussed, and I don't think it was intentional. We 
> should _not_ just unblock a blocked signal. We should kill the process, 
> because sending the signal is actually very very wrong.
> 
> Paul? Should I just revert, or did you have some deeper reason for it?

I cannot claim any deep thought on this one, so please do revert it.

Next time I submit a patch to code with which I am not intimately
familiar, I clearly need to carefully review the earlier patches.  :-/

							Thanx, Paul
