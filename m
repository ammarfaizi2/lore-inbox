Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVE3JOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVE3JOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 05:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVE3JOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 05:14:36 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:39555 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261569AbVE3JOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 05:14:14 -0400
Date: Mon, 30 May 2005 11:14:35 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Patrick Boettcher <pb@linuxtv.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-ID: <20050530091434.GA5669@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Patrick Boettcher <pb@linuxtv.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050525134933.5c22234a.akpm@osdl.org> <20050529144548.GC10441@stusta.de> <Pine.LNX.4.61.0505301024120.11869@pub6.ifh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505301024120.11869@pub6.ifh.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.241.39
Subject: Re: 2.6.12-rc5-mm1: drivers/media/dvb/dvb-usb/a800.c compile error
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 10:29:26AM +0200, Patrick Boettcher wrote:
> On Sun, 29 May 2005, Adrian Bunk wrote:
> >It seems this patch is responsible for the following compile error with
> >gcc 2.95:
...
> The attached patch solves the problem by adding a '0' to the array 
> declaration. I don't know if this is ethically correct, but I saw it in 
> some v4l-code, so I assume it is.
...
> -	struct dvb_usb_device_description devices[];
> +	struct dvb_usb_device_description devices[0];

That can't work in this context. Did you even try to compile?

.../dibusb-mb.c:178: warning: excess elements in array initializer
.../dibusb-mb.c:178: warning: (near initialization for `dibusb1_1_properties.devices')

The solution below wastes a few 100 bytes of space, but I think we can
live with that. The same thing was done in dvb-pll.h.
---
gcc-2.95 compile fix.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

Index: linux/drivers/media/dvb/dvb-usb/dvb-usb.h
===================================================================
RCS file: /cvs/linuxtv/dvb-kernel/linux/drivers/media/dvb/dvb-usb/dvb-usb.h,v
retrieving revision 1.16
diff -u -p -r1.16 dvb-usb.h
--- linux/drivers/media/dvb/dvb-usb/dvb-usb.h	2 May 2005 12:48:01 -0000	1.16
+++ linux/drivers/media/dvb/dvb-usb/dvb-usb.h	30 May 2005 09:09:30 -0000
@@ -193,7 +193,7 @@ struct dvb_usb_properties {
 	} urb;
 
 	int num_device_descs;
-	struct dvb_usb_device_description devices[];
+	struct dvb_usb_device_description devices[8];
 };
 
 
