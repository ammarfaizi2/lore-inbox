Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271124AbRIATHN>; Sat, 1 Sep 2001 15:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271212AbRIATHF>; Sat, 1 Sep 2001 15:07:05 -0400
Received: from poplar.cs.washington.edu ([128.95.2.24]:44304 "EHLO
	poplar.cs.washington.edu") by vger.kernel.org with ESMTP
	id <S271124AbRIATGq>; Sat, 1 Sep 2001 15:06:46 -0400
Date: Sat, 1 Sep 2001 12:07:02 -0700
From: Neil Spring <nspring@cs.washington.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Excessive TCP retransmits over lossless, high latency link
Message-ID: <20010901120702.A30845@cs.washington.edu>
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch> <20010901194141.44617@colin.muc.de> <20010901192242.A2714@thefinal.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010901192242.A2714@thefinal.cern.ch>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't see what is broken about the remote end in this case.

The remote end is probably not broken, at least in this
case.  This looks like an artifact of a disgustingly
large queue, and a very slow link.  When the time to
transmit tiny packets in the initial handshake is much
smaller than the time to transmit a full size frame,
retransmission timers can get confused.  A complete trace
would settle this.

I strongly recommend setting the mtu of your ppp0 interface
down to 576 (or smaller) to reduce the time it takes to
transfer a full size frame, decrease the likelihood that
frames suffer corruption, and allow acknowledgements more
often than every 5 seconds.  This is a setting in your ppp
configuration, don't do this using ifconfig. 

Don't take my word for it, see RFC1144, section 5.2: a
good MTU is chosen so that a full size frame is transferred
in 200ms.

RFC1144, written by Van Jacobson:

   To illustrate, note that for a 9600 bps line with
   header compression there is essentially no benefit
   in increasing the MTU beyond 200 bytes: If the MTU is
   increased to 576, the average delay increases by 188%
   while throughput only improves by 3% (from 96 to 99%).

Besides, if you do what you propose (not ack old data with the 
next byte expected) you risk stalling the connection entirely.

-neil

