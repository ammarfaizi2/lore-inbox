Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUFGVCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUFGVCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUFGVCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:02:51 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:59074 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265055AbUFGVCt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:02:49 -0400
From: "Thomas Gleixner" <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
Organization: linutronix
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2.4] jffs2 aligment problems
Date: Mon, 7 Jun 2004 22:56:46 +0200
User-Agent: KMail/1.5.4
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
References: <40C484F9.20504@timesys.com> <1086640771.29255.57.camel@localhost.localdomain> <Pine.LNX.4.58.0406071351450.1637@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406071351450.1637@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406072256.46952.tglx@linutronix.de>
X-Seen: false
X-ID: JbTRGmZvweEMvJz0bHFNlZfqkRAMZCAug-lqLl3gcGvsDJvaROLHkZ@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 June 2004 22:54, Linus Torvalds wrote:
> On Mon, 7 Jun 2004, David Woodhouse wrote:
> > On Mon, 2004-06-07 at 12:22 -0700, Linus Torvalds wrote:
> > > I don't see it as a correctness issue, I see it as a performance issue.
> >
> > In the case in question it's very much _not_ a performance issue. We're
> > writing a buffer to FLASH memory. The time it takes to read the word
> > from RAM is entirely lost in the noise compared with the time it takes
> > to write it to the flash.
>
> Not if you have to take an alignment fault, which is easily several
> thousand cycles.
>
> Think of "get_unaligned()" as a worst-case limiter. It can make the best
> case be worse on architectures where it matters, but it can make the worst
> case go from thousands of cycles to just single cycles.
>
> And your flash isn't _that_ slow. Thousands of cycles that can't even
> overlap with any flash IO _does_ show up.

Not the IO write to the FLASH is the slow and noisy part, its the programming 
of the FLASH after writing the data which blocks for a non deteministic time 
in the range of milliseconds.
So we did not care if it took ms + x µs due to an alignement trap

-- 
Thomas
________________________________________________________________________
Steve Ballmer quotes the statistic that IT pros spend 70 percent of their 
time managing existing systems. That couldn’t have anything to do with 
the fact that 99 percent of these systems run Windows, could it?
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

