Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbSISTXB>; Thu, 19 Sep 2002 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272508AbSISTXB>; Thu, 19 Sep 2002 15:23:01 -0400
Received: from albireo.ucw.cz ([81.27.194.19]:5636 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S272493AbSISTW7>;
	Thu, 19 Sep 2002 15:22:59 -0400
Date: Thu, 19 Sep 2002 21:27:58 +0200
From: Martin Mares <mj@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020919192758.GA430@ucw.cz>
References: <20020918164553.GB28202@holomorphy.com> <Pine.LNX.4.44.0209181932580.24794-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181932580.24794-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, world!\n

> nevertheless we do lock up for 32 seconds if there are 32K PIDs allocated
> in a row and last_pid hits that range - regardless of pid_max. (Depending
> on the cache architecture it could take significantly more.)

What about randomizing the PID selection a bit? I.e., allocate PIDs
consecutively as long as they are free; if you hit an already used
PID, roll dice to find a new position where the search should be
continued. As long as the allocated fraction of PID space is reasonably
small, this algorithm should be very quick in average case.

Another possible solution: Divide PID space to blocks and for each
block, keep a counter of PID's available in this block and when
allocating, just skip blocks which are full. Runs in O(sqrt(PID space
size)) in the worst case.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
This message is transmited on 100% recycled electrons.
