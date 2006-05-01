Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWEAT40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWEAT40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWEAT4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:56:25 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:55223 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932211AbWEAT4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:56:17 -0400
In-Reply-To: <ada7j55vayj.fsf@cisco.com>
References: <1906950392f7ef8c7d07.1145913778@eng-12.pathscale.com> <ada7j55vayj.fsf@cisco.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4B05D10C-407E-46A5-848F-0897D1E6D1CD@kernel.crashing.org>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2 of 13] ipath - set up 32-bit DMA mask if 64-bit setup fails
Date: Mon, 1 May 2006 21:56:09 +0200
To: Roland Dreier <rdreier@cisco.com>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Bryan> Some systems do not set up 64-bit maps on systems with 2GB
>     Bryan> or less of memory installed, so we have to fall back to
>     Bryan> trying a 32-bit setup.
>
> Which systems does this happen on?

PowerPC with U3 or U4 northbridge, i.e. Maple or PowerMac G5 systems.
If the IOMMU (DART) is disabled, we have a 32-bit only DMA mask.  The
DART will be disabled by default if there is 2GB or less of memory (as
it isn't needed then).

> I'm just curious, because mthca has
>
> 	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
> 	if (err) {
> 		dev_warn(&pdev->dev, "Warning: couldn't set 64-bit PCI DMA mask. 
> \n");
>
> and I've never had a single report of that warning triggering.

That's only because I never used those cards on systems with fewer
than 4GB of memory :-)


Segher

