Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVA2TOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVA2TOw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVA2TMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:12:48 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:64462 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261542AbVA2TIP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:15 -0500
Subject: [PATCH 3/3] Fix 'event field not found' message filling logs
In-Reply-To: <11070171283097@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 29 Jan 2005 17:45:28 +0100
Message-Id: <1107017128578@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1977.1.3, 2005-01-29 13:09:24+01:00, vojtech@silver.ucw.cz
  input: Ignore non-LED events in hid-input hidinput_event(). This gets rid
         of the "event field not found" message caused by EV_MSC type events.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-input.c |    3 +++
 1 files changed, 3 insertions(+)

===================================================================

diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2005-01-29 17:37:11 +01:00
+++ b/drivers/usb/input/hid-input.c	2005-01-29 17:37:11 +01:00
@@ -492,6 +492,9 @@
 	if (type == EV_FF)
 		return hid_ff_event(hid, dev, type, code, value);
 
+	if (type != EV_LED)
+		return -1;
+
 	if ((offset = hid_find_field(hid, type, code, &field)) == -1) {
 		warn("event field not found");
 		return -1;

