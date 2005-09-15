Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVIOCSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVIOCSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVIOCSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:18:20 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:37807 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1030343AbVIOCSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:18:20 -0400
Date: Wed, 14 Sep 2005 19:18:07 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Chris Wright <chrisw@osdl.org>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address,
 not just low 1 byte
In-Reply-To: <20050915010404.660502000@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
References: <20050915010343.577985000@localhost.localdomain>
 <20050915010404.660502000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

didn't Linus find similar bugs in a couple of the other hpt drivers as 
well? if so can they be fixed at the same time?

David Lang

On Wed, 14 Sep 2005, Chris Wright wrote:

> Date: Wed, 14 Sep 2005 18:03:47 -0700
> From: Chris Wright <chrisw@osdl.org>
> To: linux-kernel@vger.kernel.org, stable@kernel.org
> Cc: Justin Forbes <jmforbes@linuxtx.org>,
>     Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>,
>     Randy Dunlap <rdunlap@xenotime.net>,
>     Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org,
>     alan@lxorguk.ukuu.org.uk, Linus Torvalds <torvalds@osdl.org>,
>     Chris Wright <chrisw@osdl.org>
> Subject: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address,
>     not just low 1 byte
> 
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
>
> This is one heck of a confused driver.  It uses a byte write to a dword
> register to enable a ROM resource that it doesn't even seem to be using.
>
> "Lost and wandering in the desert of confusion"
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Chris Wright <chrisw@osdl.org>
> ---
> drivers/ide/pci/hpt366.c |    8 ++++++--
> 1 files changed, 6 insertions(+), 2 deletions(-)
>
> Index: linux-2.6.13.y/drivers/ide/pci/hpt366.c
> ===================================================================
> --- linux-2.6.13.y.orig/drivers/ide/pci/hpt366.c
> +++ linux-2.6.13.y/drivers/ide/pci/hpt366.c
> @@ -1334,9 +1334,13 @@ static int __devinit init_hpt366(struct
> static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
> {
> 	int ret = 0;
> -	/* FIXME: Not portable */
> +
> +	/*
> +	 * FIXME: Not portable. Also, why do we enable the ROM in the first place?
> +	 * We don't seem to be using it.
> +	 */
> 	if (dev->resource[PCI_ROM_RESOURCE].start)
> -		pci_write_config_byte(dev, PCI_ROM_ADDRESS,
> +		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
> 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
>
> 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
>
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
