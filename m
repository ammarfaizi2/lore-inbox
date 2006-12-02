Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422910AbWLBLUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbWLBLUV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWLBLUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:20:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23224 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422910AbWLBLUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:20:19 -0500
Date: Sat, 2 Dec 2006 11:27:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI: switch pci_{enable,disable}_device() to be nestable
Message-ID: <20061202112729.4fb43dbf@localhost.localdomain>
In-Reply-To: <200612020059.kB20xwaL004140@hera.kernel.org>
References: <200612020059.kB20xwaL004140@hera.kernel.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     However, because the order at which those drivers load cannot be known
>     ahead of time, the sequence in which the calls to pci_enable_device()
>     and pci_disable_device() cannot be predicted. Thus:
>     
>     1. driverA     starts     pci_enable_device()
>     2. driverB     starts     pci_enable_device()
>     3. driverA     shutdown   pci_disable_device()
>     4. driverB     shutdown   pci_disable_device()
>     
>     between steps 3 and 4, driver B would loose access to it's device,
>     even if it didn't intend to.

This is insufficient for some cases. Someone needs to set the enabled
value to one for unclaimed devices which are found to be enabled at boot
time (IO/MEM set) otherwise the stacking will fail on things like a
CS5520 where the firmware has set it enabled and if you disable it your
system dies on the spot.

Otherwise this looks most welcome.

Alan
