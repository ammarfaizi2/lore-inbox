Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUKFXXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUKFXXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKFXXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 18:23:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:22933 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261414AbUKFXXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 18:23:00 -0500
Date: Sun, 7 Nov 2004 00:22:33 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, vojtech@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: [no problem] PC110 broke 2.6.9
Message-ID: <20041106232228.GA9446@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I muttered that 2.6.9 had a mouse problem, and soon
afterwards I also noticed that my ADSL didnt work.

I just looked at what was wrong, and the reason turns out to be
a correct fix in the pc110pad_init() call of request_region().

Before 2.6.9 the test there was wrong, so that the region was
seen as unavailable and pc110pad.c did not do anything.

In 2.6.9 the test is correct, the region and irq are reserved and my
ethernet card can no longer reserve its irq and ADSL fails.
Moreover, now pc110pad.c does I/O causing my mouse problems.

Easy solution: CONFIG_MOUSE_PC110PAD=n

I write this in some detail in the hope that this inspires somebody
to figure out whether it is possible to probe & detect this PC110.

Andries
