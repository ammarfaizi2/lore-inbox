Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287344AbSAMSRR>; Sun, 13 Jan 2002 13:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287347AbSAMSQ7>; Sun, 13 Jan 2002 13:16:59 -0500
Received: from zero.tech9.net ([209.61.188.187]:57873 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287344AbSAMSQr>;
	Sun, 13 Jan 2002 13:16:47 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kenneth Johansson <ken@canit.se>,
        arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C41A545.A903F24C@linux-m68k.org>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> 
	<3C41A545.A903F24C@linux-m68k.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 13 Jan 2002 13:13:46 -0500
Message-Id: <1010945642.11852.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-01-13 at 10:18, Roman Zippel wrote:

> What somehow got lost in this discussion, that both patches don't
> necessarily conflict with each other, they both attack the same problem
> with different approaches, which complement each other. I prefer to get
> the best of both patches.
> The ll patch identifies problem, which preempt alone can't fix, on the
> other hand the ll patch inserts schedule calls all over the place, where
> preempt can handle this transparently. So far I haven't seen any
> evidence, that preempt introduces any _new_ serious problems, so I'd
> rather like to see to get the best out of both.

Good point.  In fact, I have an "ll patch" for preempt-kernel, it is
called lock-break and available at
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/lock-break

While I am not so sure this sort of explicit work is the answer -- I'd
much prefer to work on the algorithms to shorten lock time or lock into
different locks -- it does work.  The work is based heavily on Andrew's
ll patch but designed for use with preempt-kernel.  This means we can
drop some of the conditional schedules that aren't needed, and in others
we don't need to call schedule (just drop the locks).

	Robert Love

