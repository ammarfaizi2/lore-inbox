Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSCSDTF>; Mon, 18 Mar 2002 22:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293599AbSCSDSz>; Mon, 18 Mar 2002 22:18:55 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:57865 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S293596AbSCSDSw>;
	Mon, 18 Mar 2002 22:18:52 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15510.42401.731136.2503@argo.ozlabs.ibm.com>
Date: Tue, 19 Mar 2002 13:42:41 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Cort Dougan <cort@fsmlabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <Pine.LNX.4.33.0203181213130.12950-100000@home.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> Btw, here's a program that does a simple histogram of TLB miss cost, and
> shows the interesting pattern on intel I was talking about: every 8th miss
> is most costly, apparently because Intel pre-fetches 8 TLB entries at a
> time.

Here are the results on my 500Mhz G4 laptop:

   1.85: 22
  17.86: 26
  14.41: 28
  16.88: 42
  34.03: 46
   9.61: 48
   2.07: 88
   1.04: 90

The numbers are fairly repeatable except that the last two tend to
wobble around a little.  These are numbers of cycles obtained using
one of the performance monitor counters set to count every cycle.
The average is 40.6 cycles.

This was with a 512kB MMU hash table, which translates to 8192 hash
buckets each holding 8 ptes.  The machine has 1MB of L2 cache.

Paul.
