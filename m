Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318983AbSHMTEx>; Tue, 13 Aug 2002 15:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318986AbSHMTEx>; Tue, 13 Aug 2002 15:04:53 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60775 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S318983AbSHMTEw>; Tue, 13 Aug 2002 15:04:52 -0400
Date: Tue, 13 Aug 2002 15:08:42 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200208131908.g7DJ8g817440@devserv.devel.redhat.com>
To: "Jason Zebchuk" <jason@consensys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci_do_scan_bus
In-Reply-To: <mailman.1029261839.22627.linux-kernel2news@redhat.com>
References: <mailman.1029261839.22627.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- linux-2.5.30/drivers/pci/probe.c    Thu Aug  1 17:16:10 2002
> +++ linux/drivers/pci/probe.c   Tue Aug  6 12:36:53 2002
>         /* Create a device template */
> -       memset(&dev0, 0, sizeof(dev0));
> -       dev0.bus = bus;
> +       dev0 = kmalloc(sizeof(struct pci_dev), GFP_ATOMIC);
> +       if (dev0 == NULL)
> +               BUG();
> +       memset(dev0, 0, sizeof(dev0));
> +       dev0->bus = bus;

Why is this atomic? I think we do not scan from interrupts,
only from init/swapper and insmod contexts.

-- Pete
