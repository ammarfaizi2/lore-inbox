Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266287AbUH0WiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbUH0WiI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUH0WhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:37:13 -0400
Received: from email-out1.iomega.com ([147.178.1.82]:52423 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S266287AbUH0WeB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:34:01 -0400
Subject: Re: [usb-storage] drivers/block/ub.c #6
From: Pat LaVarre <p.lavarre@ieee.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
In-Reply-To: <1093640531.8006.68.camel@patlinux.iomegacorp.com>
References: <20040730035120.30abd121@lembas.zaitcev.lan><1093640531.8006.68.
	camel@patlinux.iomegacorp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093645959.8006.219.camel@patlinux.iomegacorp.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Aug 2004 16:32:39 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Aug 2004 22:33:57.0371 (UTC) FILETIME=[F0EB54B0:01
	C48C85]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:18.26777 C:4 M:9 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Z:

> > Date: 30 Jul 2004 04:51:20 -0600
> > ...
> > I wish this could be somehow limited to flash keys,

How committed are we to the "Low Performance" part of the "Low
Performance USB Block driver" title for "config BLK_DEV_UB" found in
drivers/block/Kconfig?

Do we instead hope for ub.ko to simplify all "generic USB Mass Storage",
leaving only the vendor-specific work to usb-storage.ko?

I ask because I haven't yet learned how to reconcile two source files:

--- drivers/usb/storage/usb.c
...
static struct usb_device_id storage_usb_ids [] = {
...
#if !defined(CONFIG_BLK_DEV_UB) && !defined(CONFIG_BLK_DEV_UB_MODULE)
{ USB_INTERFACE_INFO(USB_CLASS_MASS_STORAGE, US_SC_SCSI, US_PR_BULK) },
#endif
...
--- C:/Windows/inf/usbstor.inf:
...
[Generic]
%GenericBulkOnly.DeviceDesc%=USBSTOR_BULK, USB\Class_08&SubClass_02&Prot_50
%GenericBulkOnly.DeviceDesc%=USBSTOR_BULK, USB\Class_08&SubClass_05&Prot_50
%GenericBulkOnly.DeviceDesc%=USBSTOR_BULK, USB\Class_08&SubClass_06&Prot_50
...
---

Looks to me like we have ub.ko taking over just x 08 06 50, rather than
all of the x 08 (06|05|02) 50 = bInterfaceClass ...SubClass ...Protocol
considered generic by MSFT?

http://www.microsoft.com/whdc/device/storage/usbfaq.mspx
agrees Flash should be x 08 06 50 but gives no clear guidance to the
rest of us.

I remember we invented x 08 06 50 to be the one tuple to rule them all,
to move the determination of PDT (peripheral device type) etc. back into
op x12 "INQUIRY" where it belongs, ...

Of course the world may yet contain advocates of connecting HDD/FDD as
bInterfaceSubClass = x05 "SFF 8070" = Compaq LS-120 or connecting DVD/CD
as x02 "SFF 8020" = read-only CD.

Pat LaVarre
http://linux-pel.blog-city.com/read/790489.htm

