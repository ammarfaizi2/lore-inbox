Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265253AbSJWVpD>; Wed, 23 Oct 2002 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265254AbSJWVpD>; Wed, 23 Oct 2002 17:45:03 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:58249 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265253AbSJWVpB>;
	Wed, 23 Oct 2002 17:45:01 -0400
Date: Wed, 23 Oct 2002 23:51:12 +0200
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
Message-ID: <20021023215112.GA12488@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	John Gardiner Myers <jgmyers@netscape.com>,
	linux-aio <linux-aio@kvack.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3DB7136E.8090205@netscape.com> <Pine.LNX.4.44.0210231442490.1581-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210231442490.1581-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 02:51:21PM -0700, Davide Libenzi wrote:

> Why would you want to have a single fd simultaneously handled by two
> different threads with all the locking issues that would arise ? I can
> understand loving threads but this seems to be too much :)

We in fact tried to do this and for good reason. Our nameserver sofware gets
great benefit when two processes listen to the same socket on an SMP system.
In some cases, this means 70% more packets/second, which is close to the
theoretical maximum beneft.

We would heavily prefer to have two *threads* listening to the same socket
instead of to processes. The two processes do not share caching information
now because that expects to live in the same memory.

Right now, we can't do that because of very weird locking behaviour, which
is documented here: http://www.mysql.com/doc/en/Linux.html and leads to
250.000 context switches/second and dysmal peformance.

I expect NPTL to fix this situation and I would just love to be able to call
select() or poll() or recvfrom() on the same fd(s) from different threads.

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
