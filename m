Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbTGKFfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 01:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269795AbTGKFfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 01:35:46 -0400
Received: from mx11.sac.fedex.com ([199.81.193.118]:50701 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP id S266611AbTGKFfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 01:35:44 -0400
Date: Fri, 11 Jul 2003 13:48:42 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Jeff Chua <jchua@fedex.com>
cc: James Bourne <jbourne@hardrock.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Chua <jeff89@silk.corp.fedex.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.22-pre4 ide module fix init_cmd640_vlb
In-Reply-To: <Pine.LNX.4.42.0307110223070.4985-100000@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.42.0307111337530.12527-100000@silk.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/11/2003
 01:50:19 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 07/11/2003
 01:50:22 PM,
	Serialize complete at 07/11/2003 01:50:22 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One more thing ... when compiled as a module, DMA can't be enabled!
If compiled as non-modules (CONFIG_IDE=y, CONFIG_BLK_DEV_IDE=y), DMA works
fine.


# hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)



My .config ...

	CONFIG_IDE=m
	CONFIG_BLK_DEV_IDE=m
	CONFIG_BLK_DEV_IDEDISK=m
	CONFIG_IDEDISK_MULTI_MODE=y
	CONFIG_BLK_DEV_CMD640=y
	CONFIG_BLK_DEV_CMD640_ENHANCED=y
	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_BLK_DEV_IDEDMA=y
	CONFIG_BLK_DEV_PIIX=y
	CONFIG_IDEDMA_AUTO=y
	CONFIG_BLK_DEV_IDE_MODES=y



Thanks,
Jeff
[ jchua@fedex.com ]

On Fri, 11 Jul 2003, Jeff Chua wrote:

> On Thu, 10 Jul 2003, James Bourne wrote:
>
> > On 10 Jul 2003, Alan Cox wrote:
> >
> > > And stops it working for everyone else. The function does exist too. See
> > > drivers/ide/pci/cmd640.c
>
> Sorry. Missed this one.
>
>
> > Here's a patch that does that exact thing, I haven't tested it though.
> >
>
> "make" doesn't seem to pick up ide/pci/cmd640.c when IDE is compiled as a
> module.
>
> 	touch drivers/ide/pci/cmd640.c; make; make modules;
> 	*** it doesn't compile cmd640.c
>
>
> Jeff
>
>
>
>


