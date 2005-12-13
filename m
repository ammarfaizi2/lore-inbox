Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVLMMpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVLMMpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 07:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbVLMMpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 07:45:53 -0500
Received: from mx.laposte.net ([81.255.54.11]:64085 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750973AbVLMMpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 07:45:53 -0500
Message-ID: <17594.192.54.193.25.1134477932.squirrel@rousalka.dyndns.org>
Date: Tue, 13 Dec 2005 13:45:32 +0100 (CET)
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Roman Zippel" <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20051204.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"This is your interpretation and I disagree.

If I set up a timer with a 24 hour interval, which should go off
everyday at 6:00 AM, then I expect that this timer does this even when
the clock is set e.g. by daylight saving. I think, that this is a
completely valid interpretation and makes a lot of sense from a
practical point of view. The existing implementation does it that way
already, so why do we want to change this ?"

Please do not hardcode anywhere 1 day = 24h or something like this.
Relative timers should stay relative not depend on DST.

If someone needs a timer that sets of everyday at the same (legal) time,
make him ask for everyday at that time not one time + n x 24h.

Some processes need an exact legal hour
Other processes need an exact duration

In a DST world that's not the same thing at all - don't assume one or the
other, have coders request exactly what they need and everyone will be
happy.

I can tell from experience trying to fix code which assumed one day = 24h
is not fun at all. And yes sometimes the difference between legal and UTC
time matters a lot.

-- 
Nicolas Mailhot

