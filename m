Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755200AbWKMQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbWKMQov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbWKMQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:44:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1755200AbWKMQou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:44:50 -0500
Date: Mon, 13 Nov 2006 08:44:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Krufky <mkrufky@linuxtv.org>
cc: =?ISO-8859-1?Q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>,
       linux-dvb@linuxtv.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "pasky@ucw.cz" <pasky@ucw.cz>
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged
 into v4l-dvb tree
In-Reply-To: <45589E2E.7070304@linuxtv.org>
Message-ID: <Pine.LNX.4.64.0611130842010.22714@g5.osdl.org>
References: <200611131711.46626.j.suarez.agapito@gmail.com> <45589E2E.7070304@linuxtv.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1026117355-1163436256=:22714"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1026117355-1163436256=:22714
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 13 Nov 2006, Michael Krufky wrote:
> 
> Mauro -- that patch needs fixing / more testing before it goes to mainstream...
> 
> Could you please remove that changeset from your git tree before Linus pulls it?

Too late. Already pulled and pushed out.

Looking at the patch, one obvious bug stands out: the new case statement 
for SAA7134_BOARD_AVERMEDIA_777 doesn't have a "break" at the end.

José, can you test this trivial patch and see if it fixes things?

		Linus

---
diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
index 7f62403..dee8355 100644
--- a/drivers/media/video/saa7134/saa7134-input.c
+++ b/drivers/media/video/saa7134/saa7134-input.c
@@ -202,6 +202,7 @@ int saa7134_input_init1(struct saa7134_d
 		/* Without this we won't receive key up events */
 		saa_setb(SAA7134_GPIO_GPMODE1, 0x1);
 		saa_setb(SAA7134_GPIO_GPSTATUS1, 0x1);
+		break;
 	case SAA7134_BOARD_KWORLD_TERMINATOR:
 		ir_codes     = ir_codes_pixelview;
 		mask_keycode = 0x00001f;
--21872808-1026117355-1163436256=:22714--
