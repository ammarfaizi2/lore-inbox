Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWJXLU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWJXLU7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 07:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWJXLU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 07:20:59 -0400
Received: from alpha.ccii.co.za ([196.30.62.4]:40418 "HELO alpha.ccii.co.za")
	by vger.kernel.org with SMTP id S1030309AbWJXLU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 07:20:59 -0400
Message-Id: <5.0.0.25.2.20061024131939.05e4de70@alpha.ccii.co.za>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Tue, 24 Oct 2006 13:19:59 +0200
To: linux-kernel@vger.kernel.org
From: Wouter de Waal <wrm@ccii.co.za>
Subject: FDDI on Linux kernel 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed; x-avg-checked=avg-ok-460531B1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006-10-24

Hi

We here at CCII Systems are probably the only company in the world still
actively involved with FDDI. The Linux Syskonnect FDDI driver needs a
patch. I have no idea who to speak to, but the guys over at osdl said I
must ask here.

We recently had two separate customers ask us why the FDDI driver in
the Linux kernel version 2.6.x does not work properly.

The first customer eventually found that the driver does not work when
the kernel is configured to use 64 bit memory addressing. This would
obviously have to do with the pointer sizes used by the driver structure.

They did not need 64 bit addressing, and solved their problem by
reconfiguring their kernel for 32 bit addressing.

Is it possible to configure things so that this issue is highlighted
when the kernel is built?

The second customer's problem could not be solved by the above. They
eventually found that kernel 2.6 (specifically, 2.6.8) uses memory
mapping, and that a check in the driver caused an exception because
of the length of the PCI region being 2048 and not 16384 (0x4000).


>//2.6.8 version from skfddi.c
>
>#ifdef MEM_MAPPED_IO
>
>if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
>   printk(KERN_ERR "skfp: region is not an MMIO resource\n");
>   err = -EIO;
>   goto err_out1;
>}
>
>port = pci_resource_start(pdev, 0);
>len = pci_resource_len(pdev, 0);
>if (len < 0x4000) {
>   printk(KERN_ERR "skfp: Invalid PCI region size: %lu\n", len);
>   err = -EIO;
>   goto err_out1;
>}
>
>#else

The customer reports that changing the compare to

>if (len < 2048) {

fixed the problem for them.

Can this patch be applied to the kernel please?

Regards

Wouter

-- 

Wouter de Waal                              Cell  : +27 82 893 8042
Development Manager - Board-Level Products  Phone : +27 21 683 5490
CCII Systems, Kenilworth, South Africa      Fax   : +27 21 683 5435

