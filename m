Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUDMWF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbUDMWF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:05:57 -0400
Received: from pD953265E.dip.t-dialin.net ([217.83.38.94]:13581 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263777AbUDMWFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:05:53 -0400
Date: Tue, 13 Apr 2004 21:58:33 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: [PATCH] sort out CLOCK_TICK_RATE usage, 2nd try  [0/3]
Message-ID: <20040413215833.A7047@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>; from dl8bcu@dl8bcu.de on Mon, Apr 12, 2004 at 07:55:20AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The calculation of the counter values in drivers/input/misc/pcspkr.c is
incorrectly based on CLOCK_TICK_RATE. This goes unnoticed in i386 
because there the system clock is driven by the same Programmable 
Interval Timer chip as the speaker. But this doesn't hold true on
other archs, e.g. Alpha.

To solve this problem I made these tree patches:

1/3:	introduce asm-*/8253pit.h, #defining PIT_TICK_RATE constant. 
	It seems this is not always the same value.
2/3:	use PIT_TICK_RATE in *spkr.c and some other places where the
 	PIT is directly programmed.
3/3:	use CLOCK_TICK_RATE where 1193180 was used in general timing 
	calculations.
 
Tested on Alpha and i386. Many thanks to David Mosberger, Miles Bader
and Zwane Mwaikambo for their comments.
 
Arch maintainers please have a look whether I got the constants right or
if your architecture has a PIC or speaker at all.

Comments welcome.
 
Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
