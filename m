Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVBBUTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVBBUTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVBBUKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:10:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:31876 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262581AbVBBTqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:46:39 -0500
Subject: [PATCH 3/4] Ignore non-LED events in hid-input hidinput_event().
In-Reply-To: <1107373613347@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 2 Feb 2005 20:46:54 +0100
Message-Id: <11073736133786@twilight.ucw.cz>
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
--- a/drivers/usb/input/hid-input.c	2005-02-02 20:29:40 +01:00
+++ b/drivers/usb/input/hid-input.c	2005-02-02 20:29:40 +01:00
@@ -492,6 +492,9 @@
 	if (type == EV_FF)
 		return hid_ff_event(hid, dev, type, code, value);
 
+	if (type != EV_LED)
+		return -1;
+
 	if ((offset = hid_find_field(hid, type, code, &field)) == -1) {
 		warn("event field not found");
 		return -1;

