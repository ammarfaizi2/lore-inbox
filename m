Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUIGKwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUIGKwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267841AbUIGKwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:52:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:58788 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267839AbUIGKwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:52:38 -0400
Subject: Re: [PATCH] missing pci_disable_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: greg@kroah.com, akpm@osdl.org, bjorn.helgaas@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <413D0E4E.1000200@jp.fujitsu.com>
References: <413D0E4E.1000200@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094550581.9150.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 10:49:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 02:26, Kenji Kaneshige wrote:
> Hi,
> 
> As mentioned in Documentaion/pci.txt, pci device driver should call
> pci_disable_device() to deallocate any IRQ resources, disable PCI
> bus-mastering and etc. when it decides to stop using the device.
> But there seems to be many drivers that don't use pci_disable_device()
> properly so far.

Think about unloading frame buffers or PCI devices with multiple
functions and multiple drivers. I agree the drivers definitely want
fixing where appropriate. I'm not sure your approach is safe (although a
debug printk would work wonders perhaps ?)

Another question: When I suggested doing exactly this for kexec I got
flamed by people claiming that disabling bus mastering isnt a defined
operation only enabling it. I'm still unconvinced by their protestations
but wonder what the PCI gurus can answer here.


