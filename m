Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318124AbSGMIcB>; Sat, 13 Jul 2002 04:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318125AbSGMIcA>; Sat, 13 Jul 2002 04:32:00 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:40711 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S318124AbSGMIb7>; Sat, 13 Jul 2002 04:31:59 -0400
Date: Sat, 13 Jul 2002 10:34:47 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: What is supposed to replace clock_t?
Message-ID: <Pine.LNX.4.33.0207130949090.11082-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the log message to your patch that splits in-kernel HZ und user-level HZ
mentions the "broken interfaces that still use 'clock_t'". And indeed,
these interfaces are broken now, since some of them now wrap after 49 
days, while others wrap after 497 days.

My goal with the "> 497 days uptime patch" was to hide internal overflows
within the kernel, so that every exported value wraps exactly when the
number of _exported_ bits does not suffice to hold the true value.

However, with the new divisor of 10 between internal and external time 
values this would now require most internal time values to be stored in
>= 36 bit wide variables (i.e., 64 bit).
Then we could, of course, also extend the exported values where exported
as text, only keeping binary interfaces as 'legacy interfaces'.

Could you please state whether this is your intended direction to go?

Tim

