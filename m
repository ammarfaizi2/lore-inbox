Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422806AbWA1CZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWA1CZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWA1CWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:44986 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422805AbWA1CWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:38 -0500
Date: Fri, 27 Jan 2006 18:20:46 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       dtor@mail.ru
Subject: [patch 03/12] Input: HID - fix an oops in PID initialization code
Message-ID: <20060128022046.GD17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="input-hid-fix-an-oops-in-pid-initialization-code.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Dmitry Torokhov <dtor_core@ameritech.net>

Input: HID - fix an oops in PID initialization code

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/input/pid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.1.orig/drivers/usb/input/pid.c
+++ linux-2.6.15.1/drivers/usb/input/pid.c
@@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct 
 int hid_pid_init(struct hid_device *hid)
 {
 	struct hid_ff_pid *private;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 
 	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);

--
