Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965804AbWKHOi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965804AbWKHOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965884AbWKHOiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:38:23 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:11783 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965879AbWKHOh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:37:58 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 33/33] usb: usbmixer free kill urb cleanup
Date: Wed, 8 Nov 2006 15:37:04 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <200611071030.57152.m.kozlowski@tuxland.pl> <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <20061107013702.46b5710f.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611081537.05283.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

- usb_free_urb() cleanup
- usb_kill_urb() cleanup

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc4-orig/sound/usb/usbmixer.c	2006-11-06 17:09:28.000000000 +0100
+++ linux-2.6.19-rc4/sound/usb/usbmixer.c	2006-11-07 17:09:16.000000000 +0100
@@ -1620,8 +1620,7 @@ static void snd_usb_mixer_free(struct us
 		kfree(mixer->urb->transfer_buffer);
 		usb_free_urb(mixer->urb);
 	}
-	if (mixer->rc_urb)
-		usb_free_urb(mixer->rc_urb);
+	usb_free_urb(mixer->rc_urb);
 	kfree(mixer->rc_setup_packet);
 	kfree(mixer);
 }
@@ -2056,8 +2055,6 @@ void snd_usb_mixer_disconnect(struct lis
 	struct usb_mixer_interface *mixer;
 	
 	mixer = list_entry(p, struct usb_mixer_interface, list);
-	if (mixer->urb)
-		usb_kill_urb(mixer->urb);
-	if (mixer->rc_urb)
-		usb_kill_urb(mixer->rc_urb);
+	usb_kill_urb(mixer->urb);
+	usb_kill_urb(mixer->rc_urb);
 }
