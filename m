Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFMU0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFMU0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFMUXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:23:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42724 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261161AbVFMUUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:20:44 -0400
Date: Mon, 13 Jun 2005 13:21:07 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: karim@opersys.com, Andrea Arcangeli <andrea@suse.de>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050613202107.GF1305@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com> <20050611155459.GB5796@g5.random> <20050611210417.GC1299@us.ibm.com> <42AB7857.1090907@opersys.com> <20050612214519.GB1340@us.ibm.com> <42ACE2D3.9080106@opersys.com> <20050613144022.GA1305@us.ibm.com> <42ADE334.4030002@opersys.com> <1118693033.2725.21.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118693033.2725.21.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 01:03:53PM -0700, Daniel Walker wrote:
> On Mon, 2005-06-13 at 15:49 -0400, Karim Yaghmour wrote:
> > Paul E. McKenney wrote:
> > > OK...  Then the idea is to dynamically redirect the symbolic link
> > > to include/linux-srt or include/linux-srt that you mentioned in your
> > > previous email, or is the symlink serving some other purpose?
> > 
> > What I'm suggesting is that rt patches shouldn't touch the existing
> > codebase. Instead, functionality having to do with rt should be
> > integrated in separate directories, and depending the way you
> > configure the kernel, include/linux would point to either
> > include/linux-srt or include/linux-hrt, much like include/asm
> > points to one of inclux/asm-*.
> 
> I think this is mistake. Projects that create separation like this are
> begging for the community to reject them. I see this as a design for
> one, instead of design for many mistake. From what I've seen, a project
> would want to do as much clean integration as possible.

It depends on the details of the situation, right?  For example, it
would not have made sense to integrate RCU into spinlock.h, where most
of the other Linux synchronization primitives live.  On the other hand,
spinlock variants, such as spin_lock_bh(), are integrated into the same
spinlock.h file as the the base spin_lock() functions.

For example, CONFIG_PREEMPT_RT separates out some of its realtime function
into separate files (e.g., kernel/rt.c and include/linux/rt_lock.h),
while other parts of its realtime function are integrated into the rest
of the kernel.

						Thanx, Paul
