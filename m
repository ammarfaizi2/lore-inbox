Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTFKVnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFKVni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:43:38 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:60349 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264542AbTFKVnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:43:37 -0400
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Timothy Miller <miller@techsource.com>,
       David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
	<3EE5DE7E.4090800@techsource.com> <m3k7buxbbr.fsf@defiant.pm.waw.pl>
	<03061014044103.06462@tabby>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Jun 2003 23:55:09 +0200
In-Reply-To: <03061014044103.06462@tabby>
Message-ID: <m3znkol1oi.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <jesse@cats-chateau.net> writes:

> As in: ALWAYS ready to write as soon as a connection is made. It can
> still block on a write if the amount to write is larger than the buffer
> available. Nothing is said about the AMOUNT that can be written
> (though with most FIFOs/pipes the limit is ~ 4K, though not guaranteed
> since other writers may fill it between the poll and the write.

Still, it is local (UNIX) datagram socket and thus the number of
datagrams is the limit, not the number of bytes. And yes, the problem
is present with 1-byte datagrams. And still, the problem is with select()
and not with send*().

It is *not* FIFO/pipe/stream socket etc. And not a UDP/IP socket either.

>      A file descriptor for a socket that is listening for connec-
>      tions  will indicate that it is ready for reading, when con-
>      nections are available.  A file descriptor for a socket that
>      is  connecting asynchronously will indicate that it is ready
>      for writing, when a connection has been established.
> 
> as in "READY for writing", not that it won't block when you DO write.
> 
> (Also "READY for reading", not that it won't block when you DO read.)

I think the above covers only stream-based connection establishing.

> You've been lucky to have relatively idle systems or large memory
> systems.
> 
> I suspect you actually were blocking, just not for very long.

No. It is just something completely different.

I understand a system can have no such support. But, currently, Linux
has support which is broken.
-- 
Krzysztof Halasa
Network Administrator
