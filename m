Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267049AbUBEXPB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267047AbUBEXOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:14:30 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:12750 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267031AbUBEXMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:12:35 -0500
Date: Fri, 6 Feb 2004 00:12:27 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>, "Zephaniah E. Hull" <warp@mercury.d2dc.net>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz, gregkh@us.ibm.com
Subject: [patch] 2.6.2-mm1: fix warning introduced by input-2wheel-mouse-fix
Message-ID: <20040205231226.GC26093@fs.tum.de>
References: <20040205014405.5a2cf529.akpm@osdl.org> <1076003898.12450.15.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076003898.12450.15.camel@cherrytest.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 09:58:18AM -0800, John Cherry wrote:
>...
> The nit warnings that sprung up in the defconfig builds are...
>...
> drivers/usb/input/hid-input.c: In function `hidinput_hid_event':
> drivers/usb/input/hid-input.c:436: warning: suggest parentheses around
> && within ||
>...

This one's easy to fix:

--- linux-2.6.2-mm1/drivers/usb/input/hid-input.c.old	2004-02-06 00:05:19.000000000 +0100
+++ linux-2.6.2-mm1/drivers/usb/input/hid-input.c	2004-02-06 00:05:50.000000000 +0100
@@ -433,7 +433,7 @@
 	input_regs(input, regs);
 
 	if (((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA) && (usage->code == BTN_EXTRA))
-		|| (hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_BACK) && (usage->code == BTN_BACK)) {
+		|| ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_BACK) && (usage->code == BTN_BACK))) {
 		if (value)
 			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
 		else


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

