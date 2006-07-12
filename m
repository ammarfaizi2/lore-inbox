Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWGLRF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWGLRF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWGLRF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:05:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:61137 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751466AbWGLRF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:05:27 -0400
Message-ID: <44B52BD2.2030004@pobox.com>
Date: Wed, 12 Jul 2006 13:05:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix Jmicron support
References: <1152713141.22943.67.camel@localhost.localdomain>
In-Reply-To: <1152713141.22943.67.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Prior to 2.6.18rc1 you could install with devices on a JMicron chipset
> using the "all-generic-ide" option. As of this kernel the AHCI driver
> grabs the controller and rams it into AHCI mode losing the PATA ports
> and making CD drives and the like vanish. The all-generic-ide option
> fails because the AHCI driver grabbed the PCI device and reconfigured
> it.
> 
> To fix this three things are needed.
> 
> #1 We must put the chip into dual function mode
> #2 The AHCI driver must grab only function 0 (already in your rc1 tree)
> #3 Something must grab the PATA ports
> 
> The attached patch is the minimal risk edition of this. It puts the chip
> into dual function mode so that AHCI will grab the SATA ports without
> losing the PATA ports. To keep the risk as low as possible the third
> patch adds the PCI identifiers for the PATA port and the FN check to the
> ide-generic driver. There is a more featured jmicron driver on its way
> but that adds risk and the ide-generic support is sufficient to install
> and run a system.
> 
> The actual chip setup done by the quirk is the precise setup recommended
> by the vendor.
> 
> (The JMB368 appears only in the ide-generic entry as it has no AHCI so
> does not need the quirk)
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

ACK for 2.6.18-rc1-git

The AHCI bits are already in 2.6.18-rc1.  The drivers/ide new-PCI-ID 
bits are arguably new features, but IMO obviously quite harmless.

	Jeff


