Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130266AbRB1Q0c>; Wed, 28 Feb 2001 11:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130264AbRB1Q0W>; Wed, 28 Feb 2001 11:26:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22177 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130266AbRB1Q0M>;
	Wed, 28 Feb 2001 11:26:12 -0500
Message-ID: <3A9D26A2.14563DE1@mandrakesoft.com>
Date: Wed, 28 Feb 2001 11:26:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] pci_dma_set_mask()
In-Reply-To: <20010228103727.I23735@tetsuo.zabbo.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> +int
> +pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask)
> +{
> +    if(! pci_dma_supported(dev, mask))
> +        return 0;
> +
> +    dev->dma_mask = mask;
> +
> +    return 1;
> +}

pci_dma_supported has a boolean return, but the kernel norm is to return
zero on success, and -EFOO on error.  I like your proposal with the
extremely minor nit that I think pci_set_dma_mask should return ENODEV
or EIO or something on error, and zero on success.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
