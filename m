Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271049AbTGPLVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271050AbTGPLVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:21:04 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:11787 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S271049AbTGPLUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:20:22 -0400
Date: Wed, 16 Jul 2003 15:34:38 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Art Haas <ahaas@airmail.net>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
Message-ID: <20030716153438.A9688@jurassic.park.msu.ru>
References: <Pine.SOL.4.30.0307160050340.27735-100000@mion.elka.pw.edu.pl> <Pine.SOL.4.30.0307160109140.27735-100000@mion.elka.pw.edu.pl> <20030715233202.GB17444@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030715233202.GB17444@artsapartment.org>; from ahaas@airmail.net on Tue, Jul 15, 2003 at 06:32:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 06:32:02PM -0500, Art Haas wrote:
> I've been using the 2.5 series for a long time now, but I have vague
> memories of not needing to use 'ide=nodma' before this patch was added:
> 
> ===== setup-pci.c 1.5 vs 1.6 =====
> --- 1.5/drivers/ide/setup-pci.c	Sat Sep 21 07:59:59 2002
> +++ 1.6/drivers/ide/setup-pci.c	Tue Sep 24 09:24:57 2002
> @@ -250,6 +250,7 @@
>  
>  		switch(dev->device) {
>  			case PCI_DEVICE_ID_AL_M5219:
> +			case PCI_DEVICE_ID_AL_M5229:
>  			case PCI_DEVICE_ID_AMD_VIPER_7409:
>  			case PCI_DEVICE_ID_CMD_643:
>  			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:

Hmm, interesting. This line has been added at early stage of IDE rewrite
to work around some unrelated bug, IIRC. I strongly suspect that it's
not needed anymore (will verify it later today), and it also might explain
weird DMA breakage with older ALi chips.

BTW, have you tried recent 2.4 kernels? Looks like this line should be
removed in 2.4 as well.

Ivan.
