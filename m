Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136676AbREJOc5>; Thu, 10 May 2001 10:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136683AbREJOcs>; Thu, 10 May 2001 10:32:48 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:35334 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S136676AbREJOc3>; Thu, 10 May 2001 10:32:29 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2001 16:32:19 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: RFD(time): squeezing and stretching the tick
Message-ID: <3AFAC290.22797.1D8AA82@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.1/SWEEP Version 3.43, March 2001 
X-Content-Conformance: LittleSister-1.6/0.0.100644.20010509.100028Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For i386 with TSC, the kernel calibrates how much CPU cycles will fit 
between two timer interrupts. That value corresponds to 10000 
microseconds. Ideally.

In practice however the timer interrupts do not happen exactly every 
10000 us (for hardware reasons).  When interpolating time between ticks 
that calibration value is used.

When using NTP (or adjusting tick manually) the value added every tick 
may be different from 10000us.

If that value is larger, the time seems to jump ahead at the beginning 
of each tick; if the value is smaller, the time may seem to get stuck, 
get slow, or jump back at the beginning of a new tick.

Therefore I added experimental code to scale the value used for tick 
interpolation according to these corrections. As it seems to me, the 
clock quality improves, and the performance penalty only appears when 
the correction value changes.

I haven't done the non-TSC case or other architectures. For 
microseconds it may seem neglectible, but not for nanoseconds.

If anybody has an interesting opinion on this, please Mail.

Regards,
Ulrich
P.S. Not subscribed here.

