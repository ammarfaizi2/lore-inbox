Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbQLHPFa>; Fri, 8 Dec 2000 10:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129841AbQLHPFM>; Fri, 8 Dec 2000 10:05:12 -0500
Received: from tiku.hut.fi ([130.233.228.86]:14855 "EHLO tiku.hut.fi")
	by vger.kernel.org with ESMTP id <S131878AbQLHPFA>;
	Fri, 8 Dec 2000 10:05:00 -0500
Date: Fri, 8 Dec 2000 16:34:32 +0200 (EET)
From: Janne Pänkälä <epankala@cc.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: K6-2+ and MSR registers (PowerNOW)
Message-ID: <Pine.OSF.4.10.10012081613060.10426-100000@alpha.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bought myself this new CPU that is mainly available for laptops.

I have Tyan S1590 board which BIOS won't POST if I set cpu speed (it's
500Mhz chip) >300Mhz. This won't matter much in windows since I can there
use graphical utility which allows one to set whe CPU clock multiplier in
flight as 2.0 - 6.0. But since my machine is Linux like 98% of the time
I'd like to do same in linux.

Things I have considered are. Do I need to recalculate BoGos? Do I need to
reserve the IO space to access it from user space.

what I have tried basically (in user space and kernel space) is

mov ecx, 0c0000086h
mov edx, 0
mov eax, 0fff1h
wrmsr

which is supposed to turn on the powernow feature and set the I/O access
region to 0xfff0 (and 16 bytes upwards actual 4 byte informational block
being at +8 offset) where one can change clock multiplier and do other
stuff.

however access to io region 0xfff0-0xffff remains denied for me in
userspace. In kernel I read it with inw(addr) and there I just get data
that cannot be correct. (it returns ffff)

If someone knows how to read / write MSR registers and high IO ports in
userlevel I'd be thankful for a hint. also RTFM or RTFC pointers are
appreciated.

I have read IO howto and iopl() doesn't work.

In the end it would be nice to do proc entry or user space program that
allows one to [sg]et cpu speed and other PowerNOW properties.

PS.
   references: mobile amd-k6-2+ processor datasheet 23446.pdf by AMD

PPS.
   I'd appriciate if possible answers could be also CC'd to me.


Janne Pänkälä

-- 
Janne
echo peufiuhu@tt.lac.nk | tr acefhiklnptu utpnlkihfeca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
