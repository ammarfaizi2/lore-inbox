Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271227AbTG2CgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271228AbTG2CgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:36:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:16612 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271227AbTG2CgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:36:22 -0400
Date: Mon, 28 Jul 2003 19:36:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1: Can't mount root
Message-Id: <20030728193633.1b2bc9d8.akpm@osdl.org>
In-Reply-To: <1059444271.4786.25.camel@localhost>
References: <1059428584.6146.9.camel@localhost>
	<20030728144704.49c433bc.akpm@osdl.org>
	<1059430015.6146.15.camel@localhost>
	<20030728150245.42f57f89.akpm@osdl.org>
	<1059444271.4786.25.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn <core@enodev.com> wrote:
>
> OK, mucho more info (no wonder root=/dev/hde5 no worky):
>         VP_IDE: (ide_setup_pci_device:) Could not enable device
> 
> Found out my on board via pci ide was not getting initialized under
> -test2-mm1, so I went looking for driver/ide/pci/via82cxxx in the diffs.
> I found this in the -test2 diff:
> -                                    (((u >> i) & 7) < 8))) {
> +                                    (((u >> i) & 7) < 6))) {
> ...and reversing it did not change anything.
> 
> The only other diff I could think might matter to 
> drivers/ide/setup-pci.c
> -static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
> +static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
> ...which does not look like it should kill my via ide...
> 

OK, looks like breakage at the PCI level: pci_enable_device_bars() is
failing; something below pcibios_enable_device().

What was the most recent kernel which works?
