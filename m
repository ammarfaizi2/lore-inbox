Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAAThB>; Mon, 1 Jan 2001 14:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129538AbRAATgu>; Mon, 1 Jan 2001 14:36:50 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:10249
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129534AbRAATgq>; Mon, 1 Jan 2001 14:36:46 -0500
Date: Mon, 1 Jan 2001 11:06:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
In-Reply-To: <Pine.LNX.4.10.10101011011350.2892-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10101011055260.22396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because the people writing the SPEC screwed up.

The was a discussion to remove drive side detection and make it only host,
but since many chipset makers can not connect GPIO's for the 80 conductor
ribbon....let me walk you through the mess.

Bit 13 of word 93 is a capacitance decay test if the host and device
support the capactor.

Bit 14 of word 93 is now defined as always set to 1 if mode 3 or higher is
supported.

Since some slave devices do not drop the PDIAG line to allow the sense
bit 13 to correctly be detected on the master device, well you get the
mess.

Phoenix Technologies and I are discussing to recreation of an new
detection rules table and make it a sane one.  I hope to have a draft
porposal for the February Meeting at Dell.

This issue is a complete mess in the committee.

The Drive guys do not want to have the liablity of reporting.
The Chipset guys do not always get it right.
Thus the Software guys get shafted with making the mess work.

On Mon, 1 Jan 2001, Linus Torvalds wrote:

> 
> 
> Andre, what's the idea behind the following change:
> 
> --- linux-2.4.0-prerelease-pristine/drivers/ide/ide-features.c  Mon Oct 16 12:21:40 2000
> +++ linux-2.4.0-prerelease/drivers/ide/ide-features.c   Sun Dec 31 21:53:17 2000
> @@ -224,7 +224,7 @@
>  #ifndef CONFIG_IDEDMA_IVB
>                 if ((drive->id->hw_config & 0x6000) == 0) {
>  #else /* !CONFIG_IDEDMA_IVB */
> -               if (((drive->id->hw_config & 0x2000) == 0) ||
> +               if (((drive->id->hw_config & 0x2000) == 0) &&
>                     ((drive->id->hw_config & 0x4000) == 0)) {
>  #endif /* CONFIG_IDEDMA_IVB */
>                         printk("%s: Speed warnings UDMA 3/4/5 is not functional.\n", drive->name);
> 
> as it apparently makes CONFIG_IDEDMA_IVB a complete no-op?

Exactly what it is designed to do, Ignore Validity Bits, because the whole
damn messedup the rules between ATA-4 and ATA-6

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
