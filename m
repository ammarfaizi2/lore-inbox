Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbTIUNCx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTIUNCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:02:53 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:43971 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S262396AbTIUNCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:02:51 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/11] input: Fix psmouse->pktcnt in Synaptics mode
References: <10639672012999@twilight.ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Sep 2003 15:02:40 +0200
In-Reply-To: <10639672012999@twilight.ucw.cz>
Message-ID: <m2k782waz3.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> ChangeSet@1.1345, 2003-09-19 01:20:33-07:00, vojtech@suse.cz
>   psmouse-base.c:
>     Make sure psmouse->pktcnt is zero after passing a byte
>     to be processed by synaptics code.

This patch breaks synaptics support, because the pktcnt variable is
now used by the synaptics code. (Previously the synpatics code used a
private buffer, which was unnecessary and therefore removed.)
Reverting this patch makes the touchpad work again for me using kernel
2.6.0-test5-bk8:

 linux-petero/drivers/input/mouse/psmouse-base.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN drivers/input/mouse/psmouse-base.c~fix-psmouse-breakage drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~fix-psmouse-breakage	2003-09-21 14:51:59.000000000 +0200
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2003-09-21 14:52:10.000000000 +0200
@@ -173,7 +173,6 @@ static irqreturn_t psmouse_interrupt(str
 		 * so it needs to receive all bytes one at a time.
 		 */
 		synaptics_process_byte(psmouse, regs);
-		psmouse->pktcnt = 0;
 		goto out;
 	}
 

_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
