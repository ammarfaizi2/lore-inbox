Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTKDVlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTKDVlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:41:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:20199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262598AbTKDVlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:41:00 -0500
Date: Tue, 4 Nov 2003 13:40:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
cc: Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
In-Reply-To: <20031104212813.GC30612@ti19.telemetry-investments.com>
Message-ID: <Pine.LNX.4.44.0311041335200.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, Bill Rugolsky Jr. wrote:
> 
> Well, I'm too lazy to wait for a long test, but with a mere
> 100MB file, on 1GHz P3:
> 
> Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> NPTL          100M  7735  99 127068  98 63048  84  7890  98 +++++ +++ +++++ +++
> LinuxThreads  100M 11000  99 127928  97 59075  84 11290  98 +++++ +++ +++++ +++
> 
> So something is amiss.

Ok, so NPTL locking (even in the absense of any threads and thus any 
contention) seems to be noticeably higher-overhead than the old 
LinuxThreads. 

90% of the overhead of a putc()/getc() implementation these days is likely
just locking. Even so, this implies that NPTL locking is about twice as 
expensive as the old LinuxThreads one.

Don't ask me why. But I'm cc'ing Uli, who can probably tell us. Maybe the 
RH-9 libraries are just not very good, and LinuxThreads has had a lot 
longer to optimize their lock behaviour..

			Linus


