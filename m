Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUHBR3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUHBR3T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 13:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUHBR3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 13:29:19 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:1427 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266666AbUHBR3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 13:29:17 -0400
Message-ID: <20040802172916.76436.qmail@web14929.mail.yahoo.com>
Date: Mon, 2 Aug 2004 10:29:16 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <200408021002.31117.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> look, Greg?  It it suitable for the mainline yet?  I expect those
> familiar  with the various cards to add the necessary quirks code
> as needed.

Radeons need this quirk for broken VBIOS's that leave the ROM decoding
disabled.

   unsigned int temp;
   temp = DRM_READ32(mmio, RADEON_MPP_TB_CONFIG);
   temp &= 0x00ffffffu;
   temp |= 0x04 << 24;
   DRM_WRITE32(mmio, RADEON_MPP_TB_CONFIG, temp);
   temp = DRM_READ32(mmio, RADEON_MPP_TB_CONFIG);

Shouldn't this go into the radeon driver so that it will work with
hotplug? Or should it go in both places, a _devinit pci_quirk and the
radeon driver?


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
