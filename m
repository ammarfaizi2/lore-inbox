Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276640AbRJPTWA>; Tue, 16 Oct 2001 15:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276643AbRJPTVu>; Tue, 16 Oct 2001 15:21:50 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:33544 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S276640AbRJPTVl> convert rfc822-to-8bit; Tue, 16 Oct 2001 15:21:41 -0400
Date: Tue, 16 Oct 2001 21:16:30 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <jbglaw@lug-owl.de>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Oops while inserting sym53c8xx.o
In-Reply-To: <20011016.022902.74752070.davem@redhat.com>
Message-ID: <20011016205934.M356-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi David,

I missed this one, but, btw, it wasn't from me as you know. :-)
OTOH, I use sym-2 instead since months. :)

Btw, sym-2 has a new PCI 64 bit DMA addressing mode using 16 segment
registers. 4GB * 16 = 64 GB. The change is simple and can be back-ported
to sym-1. It also support 40 bit addressing, but not both at the same
time (compilation optionnable).

Note that I would rather prefer to push sym-2 to kernel main-stream. This
is planned, but condition was to prove sym-2 in kernel 2.5 first, but
kernel 2.5 is very long to come.

The new 'up to 64 GB addressing DMA support' has no limitation regarding
64 bit addressing and should better fit existing 64 bit machines. It is
obviously untested since, for some obscure reasons, both SUN and COMPAQ
missed to offer me a machine suitable for the testings. :-)

sym-2.1.15 is available for download from ftp.tux.org. If you have time
for giving it a try on some large memory machine, you may let me know
the results.

Bye for now,
  Gérard.

PS: The enabling of the new 64 GB DMA support requires a simple define
    changes in the source. You cannot miss it.

On Tue, 16 Oct 2001, David S. Miller wrote:

>
> This should fix it, Linux please apply.
>
> --- drivers/scsi/sym53c8xx.c.~1~	Mon Oct  8 21:04:56 2001
> +++ drivers/scsi/sym53c8xx.c	Tue Oct 16 02:27:44 2001
> @@ -13168,14 +13168,14 @@
>  	** in the size field.  We use normal 32-bit PCI addresses for
>  	** descriptors.
>  	*/
> -	if (chip->features & FE_DAC) {
> +	if (chip && (chip->features & FE_DAC)) {
>  		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
>  			chip->features &= ~FE_DAC_IN_USE;
>  		else
>  			chip->features |= FE_DAC_IN_USE;
>  	}
>
> -	if (!(chip->features & FE_DAC_IN_USE)) {
> +	if (chip && !(chip->features & FE_DAC_IN_USE)) {
>  		if (pci_set_dma_mask(pdev, (u64) 0xffffffff)) {
>  			printk(KERN_WARNING NAME53C8XX
>  			       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

