Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135682AbRDSUW7>; Thu, 19 Apr 2001 16:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135686AbRDSUWu>; Thu, 19 Apr 2001 16:22:50 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:25288 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135682AbRDSUWk>; Thu, 19 Apr 2001 16:22:40 -0400
Date: Thu, 19 Apr 2001 22:22:28 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Ulrich Drepper <drepper@cygnus.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: light weight user level semaphores
Message-ID: <20010419222228.J682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.31.0104191036220.5052-100000@penguin.transmeta.com> <m3ofts3d4k.fsf@otr.mynet.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <m3ofts3d4k.fsf@otr.mynet.cygnus.com>; from drepper@redhat.com on Thu, Apr 19, 2001 at 12:26:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 12:26:03PM -0700, Ulrich Drepper wrote:
> In any case all kinds of user-level operations are possible as well
> and all the schemes suggested for dealing with the common case without
> syscalls can be applied here as well.

Are you sure, you can implement SMP-safe, atomic operations (which you need
for all up()/down() in user space) WITHOUT using privileged
instructions on ALL archs Linux supports?

How do we do this on nccNUMA machines later? How on clusters[1]?

On what I can see in asm-*/atomic.h this is not possible, but I
probably miss sth. here ;-)

I didn't know that POSIX forbids using fds to implement a
semaphore. That's VERY bad.

Learning new APIs always means making a lot of mistakes and doing
this while we write production code, since nobody likes to pay for
experiments.

And I still see no point on speeding of creation and contention,
since these should be rare cases and the application overusing
these should be punished HARD.

Maybe someone can enlighten my on these aspects.

Regards

Ingo Oeser

[1] Ok, people already use other than Unix mechanisms for this
   stuff on massive parallel computing. So this might not be an
   issue. Only for libc internal sema4s
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
