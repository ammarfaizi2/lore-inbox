Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSKDVGW>; Mon, 4 Nov 2002 16:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKDVGW>; Mon, 4 Nov 2002 16:06:22 -0500
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:22025 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP
	id <S262808AbSKDVGU>; Mon, 4 Nov 2002 16:06:20 -0500
Message-ID: <3DC6E280.6050409@ixiacom.com>
Date: Mon, 04 Nov 2002 13:11:28 -0800
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Schenk <tschenk@origin.ea.com>
Subject: Re: Need assistance in determining memory usage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Thomas Schenk <tschenk@origin.ea.com> wrote:
 > We are building an online game system.  On some of
 > the systems, there are simulator processes running
 > that each service a player.  There may be up to
 > 200 or more of these processes running at any given
 > time and each uses a fairly large amount of memory
 > ...  When the simulator processes start swapping,
 > the systems are becoming unstable, performance goes
 > all to hell...  It would
 > be useful for us to be able to monitor as closely as
 > possible the amount of memory each processes is using
 > and especially to be notified when these processes
 > start using significant amounts of swap, so that we
 > can be prepared to react before the situation gets
 > out of hand.  The other reason why we want to collect
 > this data is so that the developers can analyze the
 > process when it starts to swap ...

A few things you might try:

1. Set RLIMIT_DATA or RLIMIT_AS for your processes
using ulimit.  That should cause malloc() and the
like to return NULL or throw an exception if you go
over the limit.  (RLIMIT_AS doesn't work too well
on heavily multithreaded programs, though, because
of the many stacks.)

2. Try the no-overcommit patch.  That will fail
allocation requests that might conceivably cause swapping
later.  Harsh, but you did want early notification :-)

3. Start reading the kernel source to see how it calculates
memory use and enforces the above limits.  That helped
clarify things for me a bit.

4. If you're feeling really nasty, you could try applying
my patch that implements RLIMIT_RSS by killing the process.
That's pretty immediate feedback, too :-)

- Dan


