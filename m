Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVAJUkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVAJUkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVAJUhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:37:54 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36287 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262472AbVAJUdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:33:24 -0500
Date: Mon, 10 Jan 2005 21:29:47 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Adam Anthony <AAnthony@sbs.com>
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Alexey Dobriyan <adobriyan@mail.ru>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /driver/net/wan/sbs520
Message-ID: <20050110202947.GA31426@electric-eye.fr.zoreil.com>
References: <4F23E557A0317D45864097982DE907941A3383@pilotmail.sbscorp.sbs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F23E557A0317D45864097982DE907941A3383@pilotmail.sbscorp.sbs.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Anthony <AAnthony@sbs.com> :
> Thank you for the heads up A&M.  I have destroyed the evil [^M]'s, and
> updated the package.
> http://prdownloads.sourceforge.net/sbs520lnxdrv/sbs520patch.bz2?download

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
