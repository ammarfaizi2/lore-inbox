Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWAUEkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWAUEkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 23:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWAUEkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 23:40:47 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:39288 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1161257AbWAUEkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 23:40:46 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: RFC: ipath ioctls and their replacements
X-Message-Flag: Warning: May contain useful information
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	<m1y81cpqt8.fsf@ebiederm.dsl.xmission.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 20 Jan 2006 20:40:40 -0800
In-Reply-To: <m1y81cpqt8.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Thu, 19 Jan 2006 01:25:39 -0700")
Message-ID: <adaek32ry5z.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 21 Jan 2006 04:40:43.0501 (UTC) FILETIME=[D6AE89D0:01C61E44]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Eric> Roland you know the RDMA model best, are things so tied to
    Eric> the current crop of infiniband protocols that what the ipath
    Eric> code wants to do is not covered?

    Eric> They clearly need subsystem support and what they are trying
    Eric> to do either isn't covered or they don't see how to use what
    Eric> is there.  Do the infiniband verbs not allow dealing with a
    Eric> unreliable datagram protocol?

I think this has been answered already but the issue is really that
the PathScale hardware does not implement RDMA or even any of the
other connection-oriented abstractions that the RDMA layer is designed
for.  The hardware has only much lower level capabilities, which
basically can send and receive packets on an IB link.

With those capabilites it is possible to implement IB transports in
software -- so for example RDMA read operations are simulated by
having the CPU on the receiver copy data to send the response.
However that implementation is not going to make good use of the IB
midlayer, which really operates at the abstraction level above the IB
transport.

It's also possible to use the PathScale hardware to directly implement
MPI on top of a protocol optimized specifically for MPI, without using
IB verbs semantics or an IB transport on the wire.  But clearly the
userspace interface needed for doing this is not going to match up
very well with a userspace interface for IB verbs (which is at a
different abstraction level).

 - R.
