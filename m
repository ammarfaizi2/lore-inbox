Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVBUR4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVBUR4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVBUR4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:56:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:8849 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262051AbVBUR4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:56:47 -0500
Date: Mon, 21 Feb 2005 09:54:40 -0800
From: Paul Jackson <pj@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       elsa-devel@lists.sourceforge.net, gh@us.ibm.com, efocht@hpce.nec.com,
       jlan@engr.sgi.com
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Message-Id: <20050221095440.2e73a43e.pj@sgi.com>
In-Reply-To: <1108997033.8418.193.camel@frecb000711.frec.bull.fr>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	<1108655454.14089.105.camel@uganda>
	<1108969656.8418.59.camel@frecb000711.frec.bull.fr>
	<20050221014728.6106c7e1.pj@sgi.com>
	<1108981982.8418.120.camel@frecb000711.frec.bull.fr>
	<20050221035808.48401cd2.pj@sgi.com>
	<1108997033.8418.193.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
> 
> I understand your point of view but I'm using netlink interface
> because it's already in the kernel so my choice is to use something that
> is already in the kernel instead of adding dozens of new instructions
> and also to do things in user space.

All else equal, yes it is good to use what facilities are
already available, and it is good to do things in user space.

If one adds many cpu cycles and quite a few pages of memory
to read and touch to every fork, then all else is not equal.


> To test performances, I tried to
> compile a kernel several times with and without the fork connector

I agree that a kernel compile does not measure well fork costs.

There is a good benchmark of fork, exit and other facilities such
as socket, bind and mmap, at:

  http://bulk.fefe.de/scalability/

(the trailing '/' is needed).

You might try downloading them (see the cvs instructions on this page)
and seeing how your changes impact fork and exit.  I had to fiddle with
the rl.rlim counts in forkbench.c to get my copy to run without exceeding
rlimits on fork.

Notice also the rather dramatic improvements from Linux 2.4 to 2.6 in
some of these benchmarks, described elsewhere on the above page.  The
Linux developers take this stuff seriously, and have provided some
seriously good performance under load.

I'd be quite interested to see how your changes affect this benchmark.
Or perhaps you can find some other good measure of fork and exit costs,
the two areas that accounting is at immediate risk of impacting.


>   I also choose this implementation because Erich Focht wrote in the
> email http://lkml.org/lkml/2004/12/17/99 that keeps the historic about
> the creation of processes "sounds very useful for a lot of interesting
> stuff". 

(Some of us who only speak English would find 'history' more idiomatic
here than 'historic' ...)

Adding framework on the basis of such potential future useful value
is a hard sell in Linux land.  It is better to wait until each need is
immediately clear, and it is essential to keep the kernel infrastructure
is light weight as we can, or it will overwhelm the mental capacity of
most of us working on it, including myself for sure ;).


> Thank Paul for your comments,

You're welcome.  Thanks for tackling this task.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
