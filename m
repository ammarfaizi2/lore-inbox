Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbVEIG5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbVEIG5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVEIG5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:57:20 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:48810 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S263066AbVEIG5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:57:12 -0400
Date: Mon, 09 May 2005 10:57:05 +0400
From: Mitch <Mitch@0Bits.COM>
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Message-id: <427F09C1.8010703@0Bits.COM>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Mail/News Client 1.0+ (X11/20050427)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

No, no change with the attached patch either. Mouse goes to sleep and 
need to be re-enabled constantly.

Cheers
Mitch

-------- Original Message --------
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Date: Mon, 9 May 2005 01:26:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <427EFF3C.1040706@0Bits.COM>

On Monday 09 May 2005 01:12, Mitch wrote:
> Log file as requested...
> 

*sign* ALPS decided to return bare PS/2 packet instead of full 6-byte
packet...

Hmm, could you please try the patch below and see if it makes any
difference (although I doubt). I'll probably have to do special case
for ALPS.

-- 
Dmitry

--- drivers/input/mouse/psmouse-base.c.orig	2005-05-09 
01:19:17.000000000 -0500
+++ drivers/input/mouse/psmouse-base.c	2005-05-09 01:20:22.000000000 -0500
@@ -657,7 +657,7 @@
  	int attempt;

  	for (attempt = 0; attempt < 5; attempt++) {
-		if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_SETSTREAM))
+		if (!ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE))
  			return 0;
  		msleep(200);
  	}
@@ -693,7 +693,7 @@
   * transmitting motion packet, so we use ps2_sendbyte() instead of
   * ps2_command() to avoid delay.
   */
-	ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_SETPOLL, 20);
+	ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, 20);

  	ps2_command(&psmouse->ps2dev, psmouse->packet, PSMOUSE_CMD_POLL | 
0x0600);
  	if (psmouse->ps2dev.cmdcnt != 6 - psmouse->pktsize)
