Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277150AbRJHVuz>; Mon, 8 Oct 2001 17:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277151AbRJHVup>; Mon, 8 Oct 2001 17:50:45 -0400
Received: from geos.coastside.net ([207.213.212.4]:32907 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S277150AbRJHVuf>; Mon, 8 Oct 2001 17:50:35 -0400
Mime-Version: 1.0
Message-Id: <p0510030bb7e7ca4c5533@[207.213.214.37]>
Date: Mon, 8 Oct 2001 14:51:19 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: A note on APIC bus latency
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We recently ran into some issues caused by APIC bus latency. I was 
reminded of that by the recent discussion of NAPI and related 
interrupt-performance matters.

Intel processors that predate Pentium 4 but use an APIC transmit APIC 
messages over a serial APIC bus, typically at 16.7 MHz. (Pentium 4 
uses the system bus for APIC messages.)

A message exchange (IO-APIC sends an interrupt message; CPU sends 
back an EOI message) requires from 35 to 48 APIC bus clocks, or 2-3 
microseconds. That gets to be pretty significant compared to packet 
times, especially at Gbit speeds, but even at 100 MHz, and is the 
time required to burst a thousand bytes or more at faster PCI rates.

It's also likely to be significant for inter-processor interrupts, 
though I don't know what the implications are here.
-- 
/Jonathan Lundell.
