Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUK2LiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUK2LiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbUK2LiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:38:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:2495 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261673AbUK2LiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:38:20 -0500
Date: Mon, 29 Nov 2004 12:38:11 +0100 (MET)
Message-Id: <200411291138.iATBcBiR007342@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1 broke apmd
Cc: pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with 2.6.10-rc1, date and time on my old APM-based
laptop is messed up after a resume. Specifically, Emacs and
xclock both make a huge forward leap and then stop updating
their current time displays.

The cause is the "jiffies += sleep_length * HZ;" addition
to arch/i386/kernel/time.c:time_resume() which is in conflict
with the hwlock --hctosys that the APM daemon normally does
at resume.

Preventing apmd from updating the system time does eliminate
the problems I described, but this requires kernel-version
dependent settings in user-space, which is ugly and fragile.

Just FYI. I don't have a nice solution yet.

/Mikael
