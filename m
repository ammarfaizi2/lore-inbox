Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUCPOYH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbUCPOYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:24:04 -0500
Received: from styx.suse.cz ([82.208.2.94]:4482 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261961AbUCPOTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:50 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467783749@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 39/44] Fix an endless loop in hid-core.c if device has empty reports
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <1079446778376@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.13, 2004-03-10 09:02:48+01:00, davidm@hpl.hp.com
  input: Avoid an endless loop in hid-core.c, if a device has some
         empty reports.


 hid-input.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	Tue Mar 16 13:17:41 2004
+++ b/drivers/usb/input/hid-input.c	Tue Mar 16 13:17:41 2004
@@ -569,8 +569,10 @@
 		while (list != &report_enum->report_list) {
 			report = (struct hid_report *) list;
 
-			if (!report->maxfield)
+			if (!report->maxfield) {
+				list = list->next;
 				continue;
+			}
 
 			if (!hidinput) {
 				hidinput = kmalloc(sizeof(*hidinput), GFP_KERNEL);

