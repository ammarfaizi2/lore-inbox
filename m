Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289004AbSANURN>; Mon, 14 Jan 2002 15:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSANUPu>; Mon, 14 Jan 2002 15:15:50 -0500
Received: from zero.tech9.net ([209.61.188.187]:57092 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289012AbSANUI0>;
	Mon, 14 Jan 2002 15:08:26 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: Momchil Velikov <velco@fadata.bg>, yodaiken@fsmlabs.com,
        Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <16QBTc-1er7D6C@fwd03.sul.t-online.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<16Q6V6-207eimC@fwd06.sul.t-online.com> <87d70c51wk.fsf@fadata.bg> 
	<16QBTc-1er7D6C@fwd03.sul.t-online.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 15:09:31 -0500
Message-Id: <1011039031.4603.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 13:04, Oliver Neukum wrote:

> It can happen if you sleep with a lock held.
> It can not happen at random points in the code.
> Thus there is a relation to preemption in kernel mode.
> 
> To cure that problem tasks holding a lock would have to be given
> the highest priority of all tasks blocking on that lock. The semaphore
> code would get much more complex, even in the succesful code path,
> which would hurt a lot.

No, this isn't needed.  This same problem would occur without
preemption.  Our semaphores now have locking rules such that we aren't
going to have blatant priority inversion like this (1 holds A needs B, 2
holds B needs A).

When priority inversion begins to become a problem is if we intend to
start turning existing spinlocks into semaphores.  There the locking
rules are weaker, and thus we would need to do priority inheriting.  But
that's not now.

	Robert Love

