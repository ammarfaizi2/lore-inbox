Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264603AbRFPKLh>; Sat, 16 Jun 2001 06:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264605AbRFPKLY>; Sat, 16 Jun 2001 06:11:24 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:57348 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S264603AbRFPKLS>;
	Sat, 16 Jun 2001 06:11:18 -0400
Date: Fri, 15 Jun 2001 15:52:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP spin-locks
Message-ID: <20010615155251.C37@toy.ucw.cz>
In-Reply-To: <200106142045.f5EKjLI14289@mailf.telia.com> <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1010614165153.16430A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Jun 14, 2001 at 05:05:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The 'read()' routine uses a spinlock when it modifies pointers.
> 
> I started to look into where all the CPU clocks were going. The
> SMP spinlock code is where it's going. There is often contention
> for the lock because interrupts normally occur at 50 to 60 kHz.
> 
> When there is contention, a very long........jump occurs into
> the test.lock segment. I think this is flushing queues. 

On UP, there's *never* contention on the lock, because irqsave lock
disables interrupts. Right? Something else must be slowing you.

								Pavel
PS: But that's bad. Performance should not come down twice --
this will bite you even on real SMP.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

