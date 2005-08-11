Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVHKTb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVHKTb1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVHKTb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:31:27 -0400
Received: from pat.uio.no ([129.240.130.16]:43757 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932404AbVHKTb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:31:26 -0400
Subject: Re: fcntl(F_GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Heikki Orsila <shd@modeemi.cs.tut.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
In-Reply-To: <20050811192347.GG31158@jolt.modeemi.cs.tut.fi>
References: <20050811184144.GE31158@jolt.modeemi.cs.tut.fi>
	 <1123786619.7095.47.camel@lade.trondhjem.org>
	 <20050811190252.GF31158@jolt.modeemi.cs.tut.fi>
	 <1123787745.7095.53.camel@lade.trondhjem.org>
	 <20050811192347.GG31158@jolt.modeemi.cs.tut.fi>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 15:31:15 -0400
Message-Id: <1123788676.7095.65.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.919, required 12,
	autolearn=disabled, AWL 1.08, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 22:23 (+0300) skreiv Heikki Orsila:
> On Thu, Aug 11, 2005 at 03:15:45PM -0400, Trond Myklebust wrote:
> > The difference between inotify and leases is, as I said, that leases
> > notify the lease holder synchronously. This allows the notified process
> > to flush all the cached information _before_ the operation that
> > triggered the lease notification is executed.
> 
> So you're talking about the kernel side.. I was talking about userspace 
> perspective on the syscall. It would be rather odd to let a syscall
> block other applications involuntarily (and thus achieving synchronous 
> action in your meaning)..

No. What I said is true of both kernel space and userspace.

Samba needs the exact same semantics as NFSv4 has: it needs to prevent a
local open() syscall from succeeding while the CIFS clients that hold
oplocks flush their cached information (data, metadata, locks...) back
to the server.

BTW: the blockage is only temporary. If the clients don't respond within
a certain time period (as set by the global
sysctl /proc/sys/fs/lease-break-time) then the lease will be
pre-emptively broken by the kernel.

As I said, this is _very_ different from what inotify does.

Cheers,
  Trond

