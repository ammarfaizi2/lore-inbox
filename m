Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130607AbRACTxE>; Wed, 3 Jan 2001 14:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130568AbRACTwy>; Wed, 3 Jan 2001 14:52:54 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:63236 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S130606AbRACTwm>; Wed, 3 Jan 2001 14:52:42 -0500
Message-ID: <3A537C2A.A17DCB94@intel.com>
Date: Wed, 03 Jan 2001 11:23:22 -0800
From: Randy Dunlap <randy.dunlap@intel.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: josh <skulcap@mammoth.org>
CC: linux-kernel@vger.kernel.org, david-b@pacbell.net,
        l-u-d <linux-usb-devel@lists.sourceforge.net>
Subject: Re: usb dc2xx quirk
In-Reply-To: <Pine.LNX.4.20.0101031155240.2682-100000@www>
Content-Type: multipart/mixed;
 boundary="------------7D38FE84CE4832C932CF7ED0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7D38FE84CE4832C932CF7ED0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Looks like dc2xx.c shouldn't use __devinit/__devexit
[patch attached]
or you should enable CONFIG_HOTPLUG under General Setup.

David?

The ov511 (usb) driver is the only other USB device driver
that uses __devinit/__devexit.

~Randy

josh wrote:
> 
> Kernel Version: 2.4.0-test11 - 2.4.0-prerelease
> Platform: ix86 (PIII)
> Problem Hardware: Kodac DC280, firmware 1.01
> 
> Ever since test10 or after, removing my dc280 from the usb
> bus causes khubd to crash.  I have tried both UHCI drivers
> and they produce the same effect.
> 
> dmesg, syslog, messages, and .config can be found at:
> http://mammoth.org/~skulcap/usb-problem
> 
> I have looked throug the archives and havent found anything
> like this, so I'm sorry if it has been covered already.
> 
> Thanks in advance!
-- 
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------
--------------7D38FE84CE4832C932CF7ED0
Content-Type: text/plain; charset=us-ascii;
 name="dc2xx-dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dc2xx-dev.patch"

--- linux/drivers/usb/dc2xx.c.org	Sun Nov 12 20:40:42 2000
+++ linux/drivers/usb/dc2xx.c	Wed Jan  3 11:15:11 2001
@@ -353,7 +353,7 @@
 
 
 
-static void * __devinit
+static void *
 camera_probe (struct usb_device *dev, unsigned int ifnum, const struct usb_device_id *camera_info)
 {
 	int				i;
@@ -451,7 +451,7 @@
 	return camera;
 }
 
-static void __devexit camera_disconnect(struct usb_device *dev, void *ptr)
+static void camera_disconnect(struct usb_device *dev, void *ptr)
 {
 	struct camera_state	*camera = (struct camera_state *) ptr;
 	int			subminor = camera->subminor;

--------------7D38FE84CE4832C932CF7ED0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
