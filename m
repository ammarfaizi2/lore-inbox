Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUGYKUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUGYKUX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 06:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUGYKUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 06:20:23 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:57800 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S263850AbUGYKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 06:20:17 -0400
Subject: Tuning (stv0299.ko) with SkyStar2/DVB not working with 2.6.8-rc*
	anymore
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1090750814.17579.15.camel@suprafluid.huber.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 25 Jul 2004 12:20:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ML,
I had my SkyStar2 dvb-s card working with 2.6.7-bk21, but with the 2.6.8
release candidate's I cannot tune different channels anymore.
Explicitly testet on 2.6.8-rc2-bk1 and 2.6.8-rc1-bk4 (preempt)

mplayer dvb:// works
e.g. mplayer dvb://ZDF does not

mplayer hangs at: dvb_tune Freq: 11953000

strace:
---
write(1, "dvb_tune Freq: 11953000\n", 24dvb_tune Freq: 11953000
) = 24
ioctl(5, 0x80a86f3d, 0x7fbfffbd40)      = 0
ioctl(5, 0x6f42, 0x1)                   = 0
ioctl(5, 0x6f43, 0x1)                   = 0
nanosleep({0, 15000000}, NULL)          = 0
ioctl(5, 0x40076f3f, 0x7fbfffbd30)      = 0
nanosleep({0, 0}, NULL)                 = 0
nanosleep({0, 15000000}, NULL)          = 0
ioctl(5, 0x6f41, 0)                     = 0
nanosleep({0, 15000000}, NULL)          = 0
ioctl(5, 0x6f42, 0)                     = 0
nanosleep({0, 100000000}, NULL)         = 0
ioctl(5, 0x80286f4e, 0x7fbfffbd00)      = -1 EAGAIN (Resource
temporarily unavai
lable)
ioctl(5, 0x40246f4c, 0x7fbfffbdf0)      = 0
poll([{fd=5, events=POLLPRI, revents=POLLPRI}], 1, 10000) = 1
ioctl(5, 0x80286f4e, 0x7fbfffbd00)      = 0
poll([{fd=5, events=POLLPRI, revents=POLLPRI}], 1, 10000) = 1
ioctl(5, 0x80286f4e, 0x7fbfffbd00)      = 0
[...last line repeating...]
---


output from dmesg:
---
drivers/media/dvb/b2c2/skystar2.c: FlexCopIIB(rev.195) chip found
drivers/media/dvb/b2c2/skystar2.c: the chip has 38 hardware filters
DVB: registering new adapter (Technisat SkyStar2 driver).
probe_tuner: try to attach to Technisat SkyStar2 driver
drivers/media/dvb/frontends/stv0299.c: setup for tuner Samsung
TBMU24112IMB
DVB: registering frontend 0:0 (STV0299/TSA5059/SL1935 based)...
---

