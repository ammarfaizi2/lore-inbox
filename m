Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVAGPUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVAGPUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 10:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVAGPUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 10:20:37 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:65127 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVAGPUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 10:20:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=db6m8xcy3Wo4iZOtnCdyZ3ygjl5+eLUvzlujIX10g4zdOhWRYt6OqJ1em8sITavFgciHCcLV2p+2CIFRmj6wA8piS3pnZSbLy89cfEqwn47NPeDq+ys+0TIyLWwhhgTA1eWEcIvtXFmQwLS9yjYfZZ8hW0KgenqXxiZDnUZ6dQo=
Message-ID: <d120d50005010707204463492@mail.gmail.com>
Date: Fri, 7 Jan 2005 10:20:22 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Roey Katz <roey@sdf.lonestar.org>
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.61.0501071336010.23626@sdf.lonestar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
	 <200501052316.48443.dtor_core@ameritech.net>
	 <Pine.NEB.4.61.0501070405170.2840@sdf.lonestar.org>
	 <200501070045.24639.dtor_core@ameritech.net>
	 <Pine.NEB.4.61.0501071336010.23626@sdf.lonestar.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so the timeouts are here even with good version. Hmm...

Ok, one thing is that in -bk3 I moved i8042 initialization earlier,
could you try reversing the fragment below (it is cut and paste so
patch won't work, you'll have to move that line manually). And touch
i8042.c to force rebuild.

If this does not work try disabling psmouse - does it help with the keyboard?

-- 
Dmitry

--- a/drivers/Makefile  2004-09-07 23:33:07 -07:00
+++ b/drivers/Makefile  2004-09-13 03:28:52 -07:00
@@ -16,6 +16,9 @@
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y                          += char/
+# we also need input/serio early so serio bus is initialized by the time
+# serial drivers start registering their serio ports
+obj-$(CONFIG_SERIO)            += input/serio/
 obj-y                          += serial/
 obj-$(CONFIG_PARPORT)          += parport/
 obj-y                          += base/ block/ misc/ net/ media/
@@ -40,7 +43,6 @@
 obj-$(CONFIG_USB_GADGET)       += usb/gadget/
 obj-$(CONFIG_INPUT)            += input/
 obj-$(CONFIG_GAMEPORT)         += input/gameport/
-obj-$(CONFIG_SERIO)            += input/serio/
 obj-$(CONFIG_I2O)              += message/
 obj-$(CONFIG_I2C)              += i2c/
 obj-$(CONFIG_W1)               += w1/
