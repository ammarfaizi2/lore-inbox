Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWCMSjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWCMSjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWCMSjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:39:20 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34983 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750743AbWCMSjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:39:19 -0500
Date: Mon, 13 Mar 2006 10:39:32 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Keith Owens <kaos@sgi.com>, Andi Kleen <ak@suse.de>,
       ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Message-ID: <20060313183932.GE1297@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20051213162027.GA14158@us.ibm.com> <17158.1134512861@ocs3.ocs.com.au> <20051216074626.GB201289@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216074626.GB201289@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 11:46:26PM -0800, Jeremy Higdon wrote:
> Roland Dreier got this right.  The purpose of the mmiowb is
> to ensure that writes to I/O devices while holding a spinlock
> are ordered with respect to writes issued after the original
> processor releases and a second processor acquires said
> spinlock.
> 
> A MMIO read would be sufficient, but is much heavier weight.
> 
> On the SGI MIPS-based systems, the "sync" instruction was used.
> On the Altix systems, a register on the hub chip is read.
> 
> >From comments by jejb, we're looking at modifying the mmiowb
> API by adding an argument which would be a register to read
> from if the architecture in question needs ordering in this
> way but does not have a lighter weight mechanism like the Altix
> mmiowb.  Since there will now need to be a width indication,
> mmiowb will be replaced with mmiowb[bwlq].

Any progress on this front?  I figured that I would wait to update
the ordering document until after this change happened, but if it
is going to be awhile, I should proceed with the current API.

Thoughts?

						Thanx, Paul
