Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUION1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUION1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUION1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:27:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:50881 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266034AbUION1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:27:37 -0400
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Evan Paul Fletcher <evanpaul@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091416416b9ae310@mail.gmail.com>
References: <200409131651.05059.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409140026430.15167@skynet>
	 <200409140845.59389.bjorn.helgaas@hp.com>
	 <Pine.LNX.4.58.0409150008130.23838@skynet>
	 <9e47339104091416416b9ae310@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095250966.19930.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 15 Sep 2004 13:22:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-15 at 00:41, Jon Smirl wrote:
> pci_enable/disable_device are correct in the dyn-minor patch. They
> also appear to correct in the currently checked in DRM cvs. If fbdev
> is loaded DRM does not do pci_enable/disable_device. It is assumed
> that these calls are handled by the fbdev device.

If you are calling pci_disable_device at all in the fb driver or DRI
driver it is wrong, always wrong, always will be wrong for the main
head. The video device is almost unique in that when you unload all
the video drivers vgacon still owns and is using it. On some devices
that needs PCI master enabled because of internal magic (like 
rendering text modes from the bios via SMM traps)

Alan

