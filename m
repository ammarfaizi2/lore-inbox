Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbUASRGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265392AbUASRGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:06:15 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:59782 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265384AbUASRGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:06:12 -0500
Subject: Re: 2.6.1-mm4: ALSA es1968 DMA alloc problem
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org
In-Reply-To: <s5hwu7n6gvz.wl@alsa2.suse.de>
References: <20040117161013.GA3303@convergence.de>
	 <s5hwu7n6gvz.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uNU8b89R2iTCeWzhuawm"
Organization: Red Hat, Inc.
Message-Id: <1074531954.4443.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Jan 2004 18:05:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uNU8b89R2iTCeWzhuawm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-19 at 17:29, Takashi Iwai wrote:
> --- linux/sound/core/memalloc.c	15 Jan 2004 16:17:36 -0000	1.20
> +++ linux/sound/core/memalloc.c	19 Jan 2004 11:52:21 -0000
> @@ -841,10 +844,11 @@
>  			continue;
>  		}
>  		=09
> -		if (pci_set_consistent_dma_mask(pci, dev->dma_mask) < 0) {
> +		if (pci_set_dma_mask(pci, dev->dma_mask) < 0) {
>  			printk(KERN_ERR "snd-page-alloc: cannot set DMA mask %lx for pci %04x=
:%04x\n", dev->dma_mask, dev->vendor, dev->device);
>  			continue;
>  		}
> +		pci_set_consistent_dma_mask(pci, dev->dma_mask);
>  		for (i =3D 0; i < dev->buffers; i++) {
>  			struct snd_mem_list *mem;
>  			mem =3D kmalloc(sizeof(*mem), GFP_KERNEL);

unchecked=20


> --- linux/sound/pci/emu10k1/emu10k1_main.c	2 Jan 2004 13:39:33 -0000	1.27
> +++ linux/sound/pci/emu10k1/emu10k1_main.c	19 Jan 2004 11:47:55 -0000
> @@ -599,11 +599,12 @@
>  		return -ENOMEM;
>  	/* set the DMA transfer mask */
>  	emu->dma_mask =3D is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
> -	if (pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
> +	if (pci_set_dma_mask(pci, emu->dma_mask)) {
>  		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA w=
ith mask 0x%lx\n", emu->dma_mask);
>  		snd_magic_kfree(emu);
>  		return -ENXIO;
>  	}
> +	pci_set_consistent_dma_mask(pci, emu->dma_mask);
>  	emu->card =3D card;
>  	spin_lock_init(&emu->reg_lock);
>  	spin_lock_init(&emu->emu_lock);

unchecked
> --- linux/sound/pci/trident/trident_main.c	20 Nov 2003 12:03:01 -0000	1.4=
3
> +++ linux/sound/pci/trident/trident_main.c	19 Jan 2004 11:48:59 -0000
> @@ -3952,6 +3952,7 @@
>  		return;
> =20
>  	pci_enable_device(trident->pci);
> +	pci_set_dma_mask(trident->pci, 0x3fffffff); /* FIXME: correct? */
>  	pci_set_consistent_dma_mask(trident->pci, 0x3fffffff); /* FIXME: correc=
t? */
>  	pci_set_master(trident->pci); /* to be sure */
> =20

unchecked


--=-uNU8b89R2iTCeWzhuawm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBADA5yxULwo51rQBIRAlL2AJ4q71qJSOuG2cG5T8pEA/QF+LnH5wCfX0HC
G0tPsOZ61VaDGtMO2+efJC8=
=VopT
-----END PGP SIGNATURE-----

--=-uNU8b89R2iTCeWzhuawm--
