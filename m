Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbULKOXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbULKOXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 09:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbULKOXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 09:23:16 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:54689 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261936AbULKOXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 09:23:13 -0500
Date: Sat, 11 Dec 2004 15:23:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: dynamic-hz
Message-ID: <20041211142317.GF16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below patch allows to set the HZ dynamically at boot time with
command line parameter. HZ=1000 HZ=100 HZ=333 any other value just works
(though certain value may cause more or less drift to the system time
advance/decrease).

Is there any interest from the mainline developers to merge this into
2.6? I'm getting requests for this feature being forward ported to
2.6 (both for batch jobs and for the powersaved that can trim the hz
down to 80mhz). It should be up to the user to choose the HZ like it was
in 2.4-aa.

This patch is quite intrusive since many HZ visible to userspace have to
be converted to USER_HZ, and most important because HZ isn't available
at compile time anymore and every variable in function of HZ must be
either changed to be in function of USER_HZ or it must be initialized at
runtime. The code has debugging code (optional at compile time) so that
I can guarantee that there cannot be any regression.

Technically this makes a lot of sense to me (well, you can guess why I
implemented it in the first place), at least in archs where one cannot
reprogram the timer chip in a performant way (to stop timer ticks
completely until the next posted timer). This is in production for years
in SLES8 btw.

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3/9999_zzz-dynamic-hz-5.gz

Comments welcome thanks.
