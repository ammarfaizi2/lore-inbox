Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbVLUXTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVLUXTV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 18:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVLUXTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 18:19:21 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58506 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S964917AbVLUXTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 18:19:21 -0500
Date: Thu, 22 Dec 2005 00:19:13 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/10] NTP4 updates
Message-ID: <Pine.LNX.4.61.0512220007370.30716@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches convert the kernel NTP code to NTP4. The first 8 
patches do some functional cleanups, which adds as much precalculations as 
possible to simplify the fast path and which also increase resolution and 
precision of the calculations.

The 9th patch completes the conversion to NTP4, it only converts the 
kernel part, it doesn't change yet the user interface (this would also 
require a patched glibc or ntpd to be useful).

I updated the patches at http://www.xs4all.nl/~zippel/ntp/ (in
patches-kernel) to upgrade the old NTP reference to NTP4, I used this to
verify the behaviour compared to the nanokernel reference. Running
nano.sh should produce a similiar output to the kern.dat input
parameters.

The last patch provides an example of how to implement a continuous
gettimeofday on top of these patches, a more detailed explanation is
included with the patch. There is a small test program at
http://www.xs4all.nl/~zippel/ntp/clocktest.c I used to test the
behaviour (it simulates random ntp adjustments, lost interrupts and
random updates). Compared to the kernel code it maintains a bit more
state and may be a bit easier to understand, but you also have to check
the source to understand the output. :)

bye, Roman
