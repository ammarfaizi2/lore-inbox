Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280594AbRKFVQp>; Tue, 6 Nov 2001 16:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280587AbRKFVQ0>; Tue, 6 Nov 2001 16:16:26 -0500
Received: from umbriel.xerox.com ([208.140.33.26]:57326 "EHLO
	umbriel.eastgw.xerox.com") by vger.kernel.org with ESMTP
	id <S280591AbRKFVQY>; Tue, 6 Nov 2001 16:16:24 -0500
Message-Id: <200111062116.QAA05254@mailhost.eng.mc.xerox.com>
To: linux-kernel@vger.kernel.org
Subject: delaying "milliseconds" in the kernel
Date: Tue, 06 Nov 2001 16:16:18 -0500
From: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm writing a driver, and want to delay n milliseconds
in an algorithm.

Timers need jiffies, so I need to convert.

Is there a standard to define time?  (I didn't see it -- seems
everything is in HZ).

I wanted a macro or something so I could express my constraint
in milliseconds, and it would be converted to jiffies...

I wanted something like a macro:
#define MSECS_TO_JIFFIES(x)     (x*(HZ/1000))

It seems there is no "standard" way to do this in the kernel
(I ran gid on 2.4.5).

The only think I easily saw was:
drivers/isdn/sc/hardware.h:112:#define milliseconds(x)  (x/(1000/HZ))
which would do what I wanted...I would want to see this at a higher level...

Instead of throwing around HZ everywhere (and having to inuitate how this
mapped time to jiffies), would it be a good idea to have some 
standard way to express milliseconds -- since time is important,
jiffies are an implementation detail.

I think the code would be much clear if I saw
MSECS_TO_JIFFIES(250)
instead of 
(HZ/4)


Just IMHO

marty		mleisner@eng.mc.xerox.com   
Don't  confuse education with schooling.
	Milton Friedman to Yogi Berra
