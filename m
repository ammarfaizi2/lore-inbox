Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVAJUw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVAJUw2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVAJUwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:52:08 -0500
Received: from mail108.messagelabs.com ([216.82.255.115]:52871 "HELO
	mail108.messagelabs.com") by vger.kernel.org with SMTP
	id S262471AbVAJUuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:50:06 -0500
X-VirusChecked: Checked
X-Env-Sender: AAnthony@sbs.com
X-Msg-Ref: server-11.tower-108.messagelabs.com!1105390203!0!1
X-StarScan-Version: 5.4.5; banners=sbs.com,-,-
X-Originating-IP: [204.255.71.6]
Message-ID: <4F23E557A0317D45864097982DE907941A33AD@pilotmail.sbscorp.sbs.com>
From: Adam Anthony <AAnthony@sbs.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Alexey Dobriyan <adobriyan@mail.ru>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: RE: [PATCH] /driver/net/wan/sbs520
Date: Mon, 10 Jan 2005 13:49:55 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The SBS Communications group structured their software this way
(w/useless wrappers) to make files portable from one operating system to
another.  Now that this package will be taking a life of its own, the change
you propose makes perfect sense.
Thanks,
Adam

-----Original Message-----
From: Francois Romieu [mailto:romieu@fr.zoreil.com] 
Sent: Monday, January 10, 2005 3:30 PM
To: Adam Anthony
Cc: Matthias-Christian Ott; Alexey Dobriyan; netdev@oss.sgi.com;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /driver/net/wan/sbs520

o OsMapPhysToVirt
  -> should be ioremap/pci_iomap()

o OsUnMapVirt
  -> iounmap, etc.

o OsAllocateNonPagedMemory/OsMemcpy/OsStall/OsSleep/OsZeroMem
  -> useless wrappers.

o OsAllocateDeviceMemory
  Yuck, virt_to_bus !
  Please read:
  - linux-2.6.x/Documentation/DMA-mapping.txt
  - linux-2.6.x/Documentation/DMA-API.txt
  drivers/net/*.c provides a lot of good examples for recent PCI
  devices.

o OsReadPciConfiguration
  Please see pci_resource_{start/len} and friends.

At this point, lnxosl.c will be removable and nobody will regret it.

--
Ueimor

For limitations on the use and distribution of this message, please visit www.sbs.com/emaildisclaimer.
