Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131556AbRCSTHK>; Mon, 19 Mar 2001 14:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131561AbRCSTHB>; Mon, 19 Mar 2001 14:07:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64519 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131556AbRCSTGv>;
	Mon, 19 Mar 2001 14:06:51 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200103191906.TAA01646@raistlin.arm.linux.org.uk>
Subject: Re: gettimeofday question
To: eli.carter@inet.com (Eli Carter)
Date: Mon, 19 Mar 2001 19:06:00 +0000 (GMT)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier), linux-kernel@vger.kernel.org
In-Reply-To: <3AB64F4F.7518D3D5@inet.com> from "Eli Carter" at Mar 19, 2001 12:26:23 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter writes:
> Russell, I know that at least the EBSA285's timer1_gettimeoffset() needs
> some attention to fix a time going backward problem. 

I know about this, which is what started me looking at what x86 does,
and I am firmly of the conclusion that x86 is buggy as it stands.

I believe that we can, instead of having a per-machine fix on ARM, have
a generic fix.  At the moment, I haven't worked out exactly what this
generic fix would be.

> The problem is only going to occur if gettimeoffset has not been called
> in the past 10ms.  Once 10ms has passed, either jiffies has changed, or
> count will have passed count_p.

My concern with the x86 fix is what if 9.9999999999ms has passed since the
last timer tick, and we got the timer tick after we disabled interrupts and
entered do_gettimeofday.  This can lead to the tests in there miscorrecting
IMHO.  You won't see it with an infinite loop reading the time of day...

I'll re-read your mail in more depth later tonight.  Appologies if this
reply appears to be a little early.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

