Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbXABAM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbXABAM1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 19:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbXABAM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 19:12:27 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3472 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbXABAM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 19:12:26 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] usb: usbmixer error path fix
Date: Tue, 2 Jan 2007 01:13:46 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020113.47096.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Without the patch below namelist[0] will not be freed in case
of kmalloc error.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 sound/usb/usbmixer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -upr linux-2.6.20-rc2-mm1-a/sound/usb/usbmixer.c linux-2.6.20-rc2-mm1-b/sound/usb/usbmixer.c
--- linux-2.6.20-rc2-mm1-a/sound/usb/usbmixer.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/sound/usb/usbmixer.c	2007-01-01 23:55:31.000000000 +0100
@@ -1526,7 +1526,7 @@ static int parse_audio_selector_unit(str
 		namelist[i] = kmalloc(MAX_ITEM_NAME_LEN, GFP_KERNEL);
 		if (! namelist[i]) {
 			snd_printk(KERN_ERR "cannot malloc\n");
-			while (--i > 0)
+			while (i--)
 				kfree(namelist[i]);
 			kfree(namelist);
 			kfree(cval);


-- 
Regards,

	Mariusz Kozlowski
