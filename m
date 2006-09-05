Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWIEAR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWIEAR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 20:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWIEAR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 20:17:28 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:11975 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751426AbWIEAR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 20:17:26 -0400
Date: Mon, 04 Sep 2006 20:17:03 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.18-rc6
In-reply-to: <20060904223153.GK13238@bayes.mathematik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@osdl.org>,
       Jeremy Roberson <jroberson@gtcocalcomp.com>,
       linux-kernel@vger.kernel.org
Message-id: <200609042017.03515.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
 <200609040705.53780.gene.heskett@verizon.net>
 <20060904223153.GK13238@bayes.mathematik.tu-chemnitz.de>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 September 2006 18:31, Steffen Klassert wrote:
>On Mon, Sep 04, 2006 at 07:05:53AM -0400, Gene Heskett wrote:
>> On Sunday 03 September 2006 22:42, Linus Torvalds wrote:
>> >Things are definitely calming down, and while I'm not ready to call it
>> > a final 2.6.18 yet, this migt be the last -rc.
>>
>> It has one new build warning, no idea if show stopper or not:
>> ----------
>> drivers/usb/input/hid-core.c:1447:1: warning: "USB_DEVICE_ID_GTCO_404"
>> redefined
>> drivers/usb/input/hid-core.c:1446:1: warning: this is the location of
>> the previous definition
>> ----------
>> until after I boot to it...
>>
>> And that didn't seem to effect the mouse.  Other usb stuff has not been
>> exersized yet.
>
>The offending patch is
>hid-core.c: Adds all GTCO CalComp Digitizers and InterWrite School
> Products to blacklist
>
>If one looks at this patch it seems to be just a typo.
>The patch below fixes at least the warning.
>
>--- vanilla-2.6.18-rc6/drivers/usb/input/hid-core.c 2006-09-04
> 04:19:48.000000000 +0200 +++
> linux-2.6.18-rc6/drivers/usb/input/hid-core.c 2006-09-04
> 23:53:10.000000000 +0200 @@ -1444,7 +1444,7 @@
> #define USB_DEVICE_ID_GTCO_402  0x0402
> #define USB_DEVICE_ID_GTCO_403  0x0403
> #define USB_DEVICE_ID_GTCO_404  0x0404
>-#define USB_DEVICE_ID_GTCO_404  0x0405
>+#define USB_DEVICE_ID_GTCO_405  0x0405
> #define USB_DEVICE_ID_GTCO_500  0x0500
> #define USB_DEVICE_ID_GTCO_501  0x0501
> #define USB_DEVICE_ID_GTCO_502  0x0502
>@@ -1657,7 +1657,7 @@
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
>- { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
>+ { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501, HID_QUIRK_IGNORE },
>  { USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502, HID_QUIRK_IGNORE },
>-

I did apply this patch, with vim as its only 2 characters that are actually 
changed.  But now I'm going to go back and look at the log from before I 
rebooted to this patch.  Yes, since 2.6.18-rc6, I'm getting these in the 
log, and this patch obviously has no effect on the below log entries.
--------------
Sep  3 15:20:10 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 15:33:14 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 15:47:25 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 15:56:45 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 16:08:05 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 16:17:24 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 16:37:13 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 16:48:12 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 17:19:10 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 17:26:16 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 17:36:22 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 17:42:18 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 17:51:46 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 18:03:08 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 18:16:52 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 18:35:08 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 18:43:34 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 18:52:31 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 19:10:15 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 19:27:17 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
Sep  3 19:35:45 coyote kernel: usb 3-2.1: reset low speed USB device using 
ohci_hcd and address 3
-----------

And they are being logged at times when I am nowhere near the mouse to move 
it, at varying intervals of 2-3 a minute as you can see above.

Is there a way to shut this up?  The mouse is working great, although its 
possible the battery is getting weak.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
