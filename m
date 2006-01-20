Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWATHEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWATHEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 02:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161325AbWATHEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 02:04:09 -0500
Received: from smile.2scale.net ([212.12.33.142]:13525 "EHLO smile.2scale.net")
	by vger.kernel.org with ESMTP id S1161315AbWATHEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 02:04:09 -0500
Subject: 2.6.15.1 input subsystem gets confused during IO
From: Michael Stiller <ms@2scale.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 20 Jan 2006 08:03:58 +0100
Message-Id: <1137740638.4435.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

on my R51 machine the input subsystem gets very confused if
the machine is a bit loaded. If the machine does somewhat IO
(e.g. spamfiltering your evolution inbox via spamd and clamav)
the input subsystem becomes confused somewhat. 
The mouse cursor jumps around, sometimes the keyboard has
interesting ideas about how much a key should be repeated.
Interesting dmesg output:

psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Unknown key released (translated set 2, code 0x7f on isa0060/serio0).
atkbd.c: Use 'setkeycodes 7f <keycode>' to make it known.
psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.
psmouse.c: TrackPoint at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
atkbd.c: Unknown key released (translated set 2, code 0x7f on isa0060/serio0).
atkbd.c: Use 'setkeycodes 7f <keycode>' to make it known.

The kernel is compiled with:
CONFIG_HZ_1000=y
CONFIG_DEFAULT_IOSCHED="anticipatory"
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y

Any clues? Should i try some other config options?

-Michael

