Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbRFBWH0>; Sat, 2 Jun 2001 18:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbRFBWHQ>; Sat, 2 Jun 2001 18:07:16 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:24590 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S261806AbRFBWHG>; Sat, 2 Jun 2001 18:07:06 -0400
Subject: [PATCH] 2.4.5-ac6: hid-core.c Mouse Wheel Fix
From: Robert "M." Love <rml@tech9.net>
To: vojtech@suse.cz.laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-36teO5XABZUHvdAqbHQK"
X-Mailer: Evolution/0.10 (Preview Release)
Date: 02 Jun 2001 18:07:02 -0400
Message-Id: <991519623.771.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-36teO5XABZUHvdAqbHQK
Content-Type: text/plain

since the merging of the new USB HID code (hid.c -> hid-core.c) in ac4,
the mouse wheel has been broken (losing events).

this patch, by Micheal <leahcim@ntlworld.com>, fixes the problem.

Alan, please consider applying to the next -ac release.

thanks,

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

--=-36teO5XABZUHvdAqbHQK
Content-ID: 991519500.681.1.camel@phantasy
Content-Description: 
Content-Type: text/plain
Content-Disposition: inline; filename=patch-2.4.5ac6-rml-USB-mouse-wheel-fix.txt
Content-Transfer-Encoding: 7bit

--- linux.vanilla/drivers/usb/hid-core.c	Sat Jun  2 21:47:35 2001
+++ linux/drivers/usb/hid-core.c	Sat Jun  2 21:46:00 2001
@@ -773,10 +773,11 @@

		if (HID_MAIN_ITEM_VARIABLE & field->flags) {

-			if ((field->flags & HID_MAIN_ITEM_RELATIVE) && !value[n])
-				continue;
-			if (value[n] == field->value[n])
-				continue;
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				if (!value[n]) continue;
+			} else {
+			if (value[n] == field->value[n]) continue;
+			}	
			hid_process_event(hid, field, &field->usage[n], value[n]);
			continue;
		}

--=-36teO5XABZUHvdAqbHQK--

