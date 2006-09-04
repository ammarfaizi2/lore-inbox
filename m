Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWIDWb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWIDWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWIDWb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:31:58 -0400
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2]:35488 "EHLO
	john.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S932149AbWIDWb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:31:56 -0400
Date: Tue, 5 Sep 2006 00:31:54 +0200
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: Gene Heskett <gene.heskett@verizon.net>,
       Linus Torvalds <torvalds@osdl.org>,
       Jeremy Roberson <jroberson@gtcocalcomp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060904223153.GK13238@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Jeremy Roberson <jroberson@gtcocalcomp.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <200609040705.53780.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609040705.53780.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.2 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	0.0 UPPERCASE_25_50        Nachrichtentext besteht zu 25-50% aus
	Grossbuchstaben
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 6c4dba1e91403f6684caf61b693d4145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 07:05:53AM -0400, Gene Heskett wrote:
> On Sunday 03 September 2006 22:42, Linus Torvalds wrote:
> >Things are definitely calming down, and while I'm not ready to call it a
> >final 2.6.18 yet, this migt be the last -rc.
> >
> It has one new build warning, no idea if show stopper or not:
> ----------
> drivers/usb/input/hid-core.c:1447:1: warning: "USB_DEVICE_ID_GTCO_404" 
> redefined
> drivers/usb/input/hid-core.c:1446:1: warning: this is the location of the 
> previous definition
> ----------
> until after I boot to it...
> 
> And that didn't seem to effect the mouse.  Other usb stuff has not been 
> exersized yet.

The offending patch is 
hid-core.c: Adds all GTCO CalComp Digitizers and InterWrite School Products to blacklist

If one looks at this patch it seems to be just a typo. 
The patch below fixes at least the warning.

--- vanilla-2.6.18-rc6/drivers/usb/input/hid-core.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6/drivers/usb/input/hid-core.c	2006-09-04 23:53:10.000000000 +0200
@@ -1444,7 +1444,7 @@
 #define USB_DEVICE_ID_GTCO_402		0x0402
 #define USB_DEVICE_ID_GTCO_403		0x0403
 #define USB_DEVICE_ID_GTCO_404		0x0404
-#define USB_DEVICE_ID_GTCO_404		0x0405
+#define USB_DEVICE_ID_GTCO_405		0x0405
 #define USB_DEVICE_ID_GTCO_500		0x0500
 #define USB_DEVICE_ID_GTCO_501		0x0501
 #define USB_DEVICE_ID_GTCO_502		0x0502
@@ -1657,7 +1657,7 @@
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_402, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_403, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_404, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_405, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_500, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_501, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GTCO, USB_DEVICE_ID_GTCO_502, HID_QUIRK_IGNORE },
