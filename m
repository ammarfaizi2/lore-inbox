Return-Path: <linux-kernel-owner+w=401wt.eu-S1754947AbWL1Twb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbWL1Twb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 14:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbWL1Twb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 14:52:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:61671 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbWL1Twa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 14:52:30 -0500
Content-Disposition: inline
From: Martin Williges <kernel@zut.de>
To: gregkh@suse.de
Subject: Re: [PATCH 1/1] usblp.c - add Kyocera Mita FS 820 to list of "quirky" printers
Date: Thu, 28 Dec 2006 20:52:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200612282052.10379.kernel@zut.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:0e8a1abe8b7b166fb6ca785a477f557f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Martin Williges <kernel@zut.de>

This patch gets the Kyocera FS-820 working with cups 1.2 via usb again. It
adds the printer to the list of "quirky" printers. The printer seems not
answer to ID requests some seconds after plugging in. Patch is based on
linux-2.6.19.1.

Signed-off-by: Martin Williges <kernel@zut.de>

---

Background:
As far as I could see (strace, usbmon), the Kyocera FS-820 answers to ID
requests only a few seconds after plugging it in. This applies to detecting
it with cups and is also true for the printing itself, which is initiated
with an ID request. Since I have little usb knowledge, maybe someone can
interpret the data, especially the fist bulk transfer - why request 8192
bytes? This is the second version of the patch.

usbmon output of printing an email without patch:
tail -F /tmp/printlog.txt
c636e140 3374734463 S Bi:002:02 -115 8192 <
c9d43b40 3374734494 S Ci:002:00 s a1 00 0000 0000 03ff 1023 <
c9d43b40 3379732301 C Ci:002:00 -104 0
c636e140 3379733294 C Bi:002:02 -2 0
[...repeating...]

with patch:
tail -F /tmp/printlog.txt
d9cb82c0 3729790131 S Ci:002:00 s a1 00 0000 0000 03ff 1023 <
d9cb82c0 3729791725 C Ci:002:00 0 91 = 005b4944 3a46532d 3832303b 4d46473a
 4b796f63 6572613b 434d443a 50434c58 df956320 3732493190 S Bo:002:01 -115
 1347 = 1b252d31 32333435 5840504a 4c0a4050 4a4c2053 4554204d 414e5541
 4c464545 [...more data...]

--- linux-2.6.19.1/drivers/usb/class/usblp.c.orig	2006-12-28 20:15:34.000000000 +0100
+++ linux-2.6.19.1/drivers/usb/class/usblp.c	2006-12-28 19:32:52.000000000 +0100
@@ -217,6 +217,7 @@ static const struct quirk_printer_struct
 	{ 0x0409, 0xbef4, USBLP_QUIRK_BIDIR }, /* NEC Picty760 (HP OEM) */
 	{ 0x0409, 0xf0be, USBLP_QUIRK_BIDIR }, /* NEC Picty920 (HP OEM) */
 	{ 0x0409, 0xf1be, USBLP_QUIRK_BIDIR }, /* NEC Picty800 (HP OEM) */
+	{ 0x0482, 0x0010, USBLP_QUIRK_BIDIR }, /* Kyocera Mita FS 820, by zut <kernel@zut.de> */
 	{ 0, 0 }
 };
