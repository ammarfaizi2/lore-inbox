Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVAZQJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVAZQJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVAZQH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:07:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26539 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262341AbVAZQHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:07:24 -0500
Date: Wed, 26 Jan 2005 08:07:15 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjanv@infradead.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050126160715.GB1266@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050109194209.GA7588@infradead.org> <1105310650.11315.19.camel@lade.trondhjem.org> <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org> <20050125185812.GA1499@us.ibm.com> <1106730061.6307.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106730061.6307.62.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 10:01:00AM +0100, Arjan van de Ven wrote:
> On Tue, 2005-01-25 at 10:58 -0800, Paul E. McKenney wrote:
> > On Tue, Jan 11, 2005 at 08:36:22PM +0100, Arjan van de Ven wrote:
> > > On Tue, 2005-01-11 at 14:16 -0500, Trond Myklebust wrote:
> > > > > (you may think "it's only 100 bytes", well, there are 700+ other such
> > > > > functions, total that makes over at least 70Kb of unswappable, wasted
> > > > > memory if not more.)
> > > > 
> > > > A list of these 700+ unused exported APIs would be very useful so that
> > > > we can deprecate and/or get rid of them.
> > > 
> > > http://people.redhat.com/arjanv/unused
> > >
> > > has the list of symbols that are unused on an i386 allmodconfig based on
> > > the -bk tree 2 days ago.
> > 
> > <donning asbestos suit with the tungsten pinstripes...>
> > 
> > SAN Filesystem is an out-of-tree GPL module that uses the following:
> 
> any plans to submit this for inclusion?

Sigh!  Given that the core of the SAN Filesystem client is a C++
module that runs under Linux, AIX, Windows, &c, I don't have great
hopes for its being accepted for inclusion.  :-(

> > o	blk_get_queue(): used to submit I/O requests using the
> > 	make_request_fn().
> 
> sounds really like the wrong level, any reason to not use submit_bio /
> submit_bh instead? Every piece of code outside the core block layer that
> I've seen that tries to do this has been wrong/broken to date.

I will have them look into this possibility.

> > o	sock_setsockopt(): used to control communication with other
> > 	nodes in the SAN Filesystem.
> 
> again this very much looks like a misuse; sock_setsocketopt() gets a
> *userspace* pointer as argument. Bad API to use (and if you look at
> CIFS, they would also like a real nice internal api instead, but don't
> use sock_setsockopt() since it's the wrong api)

A better API would indeed be a good thing!  I tried a quick search to
find a discussion, but came up dry.  If you have a pointer or contact,
please let me know.  I am also checking with the CIFS people that I know.

> > SDD is a binary module that has committed to get itself to GPL on its
> > first release after December 31, 2005.  It uses:
> > 
> > o	__read_lock_failed() and __write_lock_failed(): due to SDD's use
> > 	of read_lock() and write_lock().  So, if the plan is to change
> > 	read_lock() and write_lock() to do something different, never mind!
> 
> those two exports are "internal" following from copying the
> implementation of read_lock() into the code before compiling it (by the
> preprocessor) and currently of course won't go away unless readlocks
> change/go away.

OK, sounds good!

> Another question: is the SDD module even available for mainline kernels,
> or is it only available for distribution kernels ?

Distributions only.

							Thanx, Paul
