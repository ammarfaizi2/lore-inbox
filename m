Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTAKNRi>; Sat, 11 Jan 2003 08:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbTAKNRh>; Sat, 11 Jan 2003 08:17:37 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60854 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267206AbTAKNRh>; Sat, 11 Jan 2003 08:17:37 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200301111325.h0BDPMr00756@devserv.devel.redhat.com>
Subject: Re: [2.5 patch] go to drivers/ide/pci/ even for !CONFIG_BLK_DEV_IDEPCI
To: bunk@fs.tum.de (Adrian Bunk)
Date: Sat, 11 Jan 2003 08:25:22 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20030111131059.GK10486@fs.tum.de> from "Adrian Bunk" at Jan 11, 2003 02:11:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I observed the following problem with the cmd640 driver in 2.5.56:

I know

> - cmd640.c is in the drivers/ide/pci/ subdirectory.
> - BLK_DEV_CMD640 does not depend on BLK_DEV_IDEPCI

This is correct

> - drivers/ide/Makefile only goes to pci/ if BLK_DEV_IDEPCI is selected
> If the .config contains the following legal configuration:

There are a lot of configurations with this property. 

> The following patch fixes this (similar to 2.4 where pci/ is already 
> visited for !CONFIG_BLK_DEV_IDEPCI):
> 
> --- linux-2.5.56/drivers/ide/Makefile.old	2003-01-11 13:52:30.000000000 +0100
> +++ linux-2.5.56/drivers/ide/Makefile	2003-01-11 13:52:51.000000000 +0100
> @@ -10,7 +10,7 @@
>  export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o
>  
>  # First come modules that register themselves with the core
> -obj-$(CONFIG_BLK_DEV_IDEPCI)		+= pci/
> +obj-$(CONFIG_BLK_DEV_IDE)		+= pci/

I think thats the best approach. 
