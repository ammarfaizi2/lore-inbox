Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbUDPPzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUDPPzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:55:18 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:641
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263364AbUDPPzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:55:11 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, shannon@widomaker.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040416090331.GC22226@mail.shareable.org>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <20040416090331.GC22226@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082130906.2581.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 08:55:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 02:03, Jamie Lokier wrote:

> Perhaps because 2.6 changes the UDP retransmit model for NFS, to
> estimate the round-trip time and thus retransmit faster than 2.4
> would.  Sometimes _much_ faster: I observed retransmits within a few
> hundred microseconds.

Retransmits within a few 100 microsecond should no longer be occurring.
Have you redone those measurements with a more recent kernel?
2.6.x and 2.4.x should have pretty much the same code for RTO
estimation.

In fact pretty much all the 2.4.x and 2.6.x RPC code is shared. The one
difference is that 2.6.x uses zero copy writes.


> There was also a problem with late 2.5 clients and "soft" NFS mounts.
> Requests would timeout after a fixed number of retransmits, which on a
> LAN could be after a few milliseconds due to round-trip estimation and
> fast server response.  Then when an I/O on the server took longer,
> e.g. due to a disk seek or contention, the client would timeout and
> abort requests.  2.4 doesn't have this problem with "soft" due to the
> longer, fixed retransmit timeout.  I don't know if it is fixed in
> current 2.6 kernels - but you can avoid it by not using "soft" anyway.

Or changing the default value of "retrans" to something more sane. As
usual, Linux has a default that is lower than on any other platform.

Cheers,
  Trond
