Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264027AbRFNUka>; Thu, 14 Jun 2001 16:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264028AbRFNUkU>; Thu, 14 Jun 2001 16:40:20 -0400
Received: from alpo.casc.com ([152.148.10.6]:21464 "EHLO alpo.casc.com")
	by vger.kernel.org with ESMTP id <S264027AbRFNUkA>;
	Thu, 14 Jun 2001 16:40:00 -0400
From: John Stoffel <stoffel@casc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.8435.312548.682190@gargle.gargle.HOWL>
Date: Thu, 14 Jun 2001 16:39:15 -0400
To: Roger Larsson <roger.larsson@norran.net>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-pre2, pre3 VM Behavior
In-Reply-To: <200106142030.f5EKUWH19842@maile.telia.com>
In-Reply-To: <Pine.LNX.4.21.0106140013000.14934-100000@imladris.rielhome.conectiva>
	<01061410474103.00879@starship>
	<200106142030.f5EKUWH19842@maile.telia.com>
X-Mailer: VM 6.92 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roger> It does if you are running on a laptop. Then you do not want
Roger> the pages go out all the time. Disk has gone too sleep, needs
Roger> to start to write a few pages, stays idle for a while, goes to
Roger> sleep, a few more pages, ...

That could be handled by a metric which says if the disk is spun down,
wait until there is more memory pressure before writing.  But if the
disk is spinning, we don't care, you should start writing out buffers
at some low rate to keep the pressure from rising too rapidly.  

The idea of buffers is more to keep from overloading the disk
subsystem with IO, not to stop IO from happening at all.  And to keep
it from going from no IO to full out stalling the system IO.  It
should be a nice line as VM pressure goes up, buffer flushing IO rate
goes up as well.  

Overall, I think Rik, Jonathan and the rest of the hard core VM crew
have been doing a great job with 2.4.5+ work, it seems like it's
getting better and better all the time, and I really appreciate it.

We're now more into some corner cases and tuning issues.  Hopefully.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
