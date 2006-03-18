Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWCRW1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWCRW1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 17:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWCRW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 17:27:42 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:62667 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751096AbWCRW1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 17:27:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ab6gO9VrV7CpH/NWrmSjy3Hw0M+34rt74IRQq0Jh5kPzJvzoKx2QyJ8WuKAwF0GqIU2Gfgz0No0+LHZ0mhcTowOnTeHQUpPzoXFvGco1QKZsBP/ib0dQS2Kjm2nWdyWX2ODO6IJDG+TvTT2rcW/pYTYmIJwZ6+1pfaiaJZ2v3Do=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix resource leak in usbmixer
Date: Sat, 18 Mar 2006 23:27:42 +0100
User-Agent: KMail/1.9.1
Cc: Takashi Iwai <tiwai@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182327.42389.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We may leak 'namelist' in sound/usb/usbmixer.c::parse_audio_selector_unit()

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/usb/usbmixer.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.16-rc6-orig/sound/usb/usbmixer.c	2006-03-12 14:19:19.000000000 +0100
+++ linux-2.6.16-rc6/sound/usb/usbmixer.c	2006-03-18 23:23:53.000000000 +0100
@@ -1469,6 +1469,7 @@ static int parse_audio_selector_unit(str
 	kctl = snd_ctl_new1(&mixer_selectunit_ctl, cval);
 	if (! kctl) {
 		snd_printk(KERN_ERR "cannot malloc kcontrol\n");
+		kfree(namelist);
 		kfree(cval);
 		return -ENOMEM;
 	}


