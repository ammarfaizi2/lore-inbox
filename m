Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTKZXoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKZXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:44:33 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:29313 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264387AbTKZXns
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:43:48 -0500
Date: Wed, 26 Nov 2003 23:43:35 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: tytso@mit.edu, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-ID: <20031126234335.GO14383@mail.shareable.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com> <20031126202216.GA13116@thunk.org> <20031126130254.010440e5.davem@redhat.com> <20031126212406.GL14383@mail.shareable.org> <20031126133851.6bf5e573.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126133851.6bf5e573.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> > recvmsg() doesn't return timestamps until they are requested
> > using setsockopt(...SO_TIMESTAMP...).
> > 
> > See sock_recv_timestamp() in include/net/sock.h.
> 
> See MSG_ERRQUEUE and net/ipv4/ip_sockglue.c

I don't see your point.  The test for the SO_TIMESTAMP socket option
is _inside_ sock_recv_timestamp() (the flag is called sk_rcvtstamp).

The MSG_ERRQUEUE code simply calls sock_recv_timestamp(), which in
turn only reports the timestamp if the flag is set.

There are exactly two places where the timestamp is reported to
userspace, and both are at the request of userspace:

	1. sock_recv_timestamp(), called from many places including
	   ip_sockglue.c.  It _only_ reports it if SO_TIMESTAMP is
	   enabled for the socket.

	2. inet_ioctl(SIOCGSTAMP)

Nowhere else is the timestamp reported to userspace.

-- Jamie

