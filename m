Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVFROSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVFROSt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVFROSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:18:49 -0400
Received: from [62.101.100.8] ([62.101.100.8]:33342 "EHLO smtpout1.reply.it")
	by vger.kernel.org with ESMTP id S262122AbVFROSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:18:46 -0400
From: "Daniele Gaffuri" <d.gaffuri@reply.it>
To: "'Greg KH'" <gregkh@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Hidden SMBus bridge on Toshiba Tecra M2
Date: Sat, 18 Jun 2005 16:18:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050617224953.GA23742@suse.de>
Thread-Index: AcVzjue2+h0HmgCtRZGpOdyj1XPDhwAgaTSw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Message-ID: <TO1FRES03vZXqimrMh000004695@to1fres03.replynet.prv>
X-OriginalArrivalTime: 18 Jun 2005 14:18:45.0234 (UTC) FILETIME=[A2F74520:01C57410]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Jun 18, 2005 at 12:36:18AM +0200, Daniele Gaffuri wrote:
>> Here's a trivial patch, against 2.6.12-rc6, to unhide SMBus on
>> Toshiba Centrino laptops using Intel 82855PM chipset.
> 
> Your patch is linewrapped, and missing a Signed-off-by: line.  Care to
> redo it?
> 
> thanks,
> 
> greg k-h

Please, excuse me if you can, the second one was exactly like the first.
This should be OK, in the meanwhile I've redone with 2.6.12.

Patch against 2.6.12 to unhide SMBus on Toshiba Centrino laptops using Intel 82855PM chipset.
Tested on Toshiba Tecra M2.

Signed-off-by: Daniele Gaffuri <d.gaffuri@reply.it>

--- linux-2.6.12/drivers/pci/quirks.c.orig	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/drivers/pci/quirks.c	2005-06-18 15:03:49.000000000 +0200
@@ -819,6 +819,11 @@ static void __init asus_hides_smbus_host
 			case 0x0001: /* Toshiba Satellite A40 */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device == PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0001: /* Toshiba Tecra M2 */
+				asus_hides_smbus = 1;
+			}
        } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG)) {
                if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch(dev->subsystem_device) {

