Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266810AbSKHRHF>; Fri, 8 Nov 2002 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266812AbSKHRHF>; Fri, 8 Nov 2002 12:07:05 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:8719
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S266810AbSKHRHE>; Fri, 8 Nov 2002 12:07:04 -0500
Subject: Re: [Linux-ia64] reader-writer livelock problem
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>, linux-ia64@linuxia64.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>, rusty@rustcorp.com.au,
       dhowells@redhat.com, mingo@elte.hu,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20021108035102.GA22031@holomorphy.com>
References: <3FAD1088D4556046AEC48D80B47B478C0101F4E7@usslc-exch-4.slc.unisys.com>
	 <20021108035102.GA22031@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1036775624.13021.3.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.90 (Preview Release)
Date: 08 Nov 2002 09:13:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-07 at 19:51, William Lee Irwin III wrote:
> On Thu, Nov 07, 2002 at 09:23:21PM -0600, Van Maren, Kevin wrote:
> > This is a follow-up to the email thread I started on July 29th.
> > See http://www.cs.helsinki.fi/linux/linux-kernel/2002-30/0446.html
> > and the following discussion on LKML.
> > I'll summarize the problem again to refresh the issue.
> > Again, this is a correctness issue, not a performance one.
> > I am seeing a problem on medium-sized SMPs where user programs are
> > able to livelock the Linux kernel to such an extent that the
> > system appears dead.  With the help of some hardware debugging
> > tools, I was able to determine that the problem is caused by
> > the reader-preference reader/writer locks in the Linux kernel.
> 
> This is a very serious problem which I have also encountered. My
> strategy was to make the readers on the tasklist_lock more well-behaved,
> and with Ingo's help and co-authorship those changes were cleaned up,
> tuned to provide performance benefits for smaller systems, bugfixed,
> and incorporated in the kernel. They have at least provided 16x systems
> in my lab with much more stability. The issues are still triggerable on
> 32x systems in my lab, to which I do not have regular access.

The normal way of solving this fairness problem is to make pending write
locks block read lock attempts, so that the reader count is guaranteed
to drop to zero as read locks are released.  I haven't looked at the
Linux implementation of rwlocks, so I don't know how hard this is to
do.  Or perhaps there's some other reason for not implementing it this
way?

	J

