Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUHNMRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUHNMRC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUHNMQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:16:56 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50345 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S268687AbUHNMQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:16:14 -0400
Date: Sat, 14 Aug 2004 14:15:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange network performance degradation 2.6.8-rc3-mm1 -> 2.6.8-rc4-mm1
Message-ID: <20040814121533.GB18754@electric-eye.fr.zoreil.com>
References: <20040814060948.GA7842@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814060948.GA7842@middle.of.nowhere>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan <thunder7@xs4all.nl> :
[8139too does not work after switch from 2.6.8-rc3-mm1 to 2.6.8-rc4-mm1]
> The dmesg-output between 2.6.8-rc3-mm1 and 2.6.8-rc4-mm1 differs like
> this:
[...]
> < ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 23 (level, low) -> IRQ 23
> ---
> > ** PCI interrupts are no longer routed automatically.  If this
> > ** causes a device to stop working, it is probably because the
> > ** driver failed to call pci_enable_device().  As a temporary
> > ** workaround, the "pci=routeirq" argument restores the old
> > ** behavior.  If this argument makes the device work again,
> > ** please email the output of "lspci" to bjorn.helgaas@hp.com
> > ** so I can fix the driver.
[...]
> This behaviour happens both with /proc/sys/net/ipv4/tcp_window_scaling
> set to 0 or 1 (setting it to 0 or 1 doesn't matter with 2.6.8-rc3-mm1).
> 
> What could be the problem here?

The transition from 2.6.8-rc3-mm1 to 2.6.8-rc4-mm1 changes both the
point outlined above and the 8139too driver.

You may:
1 - try the "pci=routeirq" argument at startup on your 2.6.8-rc4-mm1 if you
    have not done so;
2 - apply to your 2.6.8-rc4-mm1 tree:
    http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-mm-revert.patch
3 - apply to your 2.6.8-rc4-mm1 tree:
    http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-mm-revert.patch
    http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-10.patch
    http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.8-rc4-mm1/8139too-20.patch

Feedback on points 1, 2 and 3 will be welcome.

Please add netdev@oss.sgi.com to the Cc: list as it is probably/almost
surely related to the driver itself.

--
Ueimor
