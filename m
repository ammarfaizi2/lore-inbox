Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277722AbRJLPEL>; Fri, 12 Oct 2001 11:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277728AbRJLPDv>; Fri, 12 Oct 2001 11:03:51 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:37385 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S277722AbRJLPDl>;
	Fri, 12 Oct 2001 11:03:41 -0400
Date: Fri, 12 Oct 2001 17:04:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PCI device search.
Message-ID: <20011012170411.A21169@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a device driver (drivers/char/sonypi in this case)
which can handle two cases:
	- on older hardware, it gets attached to a specific 
	  PCI device

	- on newer hardware, when the previous PCI device
	  is missing, it just uses a predefined set of
	  ioports to access the hardware. There is no PCI
	  device involved here.

I am wondering what is the cleanest way to program this. 
As I see it, I have two distinct choices:

	1. Create a PCI driver (pci_device_id, struct pci_driver etc)
	and in init_module call pci_module_init. If it fails,
	assume the driver deals with newer hardware and 
	call 'by hand' the 'probe' routine from pci_driver struct.

	2. Not use the PCI driver infrastructure, and in
	init_module just call pci_find_device manually searching
	for older hardware, if it is present go further, if
	it fails assume newer hardware and go further.

What is considered to be the best way to do it ?
(this is _not_ a hotplug device if it matters).

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
