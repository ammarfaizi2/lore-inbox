Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVAYTCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVAYTCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVAYTBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:01:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56728 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262060AbVAYS6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:58:32 -0500
Date: Tue, 25 Jan 2005 10:58:12 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050125185812.GA1499@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050109194209.GA7588@infradead.org> <1105310650.11315.19.camel@lade.trondhjem.org> <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105472182.3917.49.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 08:36:22PM +0100, Arjan van de Ven wrote:
> On Tue, 2005-01-11 at 14:16 -0500, Trond Myklebust wrote:
> > > (you may think "it's only 100 bytes", well, there are 700+ other such
> > > functions, total that makes over at least 70Kb of unswappable, wasted
> > > memory if not more.)
> > 
> > A list of these 700+ unused exported APIs would be very useful so that
> > we can deprecate and/or get rid of them.
> 
> http://people.redhat.com/arjanv/unused
>
> has the list of symbols that are unused on an i386 allmodconfig based on
> the -bk tree 2 days ago.

<donning asbestos suit with the tungsten pinstripes...>

SAN Filesystem is an out-of-tree GPL module that uses the following:

o	blk_get_queue(): used to submit I/O requests using the
	make_request_fn().

o	sock_setsockopt(): used to control communication with other
	nodes in the SAN Filesystem.

o	vfs_follow_link(): used to interpret symbolic links, which
	might point outside of SAN Filesystem.

SDD is a binary module that has committed to get itself to GPL on its
first release after December 31, 2005.  It uses:

o	__read_lock_failed() and __write_lock_failed(): due to SDD's use
	of read_lock() and write_lock().  So, if the plan is to change
	read_lock() and write_lock() to do something different, never mind!

So, could the exports for the following symbols from the list please be
retained through December 31, 2005?

	blk_get_queue
	sock_setsockopt
	vfs_follow_link
	__read_lock_failed
	__write_lock_failed

							Thanx, Paul

PS.  Yes, there are more than two out-of-tree modules in IBM.  Some were
     not affected by this list.  One is looking carefully at Al Viro's
     propagation-node design to see if it does what they need (looks
     promising thus far).  Still others are having more trouble accepting
     the need to stop being binary modules in the near future, but that
     is their problem, not yours!  ;-)  To be fair, at least one in the
     last group has some legitimate IP issues, which we are working on.
