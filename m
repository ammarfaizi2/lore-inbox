Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264165AbRFDJcb>; Mon, 4 Jun 2001 05:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264166AbRFDJcV>; Mon, 4 Jun 2001 05:32:21 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:48256 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264165AbRFDJcM>;
	Mon, 4 Jun 2001 05:32:12 -0400
Date: Mon, 4 Jun 2001 11:31:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Robert M. Love" <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mouse wheel breakage was Re: Linux 2.4.5-ac5
Message-ID: <20010604113107.C304@suse.cz>
In-Reply-To: <20010601105717.A2468@debian> <991399435.4435.0.camel@phantasy> <991431152.653.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <991431152.653.0.camel@phantasy>; from rml@tech9.net on Fri, Jun 01, 2001 at 05:32:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2001 at 05:32:26PM -0400, Robert M. Love wrote:
> USB mouse wheel has been broke since 2.4.5-ac4 (when new USB HID,
> hid-core.c, was integrated).  The mouse in general seems jerky, and
> specifically the input device does not receive events for consecutive
> wheel movements -- just the first "spin," until the mouse is moved
> again.
> 
> obviously the bug is in the new hid-core.c, but I confirmed this by
> compiling with that part of the ac6 patch removed.  I have since been
> trying to write a patch but I can not fix the problem, so I am reporting
> it to you.
> 
> I and another user thought the problem was in hid_input_field, but upon
> looking I now think not.
> 
> My mouse is fairly unusable in X, and unfortunately I can not figure out
> a fix.

It is a quite stupid bug. Here is the fix (already sent to Alan).

-- 
Vojtech Pavlik
SuSE Labs

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hid.fix.diff"

diff -urN linux-2.4.5-ac4/drivers/usb/hid-core.c linux/drivers/usb/hid-core.c
--- linux-2.4.5-ac4/drivers/usb/hid-core.c	Tue May 29 19:48:15 2001
+++ linux/drivers/usb/hid-core.c	Fri Jun  1 16:30:33 2001
@@ -775,7 +775,7 @@
 
 			if ((field->flags & HID_MAIN_ITEM_RELATIVE) && !value[n])
 				continue;
-			if (value[n] == field->value[n])
+			if ((~field->flags & HID_MAIN_ITEM_RELATIVE) && value[n] == field->value[n])
 				continue;
 			hid_process_event(hid, field, &field->usage[n], value[n]);
 			continue;

--UugvWAfsgieZRqgk--
