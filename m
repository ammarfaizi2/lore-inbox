Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTEKOqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEKOqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:46:21 -0400
Received: from smtp0.libero.it ([193.70.192.33]:16265 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S261631AbTEKOqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:46:20 -0400
Date: Sun, 11 May 2003 14:02:32 +0300
From: Daniele Pala <dandario@libero.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk4 -- drivers/ide/ppc/pmac.c: 724: In function `pmac_find_ide_boot': incompatible types in return
Message-ID: <20030511110232.GA354@libero.it>
References: <3EBD8ADF.5040803@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBD8ADF.5040803@attbi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed this one by changing the last return value of the function from

return NODEV;
to
return -ENODEV;

I don't know if this is the correct return value but it worked for me...anybody knows if it's the correct fix?

On Sat, May 10, 2003 at 04:27:27PM -0700, Miles Lane wrote:
>   gcc -Wp,-MD,drivers/ide/ppc/.pmac.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -Iarch/ppc -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple 
> -mstring -fomit-frame-pointer -nostdinc -iwithprefix include 
> -Idrivers/ide  -DKBUILD_BASENAME=pmac -DKBUILD_MODNAME=pmac -c -o 
> drivers/ide/ppc/pmac.o drivers/ide/ppc/pmac.c
> drivers/ide/ppc/pmac.c: In function `pmac_find_ide_boot':
> drivers/ide/ppc/pmac.c:724: incompatible types in return
> make[3]: *** [drivers/ide/ppc/pmac.o] Error 1
> 
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDESCSI=m
> 
> #
> # IDE chipset support/bugfixes
> #
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_GENERIC=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_ADMA=y
> 
> CONFIG_BLK_DEV_IDE_PMAC=y
> CONFIG_BLK_DEV_IDEDMA_PMAC=y
> CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO=y
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_BLK_DEV_IDE_MODES=y
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
