Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVB1UXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVB1UXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVB1UXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:23:46 -0500
Received: from isilmar.linta.de ([213.239.214.66]:56242 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261739AbVB1UW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:22:27 -0500
Date: Mon, 28 Feb 2005 21:22:26 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 - pcmcia weirdness/breakage
Message-ID: <20050228202226.GA16284@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200502281948.j1SJmKdV006528@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502281948.j1SJmKdV006528@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 02:48:20PM -0500, Valdis.Kletnieks@vt.edu wrote:
> Symptoms:  Running '/etc/init.d/pcmcia start' bombs - cardmgr goes into
> a loop spewing repeated 'Common memory region at 0x0: Generic or SRAM'
> messages.  In the dmesg, we find:
> 
> [4294764.989000]  <6>cs: IO port probe 0xc00-0xcff: clean.
> [4294859.195000] cs: IO port probe 0xc00-0xcff: clean.
> [4294859.195000] cs: IO port probe 0xc00-0xcff: clean.
> [4294859.199000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x37f
> [4294859.202000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x37f
> [4294859.205000] cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x37f
> [4294859.207000] cs: IO port probe 0xa00-0xaff: clean.
> [4294859.208000] cs: IO port probe 0xa00-0xaff: clean.
> [4294859.209000] cs: IO port probe 0xa00-0xaff: clean.
> [4294859.369000] cs: unable to map card memory!
> [4294859.369000] cs: unable to map card memory!
> 
> Now the odd part:
> 
> 2.6.11-rc4 works, doesn't show the last 2 'unable to map' messages.
> 2.6.11-rc4 + linus.patch from -rc4-mm1 works as well - so it's a -mm patch doing it.
> 
> A full -rc4-mm1 fails, *as does* a -rc4-mm1 with all the following patches -R'ed:
> 
> broken-out/fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
> broken-out/pcmcia-add-pcmcia-devices-autonomously.patch
> broken-out/pcmcia-bridge-resource-management-fix.patch
> broken-out/pcmcia-determine-some-useful-information-about-devices.patch
> broken-out/pcmcia-mark-resource-setup-as-done.patch
> broken-out/pcmcia-pcmcia_device_add.patch
> broken-out/pcmcia-pcmcia_device_probe.patch
> broken-out/pcmcia-pcmcia_device_remove.patch
> broken-out/pcmcia-pd6729-convert-to-pci_register_driver.patch
> broken-out/pcmcia-per-device-sysfs-output.patch
> broken-out/pcmcia-rsrc_nonstatic-sysfs-input.patch
> broken-out/pcmcia-rsrc_nonstatic-sysfs-output.patch
> broken-out/pcmcia-update-vrc4171_card.patch
> broken-out/pcmcia-use-bus_rescan_devices.patch
> broken-out/pcmcia-yenta_socket-ti4150-support.patch
> 
> So the breakage is in *some other* -rc4-mm1 patch.  Any hints to speed up
> the binary search?

Most likely it's
pcmcia-bridge-resource-management-fix.patch

	Dominik
