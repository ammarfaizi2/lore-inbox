Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbTIHD4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 23:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTIHD4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 23:56:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61027 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261318AbTIHD4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 23:56:12 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
References: <20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay>
	<20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay>
	<20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay>
	<20030904010653.GD5227@work.bitmover.com>
	<m11xusnvqc.fsf@ebiederm.dsl.xmission.com>
	<20030907230729.GA19380@work.bitmover.com>
	<m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
	<20030908005749.GA24714@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Sep 2003 21:55:47 -0600
In-Reply-To: <20030908005749.GA24714@work.bitmover.com>
Message-ID: <m1smn8lyrg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Sun, Sep 07, 2003 at 05:47:04PM -0600, Eric W. Biederman wrote:
> > I have already built a 2304 cpu machine and am working on a 2900+ cpu
> > machine.  
> 
> That's not "a machine" that's ~1150 machines on a network.  This business
> of describing a bunch of boxes on a network as "a machine" is nonsense.

Every bit as much as describing a scalable NUMA box with replaceable
nodes as a single machine is nonsense.  When things are built and run
as a single machine, it is a single machine.  The fact you
standardized parts used many times does not change that.

The only real difference is cache coherency, and the price.

I won't argue that at the lowest end the vendor delivers you a pile of
boxes and walks away, at which point you must do everything yourself
and it is a real maintenance pain.  But that is the lowest end and
certainly not what I sell.  The systems are built and tested as a
single machine before delivery.

> Don't get me wrong, I love clusters, in fact, I think what you are doing
> is great.  It doesn't screw up the OS, it forces the OS to stay lean and
> mean.  Goodness.
> 
> All the CC cluster stuff is about making sure that the SMP fanatics don't
> screw up the OS for you.  We're on the same side.  Try not to be so rude
> and have a bit more vision.

And I agree, except on some small details.  Although I have yet to see
the large way SMP folks causing problems.

But as far as doing the work there are two different ends the work can be
started from.
a) SMP and make the locks finer grained.
b) Cluster and add the few necessary locks.

Both solutions run fine on a NUMA machine.  And both eventually lead
to good SSI solutions.  But except for some magic piece that only
works on cc NUMA nodes, you can develop all of the SSI software on an
ordinary cluster.  On an ordinary cluster that is that is the only
option,  and so the people with clusters are going to do the work.
The only reason you don't see more SSI work out of the cluster guys is
they are willing to sacrifice some coherency for scalability.  But
mostly it is because of the fact that clusters are only slowly
catching on.

So assuming the non coherent cluster guys do their part you get SSI
software that works out of the box and does everything except for
optimize the page cache for the shared physical hardware.  And the
software will scale awesomely because each generation of cluster
hardware is larger than the last.

The only piece that is unique is CCFS, which builds a shared page
cache.  And even then the non coherent cluster guys may come up with
a better solution.

So my argument is that if you are going to do it right.  Start with
an ordinary non-coherent cluster.  Build the SSI support.  Then build
CCFS the global shared page cache as an optimization.

I fail to see how starting with CCFS will help, or assuming CCFS will
be there will help.  Unless you think the R&D budgets of all of the non
coherent cluster guys is insubstantial, and somehow not up to the
task.


Eric
