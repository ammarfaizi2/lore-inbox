Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbSLFHnp>; Fri, 6 Dec 2002 02:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267565AbSLFHnp>; Fri, 6 Dec 2002 02:43:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:22445 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267562AbSLFHno>;
	Fri, 6 Dec 2002 02:43:44 -0500
Message-ID: <3DF056EE.EA9ADE01@digeo.com>
Date: Thu, 05 Dec 2002 23:51:10 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: GrandMasterLee <masterlee@digitalroadkill.net>
CC: Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <3DF050EB.108DCF8@digeo.com> <1039160042.16565.15.camel@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 07:51:14.0276 (UTC) FILETIME=[4035E240:01C29CFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GrandMasterLee wrote:
> 
> ...
> > "crashes"?  kernel, or application?   What additional info is
> > available?
> 
> Machine will panic. I've actually captured some and sent them to this
> list, but I've been told that my stack was corrupt.

OK.  In your second oops trace the `swapper' process had used 5k of its
8k kernel stack processing an XFS IO completion interrupt.  And I don't
think `swapper' uses much stack of its own.

If some other process happens to be using 3k of stack when the same 
interrupt hits it, it's game over.

So at a guess, I'd say you're being hit by excessive stack use in
the XFS filesystem.  I think the XFS team have done some work on that
recently so an upgrade may help.

Or it may be something completely different ;)
