Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267699AbSLGA2O>; Fri, 6 Dec 2002 19:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267702AbSLGA2O>; Fri, 6 Dec 2002 19:28:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:4556 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267699AbSLGA2N>;
	Fri, 6 Dec 2002 19:28:13 -0500
Message-ID: <3DF14260.B324271F@digeo.com>
Date: Fri, 06 Dec 2002 16:35:44 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <20021206222852.GF4335@dualathlon.random> <20021206232125.GR9882@holomorphy.com> <3DF13A54.927C04C1@digeo.com> <20021207002232.GW4335@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2002 00:35:44.0549 (UTC) FILETIME=[9417B550:01C29D88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > One way to address this could be to find a way of making the
> > pages present, but still cause a fault on first access.  Then
> > have a special-case fastpath in the fault handler to really wipe
> > the page just before it is used.  I don't know how though - maybe
> > _PAGE_USER?
> 
> I think taking the page fault itself is the biggest overhead that would
> be nice to avoid on every second virtually consecutive page, if we've to
> take the page fault on every page we could as well do the rest of the
> work that should not that big compared to the overhead of
> entering/exiting kernel and preparing to handle the fault.

Yes, 8k at a time would probably be OK.  Say, L1-size/2.

I expect that anything bigger would cause 2x or worse slowdowns of a
range of apps.
