Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVE1AfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVE1AfF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 20:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbVE1AfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 20:35:05 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:63903 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262635AbVE1AfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 20:35:00 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: PCI: How to find if BIOS has already enabled the device
Date: Fri, 27 May 2005 20:35:03 -0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505272035.03800.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to trace the root cause of an annoying problem with a USB Storage 
device - 

My laptop's BIOS supports booting from USB devices. I have attached an 
external USB HDD to a USB 2.0 port. If I boot Linux with the HDD attached and 
powered on, load of OHCI-HCD module hangs the machine for around 2 minutes - 
after that it recovers and all is fine. I have tried different distros 
without luck, but while installing debian, I figured out that the hang 
happens after ohci-hcd calls pci_enable_device() for the USB controller.

This does not happen when the boot is complete. I.e. if I attach the HDD after 
boot is complete (BIOS did not get a chance to enable it beforehand) load of 
ohci-hcd (during and after boot) does not hang the machine.

I think since the machine supports booting from USB HDD, the BIOS must be 
enabling the USB controller and attached device early during boot, and when 
ohci-hcd tries to re-enable it, it doesn't like it and leads to a hang. 

My question - Is it possible to detect if the USB controller is already 
enabled and skip enabling it second time?

Thanks

Parag
