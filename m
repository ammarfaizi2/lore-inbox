Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSBDWqz>; Mon, 4 Feb 2002 17:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289250AbSBDWqp>; Mon, 4 Feb 2002 17:46:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:516 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289243AbSBDWqh>;
	Mon, 4 Feb 2002 17:46:37 -0500
Subject: Re: Continuing /dev/random problems with 2.4
From: Robert Love <rml@tech9.net>
To: Roland Dreier <roland@topspincom.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <52n0yolvpt.fsf@love-boat.topspincom.com>
In-Reply-To: <Pine.LNX.3.96.1020204171035.31056A-100000@gatekeeper.tmr.com> 
	<52n0yolvpt.fsf@love-boat.topspincom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Feb 2002 17:45:27 -0500
Message-Id: <1012862738.848.95.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-04 at 17:37, Roland Dreier wrote:

> Entropy is gathered from interrupt timing in the kernel because
> interrupts are handled in the kernel.  It would be quite difficult for
> a user space process to get accurate information about interrupt
> timing.
> 
> However, the i8xx RNG and audio entropy daemons work perfectly well
> from user space.  What is gained by moving that code into the kernel?

Exactly.  Nothing is gained.

A misconception in this thread seems to be on how this works. 
Generating entropy from interrupts and block I/O uses timing values. 
Differences in successive operations of whatever.  The infrastructure
for carrying out those operations already exists, we just need to note
their timing. 

The i8xx and other RNGs are different.  They actually _give_ us the
random data.  In other words, they generate entropy to just push
directly into the pool.  The concern is that this data may not be safe,
and thus we need to run a fitness test on it (i.e. FIPS 190, I
believe).  All this muck is new code and can exist in userspace --
therefore it will.

	Robert Love

