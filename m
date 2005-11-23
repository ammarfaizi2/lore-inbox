Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVKWXqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVKWXqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVKWXqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:46:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:19650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750816AbVKWXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:30 -0500
Date: Wed, 23 Nov 2005 15:45:49 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       david@2gen.com
Subject: [patch 20/22] USB: fix USB key generates ioctl_internal_command errors issue
Message-ID: <20051123234549.GU527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline; filename="usb-fix-usb-key-generates-ioctl_internal_command-errors-issue.patch"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Härdeman <david@2gen.com>

On Wed, Nov 16, 2005 at 06:34:24PM -0800, Pete Zaitcev wrote:
>On Wed, 16 Nov 2005 23:52:32 +0100, David Härdeman <david@2gen.com> wrote:
>> usb-storage: waiting for device to settle before scanning
>>   Vendor: I0MEGA    Model: UMni1GB*IOM2K4    Rev: 1.01
>>   Type:   Direct-Access                      ANSI SCSI revision: 02
>> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
>> sda: Write Protect is off
>> sda: Mode Sense: 00 00 00 00
>> sda: assuming drive cache: write through
>> ioctl_internal_command: <8 0 0 0> return code = 8000002
>>    : Current: sense key=0x0
>>     ASC=0x0 ASCQ=0x0
>> SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
>
>I think it's harmless. I saw things like that, and initially I plugged
>them with workarounds like this:

Thanks for the pointer, and yes, it is harmless, but it floods the
console with the messages which hides other (potentially important)
messages...following your example I've made a patch which fixes the
problem.

Signed-off-by: David Härdeman <david@2gen.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/storage/unusual_devs.h |    9 +++++++++
 1 file changed, 9 insertions(+)

--- usb-2.6.orig/drivers/usb/storage/unusual_devs.h
+++ usb-2.6/drivers/usb/storage/unusual_devs.h
@@ -1118,6 +1118,15 @@ UNUSUAL_DEV(  0x2735, 0x100b, 0x0000, 0x
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_GO_SLOW ),
 
+/*
+ * David Härdeman <david@2gen.com>
+ * The key makes the SCSI stack print confusing (but harmless) messages
+ */
+UNUSUAL_DEV(  0x4146, 0xba01, 0x0100, 0x0100,
+		"Iomega",
+		"Micro Mini 1GB",
+		US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
+
 #ifdef CONFIG_USB_STORAGE_SDDR55
 UNUSUAL_DEV(  0x55aa, 0xa103, 0x0000, 0x9999, 
 		"Sandisk",

--
