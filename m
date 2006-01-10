Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWAJFyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWAJFyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 00:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWAJFyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 00:54:53 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:32353 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750862AbWAJFyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 00:54:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick Read <pread99999@gmail.com>
Subject: Re: PROBLEM: Oops in Kernel 2.6.15 usbhid
Date: Tue, 10 Jan 2006 00:54:50 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <25ac9de40601052225i48bca97dx3ad796a1cd68f1c3@mail.gmail.com>
In-Reply-To: <25ac9de40601052225i48bca97dx3ad796a1cd68f1c3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100054.51198.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 01:25, Patrick Read wrote:
> [1.] Oops in Kernel 2.6.15 usbhid
> 
> [2.] Compiled 2.6.15 downloaded from kernel.org.  Configured, made,
> and installed.  During reboot, I get an Oops in the USB HID module. 
> This does not occur with a nearly-identical config on the same
> computer with kernel 2.6.14.5.
> 
> [3.] USB, HID, kernel, 2.6.15, module
> 

Could you please try the patch below? Thanks!

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/pid.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/usb/input/pid.c
===================================================================
--- work.orig/drivers/usb/input/pid.c
+++ work/drivers/usb/input/pid.c
@@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct 
 int hid_pid_init(struct hid_device *hid)
 {
 	struct hid_ff_pid *private;
-	struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 
 	private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
