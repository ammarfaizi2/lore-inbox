Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132960AbRDRQ4L>; Wed, 18 Apr 2001 12:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133061AbRDRQ4C>; Wed, 18 Apr 2001 12:56:02 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:935 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S132960AbRDRQz5>;
	Wed, 18 Apr 2001 12:55:57 -0400
Message-ID: <3ADDC716.7F5B43C8@mandrakesoft.com>
Date: Wed, 18 Apr 2001 12:55:50 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] misplaced pci_enable_device()s in drivers/sound/
In-Reply-To: <20010418182944.A25024@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:
> Several pci_enable_device()s in drivers/sound happen _after_ accessing
> PCI resources. I have moved them before the relevant first accesses.

cool

>         if (!RSRCISIOREGION(pcidev, 0))
>                 return -1;

can you replace this mess while you are cleaning stuff up.  this, for
example, should be
	if (!(pci_resource_flags(pcidev,) & IORESOURCE_IO))

There is also pci_resource_start and pci_resource_len.

>         iobase = SILLY_PCI_BASE_ADDRESS(pcidev);

pci_resource_start

patch looks ok to me, but those would be nice additions...

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
