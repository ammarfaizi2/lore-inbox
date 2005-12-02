Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVLBQDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVLBQDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVLBQDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:03:51 -0500
Received: from fmr19.intel.com ([134.134.136.18]:35285 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750804AbVLBQDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:03:50 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: 
Date: Sat, 3 Dec 2005 00:03:30 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC237@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-index: AcX3WfCEQ85g1SloRNmg7rS7Hlk2Fg==
From: "Yu, Luming" <luming.yu@intel.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       "Linus Torvalds" <torvalds@osdl.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Dec 2005 16:03:32.0328 (UTC) FILETIME=[F159EE80:01C5F759]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Subject: [git pull 02/14] Add Wistron driver
>
>Input: add Wistron driver
>
>A driver for laptop buttons using an x86 BIOS interface that is
>apparently used on quite a few laptops and seems to be originating
>from Wistron.
>
>This driver currently "knows" only about Fujitsu-Siemens Amilo 
>Pro V2000
>(i.e. it can detect the laptop using DMI and it contains the
>keycode->key meaning mapping for this laptop) and Xeron SonicPro X 155G
>(probably can't be reliably autodetected, requires a module parameter),
>adding other laptops should be easy.
>
>In addition to reporting button presses to the input layer the driver
>also allows enabling/disabling the embedded wireless NIC (using the
>"Wifi" button); this is done using the same BIOS interface, so it seems
>only logical to keep the implementation together.  Any flexibility
>possibly gained by allowing users to remap the function of the "Wifi"
>button is IMHO not worth it when weighted against the necessity to run
>an user-space daemon to convert button presses to wifi state changes.
>
>Signed-off-by: Miloslav Trmac <mitr@volny.cz>
>Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>---
>

I just tested module wistron_btn on  one Acer Aspire laptop after 
adding one dmi entry.  The wistron_btn found BIOS interfaces.
One visible error is the bluetooth light won't turn on upon 
stroking bluetooth button.
Without wistron_btn module, the bluetooth light works.
 with acpi enabled, I didn't try acpi disabled)

wistron_btn polls a cmos address to detect hotkey event.  It 
is not necessary, because there do have ACPI interrupt triggered upon 
hotkeys.  

So, my suggestion is to disable this module when ACPI enabled.
We need to implement hotkey support from ACPI subsystem for my
Acer aspire laptop.

--- linux-2.6.15-rc3/drivers/input/misc/Kconfig.0	2005-12-02
10:08:33.000000000 -0700
+++ linux-2.6.15-rc3/drivers/input/misc/Kconfig	2005-12-02
10:08:58.000000000 -0700
@@ -42,7 +42,7 @@
 
 config INPUT_WISTRON_BTNS
 	tristate "x86 Wistron laptop button interface"
-	depends on X86 && !X86_64
+	depends on X86 && !X86_64 && !ACPI
 	help
 	  Say Y here for support of Winstron laptop button interface,
used on
 	  laptops of various brands, including Acer and Fujitsu-Siemens.

