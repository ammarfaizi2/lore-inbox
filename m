Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUFGPf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUFGPf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUFGPf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:35:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:26589 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264795AbUFGPfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:35:55 -0400
Date: Tue, 8 Jun 2004 03:39:52 +1200 (NZST)
From: Keith Duthie <psycho@albatross.co.nz>
To: linux-kernel@vger.kernel.org
Cc: alsa-user@lists.sourceforge.net
Subject: [PATCH] Fix apm suspend with cs4231 based sound cards
Message-ID: <Pine.LNX.4.53.0406080319560.27816@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch (effectively a reversion of a change between alsa
0.9.4 and 0.9.5) fixes a problem whereby an APM suspend causes the
program which is using the PCM device to enter the uninterruptible sleep
state on resume and thus causes the sound device to be unusable.

--- linux-2.6.5/sound/isa/cs423x/cs4231_lib.c~	Tue Jun  8 03:24:49 2004
+++ linux-2.6.5/sound/isa/cs423x/cs4231_lib.c	Tue Jun  8 03:24:52 2004
@@ -1402,7 +1402,7 @@
 	switch (rqst) {
 	case PM_SUSPEND:
 		if (chip->suspend) {
-			snd_pcm_suspend_all(chip->pcm);
+			//	snd_pcm_suspend_all(chip->pcm);
 			(*chip->suspend)(chip);
 		}
 		break;

I've cc'ed alsa-user instead of alsa-devel as I'm only subscribed to
alsa-user, and my attempt to report this in February (according to an
automated reply I received) "Is being held until the list moderator can
review it for approval."

-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
