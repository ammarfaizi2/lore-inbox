Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUDLIEa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 04:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUDLIEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 04:04:30 -0400
Received: from pD9E57A79.dip.t-dialin.net ([217.229.122.121]:38410 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S262703AbUDLIEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 04:04:01 -0400
Date: Mon, 12 Apr 2004 07:55:20 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: linux-kernel@vger.kernel.org
Cc: rth@twiddle.net, spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
       paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
       ralf@gnu.org, matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [0/3]
Message-ID: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: linux-kernel@vger.kernel.org, rth@twiddle.net,
	spyro@f2s.com, rmk@arm.linux.org.uk, davidm@hpl.hp.com,
	paulus@au.ibm.com, benh@kernel.crashing.org, jes@trained-monkey.org,
	ralf@gnu.org, matthew@wil.cx, davem@redhat.com,
	wesolows@foobazco.org, jdike@karaya.com, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

With every 2.6 kernel I tried the system speaker on my Alpha produces a 
rather unpleasant high pitched tone instead of the normal system beep.
This is because in p|cspkr.c the calculation of the counter values is
incorrectly based on CLOCK_TICK_RATE. 
To solve this problem I came up with these tree patches:

1/3:	introduce PIC_TICK_RATE constant. It seems this is not always
	the same value.
2/3:	use PIC_TICK_RATE in *spkr.c and some other places where the
	PIC is directly programmed.
3/3:	use CLOCK_TICK_RATE where 1193180 was used in timing calculations.

Tested on Alpha, compile & boot-tested on i386 (unrelated LVM problems here)

Arch maintainers please have a look whether I got the constants right or
if your architecture has a PIC at all.

Comments welcome.

Bye,
Thorsten


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
