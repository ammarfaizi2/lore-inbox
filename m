Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVJBI5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVJBI5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 04:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVJBI5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 04:57:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:39059 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751023AbVJBI5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 04:57:44 -0400
Subject: Re: Opterons and setting the pci bus master bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Mark Hounschell <markh@compro.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0509301318370.31041@chaos.analogic.com>
References: <433D71A0.1040104@compro.net>
	 <Pine.LNX.4.61.0509301318370.31041@chaos.analogic.com>
Content-Type: text/plain
Date: Sun, 02 Oct 2005 18:54:54 +1000
Message-Id: <1128243294.8267.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 13:32 -0400, linux-os (Dick Johnson) wrote:
>     pci_set_dma_mask(dev, 0xffffffffULL);    // 32 bit DMA only
>     pci_set_drvdata(dev, NULL);              // Harmless if unused
>     pci_set_power_state(dev, 0);             // Turn it ON
>     pci_set_master(dev);                     // Make bus-master
>     pci_set_mwi(dev);   // Check return, different code
>     pci_write_config_dword(dev, PCI_COMMAND, PCI_CONFIG_YOU_DEFINE);
> 
>    Typical bus-master PCI_CONFIG_YOU_DEFINE is:
>      (PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER|PCI_COMMAND_SERR)

Actually the last one is slightly bogus for things like
memory/master/etc... you shouldn't bother about these if you do things
correctly and call ... pci_enable_device() which you forgot :)

Ben.


