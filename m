Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265072AbRF2EN4>; Fri, 29 Jun 2001 00:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265530AbRF2ENq>; Fri, 29 Jun 2001 00:13:46 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:30699 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265072AbRF2ENc>; Fri, 29 Jun 2001 00:13:32 -0400
Message-ID: <3B3C0060.FBDB5F87@uow.edu.au>
Date: Fri, 29 Jun 2001 14:13:20 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schuldei <andreas@schuldei.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: artificial latency for a network interface
In-Reply-To: <20010629003900.A6065@sigrid.schuldei.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schuldei wrote:
> 
> to simulate a sattelite link, I need to add a latency to a
> network connection.
> 
> What is the easiest and best way to do that?
> 
> I wanted to do that using two tun devices.
> I had hoped to have a routing like this:
> 
>  <-> eth0 <-> tun0 <-> userspace, waiting queue <-> tun1 <-> eth1

yes, that works very well.  A userspace app sits on top of the
tun/tap device and pulls out packets, delays them and reinjects
them.

The problem is routing: when you send the packet back to the
kernel, it sends it straight back to you.  You need to rewrite
the headers, which is a pain.

A simpler approach is to use policy routing - use the source
and destination devices to override the IP addresses.  Works
well.  The code is at

	http://www.uow.edu.au/~andrewm/packet-delay.tar.gz

It has its own variable bandwidth management as well
as variable latency.  It's for simulating narrowband, high
latency connections.
