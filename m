Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264868AbSJVShH>; Tue, 22 Oct 2002 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264870AbSJVShH>; Tue, 22 Oct 2002 14:37:07 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:54667 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264868AbSJVShF>;
	Tue, 22 Oct 2002 14:37:05 -0400
Date: Tue, 22 Oct 2002 20:43:13 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: vm scenario tool / mincore(2) functionality for regular pages?
Message-ID: <20021022184313.GA12081@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building a tool to subject the VM to different scenarios and I'd like to
be able to determine if a page is swapped out or not. For a file I can
easily determine if a page is in memory (in the page cache) or not using the
mincore(2) system call.

I want to expand my tool so it can investigate which of its pages are
swapped out under cache pressure or real memory pressure.

However, to do this, I need a way to determine if a page is there or if it
is swapped out. My two questions are:

	1) is there an existing way to do this
	   (the kernel obviously knows)

	2) would it be correct to expand mincore to also work on
           non-filebacked memory so it works for 'swap-backed' memory too?

Thanks.

Some current output of the scenario tool:

vmloader> alloc 25
Arena now 25 megabytes, 6250 pages

vmloader> sweep
Sweeping from mbyte 0 to 25, 6250 pages. Done

vmloader> rusage
minor: 6250, major: 2, swaps: 0

vmloader> sweep 0 12
Sweeping from mbyte 0 to 12, 1440 pages. Done

vmloader> rusage
minor: 0, major: 0, swaps: 0

vmloader> touch
Touching from mbyte 0 to 25, 6250 pages. Done

vmloader> rusage
minor: 6249, major: 0, swaps: 0

vmloader> rsweep
Random sweeping from mbyte 0 to 25, 6250 pages. Done

vmloader> rusage
minor: 0, major: 0, swaps: 0


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
