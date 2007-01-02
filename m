Return-Path: <linux-kernel-owner+w=401wt.eu-S1753739AbXABVcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbXABVcG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbXABVcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:32:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46798 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974AbXABVcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:32:04 -0500
Message-ID: <459ACF51.1010501@garzik.org>
Date: Tue, 02 Jan 2007 16:32:01 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
CC: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>	<459973F6.2090201@pobox.com>	<20070102115834.1e7644b2@localhost.localdomain>	<459AC808.1030807@pobox.com> <20070102212701.4b4535cf@localhost.localdomain> <459ACE9C.7020107@pobox.com>
In-Reply-To: <459ACE9C.7020107@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> * After your patch, the code explicitly calls pci_request_region() for 
> BARs 0-4, but never for BAR5.

Without checking for failures, I might add.

Let's call that regression/obvious bug #4, because the previous code 
actually CARED if the resource was reserved.

>                 if (legacy_mode & ATA_PORT_PRIMARY)
>                         pci_request_region(pdev, 1, DRV_NAME);
>                 if (legacy_mode & ATA_PORT_SECONDARY)
>                         pci_request_region(pdev, 3, DRV_NAME);
>                 /* If there is a DMA resource, allocate it */
>                 pci_request_region(pdev, 4, DRV_NAME);

I agree this is one way to avoid conflicts!  ;-)

	Jeff


