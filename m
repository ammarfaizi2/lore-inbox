Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTLBAB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 19:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTLBAB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 19:01:29 -0500
Received: from ugw.utcc.utoronto.ca ([128.100.102.3]:18696 "HELO
	ugw.utcc.utoronto.ca") by vger.kernel.org with SMTP id S264265AbTLBAB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 19:01:28 -0500
To: linux-kernel@vger.kernel.org
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, ralf@linux-mips.org
Subject: drivers/char/rtc.c compile failure in current 2.4 BitKeeper tree:
Date: Mon, 1 Dec 2003 19:01:17 -0500
From: Chris Siebenmann <cks@utcc.utoronto.ca>
Message-Id: <03Dec1.190119est.6025@ugw.utcc.utoronto.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'm compiling for SMP x86 and getting:
	make[3]: Entering directory `/homes/hawkwind/u0/cks/sys/linux-BK/drivers/char'
	gcc -D__KERNEL__ -I/homes/hawkwind/u0/cks/sys/linux-BK/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=rtc  -c -o rtc.o rtc.c
	rtc.c: In function `rtc_init':
	rtc.c:772: `RTC_IOMAPPED' undeclared (first use in this function)
	rtc.c:772: (Each undeclared identifier is reported only once
	rtc.c:772: for each function it appears in.)
	rtc.c:773: `RTC_IO_EXTENT' undeclared (first use in this function)
	rtc.c: In function `rtc_exit':
	rtc.c:873: `RTC_IOMAPPED' undeclared (first use in this function)
	rtc.c:874: `RTC_IO_EXTENT' undeclared (first use in this function)
	make[3]: *** [rtc.o] Error 1

It looks like the MIPS changes require these to be defined in
include/asm-*/mc146818rtc.h (or included files) for all architectures
(previously RTC_IO_EXTENT was defined in rtc.c and RTC_IOMAPPED didn't
exist), but only MIPS has been updated to do this. From looking at the
diffs to rtc.c, it looks like the correct additions are just:

	#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
	#define	RTC_IOMAPPED	0

	- cks
