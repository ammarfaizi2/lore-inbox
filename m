Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272636AbRIXVah>; Mon, 24 Sep 2001 17:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272576AbRIXVa1>; Mon, 24 Sep 2001 17:30:27 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:3078 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S272636AbRIXVaU>; Mon, 24 Sep 2001 17:30:20 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200109242130.XAA06121@green.mif.pg.gda.pl>
Subject: Re: Kernel 2.4.10: aironet4500_card.c:62: parse error
To: hafre@macro.lan-ks.de, linux-kernel@vger.kernel.org (kernel list)
Date: Mon, 24 Sep 2001 23:30:28 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> When I want to compile Kernel 2.4.10 the following error occours:
> 
> aironet4500_card.c:62: parse error before `__devinitdata'
> aironet4500_card.c:62: warning: type defaults to `int' in declaration\
> of `__devinitdata'
> 
> With the following patch it's compiling, but I could not
> test its functionality.

IMO, a better fix is to 

#include <linux/init.h>

in the driver.
aironet4500 needs more cleaning, however...

> *** drivers/net/aironet4500_card.c.orig Mon Sep 24 18:04:04 2001
> --- drivers/net/aironet4500_card.c      Mon Sep 24 18:06:16 2001
> ***************
> *** 59,65 ****
>   
>   #include <linux/pci.h>
>   
> ! static struct pci_device_id aironet4500_card_pci_tbl[] __devinitdata = {
>         { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800_1, PCI_ANY_ID, PCI_ANY_ID, },
>         { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800, PCI_ANY_ID, PCI_ANY_ID, },
>         { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4500, PCI_ANY_ID, PCI_ANY_ID, },
> --- 59,65 ----
>   
>   #include <linux/pci.h>
>   
> ! static struct pci_device_id aironet4500_card_pci_tbl[] = {
>         { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800_1, PCI_ANY_ID, PCI_ANY_ID, },
>         { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4800, PCI_ANY_ID, PCI_ANY_ID, },
>         { PCI_VENDOR_ID_AIRONET, PCI_DEVICE_AIRONET_4500, PCI_ANY_ID, PCI_ANY_ID, },
> 

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
