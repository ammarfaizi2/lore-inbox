Return-Path: <linux-kernel-owner+w=401wt.eu-S1751107AbXAFCoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbXAFCoK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbXAFC21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:28:27 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47963 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbXAFC2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:28:00 -0500
Message-Id: <20070106023007.648972000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:00 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: [patch 07/50] DVB: lgdt330x: fix signal / lock status detection bug
Content-Disposition: inline; filename=dvb-lgdt330x-fix-signal-lock-status-detection-bug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Michael Krufky <mkrufky@linuxtv.org>

In some cases when using VSB, the AGC status register has been known to
falsely report "no signal" when in fact there is a carrier lock.  The
datasheet labels these status flags as QAM only, yet the lgdt330x
module is using these flags for both QAM and VSB.

This patch allows for the carrier recovery lock status register to be
tested, even if the agc signal status register falsely reports no signal.

Thanks to jcrews from #linuxtv in irc, for initially reporting this bug.

Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---

 drivers/media/dvb/frontends/lgdt330x.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.19.1.orig/drivers/media/dvb/frontends/lgdt330x.c
+++ linux-2.6.19.1/drivers/media/dvb/frontends/lgdt330x.c
@@ -435,9 +435,6 @@ static int lgdt3302_read_status(struct d
 		/* Test signal does not exist flag */
 		/* as well as the AGC lock flag.   */
 		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
 	}
 
 	/*
@@ -500,9 +497,6 @@ static int lgdt3303_read_status(struct d
 		/* Test input signal does not exist flag */
 		/* as well as the AGC lock flag.   */
 		*status |= FE_HAS_SIGNAL;
-	} else {
-		/* Without a signal all other status bits are meaningless */
-		return 0;
 	}
 
 	/* Carrier Recovery Lock Status Register */

--
