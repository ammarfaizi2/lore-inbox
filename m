Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbSJ3MVw>; Wed, 30 Oct 2002 07:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSJ3MVw>; Wed, 30 Oct 2002 07:21:52 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:12461 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262510AbSJ3MVv>;
	Wed, 30 Oct 2002 07:21:51 -0500
Date: Wed, 30 Oct 2002 13:28:12 +0100
From: bert hubert <ahu@ds9a.nl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP hangs in 2.4 - blocking write() in wait_for_tcp_memory
Message-ID: <20021030122812.GA5182@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <apme9u$n2n$1@ncc1701.cistron.net> <apod64$sv5$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apod64$sv5$1@ncc1701.cistron.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 10:44:20AM +0000, Miquel van Smoorenburg wrote:

> This makes both socket programs hang in write(), in wait_for_tcp_memory.
> Shouldn't the kernel return a short write, instead of hanging
> both processes ? select() returned writeability.

write(2) is allowed to do a short write on a blocking socket, but not
mandated to do so. In fact I've only seen short writes under
linux on non-blocking sockets.

SuSv3 says:

 Blocking/immediate: Blocking is only possible with O_NONBLOCK clear. If
 there is enough space for all the data requested to be written immediately,
 the implementation should do so. Otherwise, the process may block; that is,
 pause until enough space is available for writing. The effective size of a
 pipe or FIFO (the maximum amount that can be written in one operation
 without blocking) may vary dynamically, depending on the implementation, so
 it is not possible to specify a fixed value for it.

...

 Partial and deferred writes are only possible with O_NONBLOCK set.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
