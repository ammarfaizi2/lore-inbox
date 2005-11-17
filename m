Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVKQV2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVKQV2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVKQV2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:28:45 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:56265 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751265AbVKQV2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:28:45 -0500
Date: Thu, 17 Nov 2005 22:28:42 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       torvalds@osdl.org
Subject: Re: USB key generates ioctl_internal_command errors
Message-ID: <20051117212842.GA8110@hardeman.nu>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
	torvalds@osdl.org
References: <mailman.1132184643.7273.linux-kernel2news@redhat.com> <20051116183424.5f1ebeac.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051116183424.5f1ebeac.zaitcev@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

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
problem. It's trivial so I hope It'll find it's way into the kernel 
soon.

Re,
David Härdeman

Signed-off-by: David Härdeman <david@2gen.com>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename="usb-iomega-umini-is-unusual.patch"
Content-Transfer-Encoding: 8bit

--- linux-2.6.14.2/drivers/usb/storage/unusual_devs.h.orig	2005-11-11 06:33:12.000000000 +0100
+++ linux-2.6.14.2/drivers/usb/storage/unusual_devs.h	2005-11-17 22:10:47.000000000 +0100
@@ -1086,6 +1086,15 @@
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

--4Ckj6UjgE2iN1+kY--
