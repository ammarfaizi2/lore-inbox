Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSHHTjk>; Thu, 8 Aug 2002 15:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSHHTjk>; Thu, 8 Aug 2002 15:39:40 -0400
Received: from holomorphy.com ([66.224.33.161]:54938 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317888AbSHHTjj>;
	Thu, 8 Aug 2002 15:39:39 -0400
Date: Thu, 8 Aug 2002 12:42:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Larson <plars@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>, davej@suse.de, frankeh@us.ibm.com,
       andrea@suse.de
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020808194238.GG15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@zip.com.au>,
	Paul Larson <plars@austin.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>, davej@suse.de,
	frankeh@us.ibm.com, andrea@suse.de
References: <1028757835.22405.300.camel@plars.austin.ibm.com> <3D51A7DD.A4F7C5E4@zip.com.au> <20020808002419.GA528@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020808002419.GA528@win.tue.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 02:24:19AM +0200, Andries Brouwer wrote:
> Here it is of interest how large a pid is.
> With a 64-bit pid_t it is just
>   static pid_t last_pid;
>   pid_t get_next_pid() {
> 	return ++last_pid;
>   }
> since 2^64 is a really large number.
> Unfortunately glibc does not support this (on x86).
> With a 32-bit pid_t wraparounds will occur, but very infrequently.
> Thus, finding the next pid will be very fast on average, much faster
> than the above algorithm, and no arrays are required.
> One only loses the guaranteed constant time property.
> Unless hard real time is required, this sounds like the best version.

The goal of the work that produced this was to remove the global
tasklist. Changing ABI's and/or breaking userspace was not "within the
rules" of that. My allocator relies on that other infrastructure for
notification of release of pid's, and is really only meant to remove
the reliance of fork() on the tasklist. That work is probably more
relevant to heavy tty usage than forkbombs, despite the O(1) get_pid().
I am glad people happen to like various tidbits of it, though. =)


Cheers,
Bill
