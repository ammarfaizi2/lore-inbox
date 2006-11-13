Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755281AbWKMUnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbWKMUnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755333AbWKMUnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:43:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:46801 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755281AbWKMUnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:43:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=QnVWvQSHSSPnCwBcMmJeLGjA2wLNybMCokDLWL+6VWXrO28gXc2eMMQPk4W6XHl5UDvdOCryZhucO301Zzp01rbPrEGkMTce9wrB8LEl06S1zr//FThaNZMl8hQS/GkiUqh//K0226caJERObViA01mgiTMGTJn8MMPLX808aJI=
Date: Mon, 13 Nov 2006 21:43:40 +0100
From: Luca Tettamanti <kronos.it@gmail.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] atkbd: disable spurious ACK/NAK warning on panic
Message-ID: <20061113204340.GA25557@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the panic() message has been printed kernel may blink keyboard
leds to signal the abnormal condition.
atkbd warns that "Some program might be trying access hardware directly"
at every blink, scrolling the useful text out of the screen.
Avoid printing the warning when oops_in_progress is set in order to
preserve the panic message.

Signed-Off-By: Luca Tettamanti <kronos.it@gmail.com>

---
 Patch against current GIT tree.

 drivers/input/keyboard/atkbd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index cbb9366..81d2701 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -412,6 +412,8 @@ static irqreturn_t atkbd_interrupt(struc
 			goto out;
 		case ATKBD_RET_ACK:
 		case ATKBD_RET_NAK:
+			if (oops_in_progress)
+				goto out;
 			printk(KERN_WARNING "atkbd.c: Spurious %s on %s. "
 			       "Some program might be trying access hardware directly.\n",
 			       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);


Luca
-- 
"In linea di principio sarei indifferente al natale, se solo il natale
 ricambiasse la cortesia e mi lasciasse in pace." -- Marco d'Itri
