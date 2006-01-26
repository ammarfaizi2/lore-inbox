Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964933AbWAZWR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWAZWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWAZWR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:17:56 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:5380 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S964926AbWAZWRz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:17:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: USB host pci-quirks
Date: Thu, 26 Jan 2006 14:17:53 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C3AA3641@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB host pci-quirks
Thread-Index: AcYiaGIx2ODV0o78SSyoNnDIU6/jqAAXSVIQ
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Oskar Senft" <osk-lkml@sirrix.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jan 2006 22:17:55.0209 (UTC) FILETIME=[5AFDCF90:01C622C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Oskar Senft
>Sent: Thursday, January 26, 2006 3:03 AM
>To: linux-kernel@vger.kernel.org
>Subject: USB host pci-quirks
>
>Hi all!
>
>I'm currently working with Linux in a hardware virtualization
>environment (L4 microkernel). During tests, we discovered, 
>that there is
>some incosistency in the kernel configuration dependencies:
>
>the file "drivers/usb/host/pci-quirks.c" is added to the kernel as soon
>as PCI support is activated, even if USB support is completely 
>disabled.
>
>We discovered this issue while trying to run multiple Linux instances
>simultaneously.
>
>Is there a special need, that the "drivers/usb/host/pci-quirks.c" is
>compiled into the kernel even if USB support is disabled?

  Yes, there is. USB handoff is necessary even if USB support is
disabled completely in kernel. In fact, initially early usb handoff code
was under pci, but since USB drivers do handoff anyway, it was decided
to move everything into usb with a goal of merging them together. 
  Just search for USB handoff in kernel archives.

Thanks,
Aleks.

>
>I suggest the attached patch to resolve that problem. The file then is
>only included if PCI and USB support is enabled.
>
>Best regards,
>Oskar.

