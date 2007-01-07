Return-Path: <linux-kernel-owner+w=401wt.eu-S932543AbXAGODd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbXAGODd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbXAGODd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:03:33 -0500
Received: from thunk.org ([69.25.196.29]:43709 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932543AbXAGODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:03:32 -0500
Date: Sun, 7 Jan 2007 08:59:35 -0500
From: Theodore Tso <tytso@mit.edu>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Rene Herman <rene.herman@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DISCUSS] Making system calls more portable.
Message-ID: <20070107135935.GA26355@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Amit Choudhary <amit2030@yahoo.com>,
	Rene Herman <rene.herman@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <45A0AE5C.6010801@gmail.com> <647618.57006.qm@web55614.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <647618.57006.qm@web55614.mail.re4.yahoo.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 01:07:41AM -0800, Amit Choudhary wrote: 
> Now, let's say a vendor has linux_kernel_version_1 that has 300
> system calls. The vendor needs to give some extra functionality to
> its customers and the way chosen is to implement new system call.
> The new system call number is 301. The customer gets this custom
> kernel and uses number 301.  Next, he downloads another kernel
> (newer linux kernel version) on his system that has already
> implemented the system call numbered 301. The customer now runs his
> program. Even if he compiles it again he has the old header files,
> so that does not make a difference.

So the vendor is doing something bad, and his customers will pay the
price, and they will switch to another vendor who isn't doesn't create
traps for their customers.   What's the problem?  :-)

Serious,y you got into trouble in your second sentence --- and not
just by the use of the passive voice: "the way chosen is to implement
(a) new system call".  Don't do that.

There are plenty of other ways of requesting kernel services; you can
create your own device driver and pass string commands to the device
driver, for example.  What?  You say string-based parsing is slow?
But you were just advocating doing that for all system calls!

Well, then your other choice is to convince the kernel developers that
the interface is stable, and of general interest to the community ---
and if not, then perhaps a more general version of the interface can
be made, with peer review improving the design, and then that can get
implemented.

One example (of both strategies) is shared namespaces.  A vendor's
engineers worked with the Linux VFS developers to introduce shared
namespaces, so that in the future an important product of theirs will
be able to use that feature, instead of a custom kernel module, which
was getting too expensive to maintain.  Getting shared namespaces in
took well over a year, and it'll probably another year or two before
all customers' systems will have it and the product can be revved to
use it, but that's an example of the right way to do things; and in
the meantime, customers are using the version that requires a binary
module that does *NOT* use system calls to provide kernel callouts,
but a custom filesystem instead.

						- Ted
