Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267495AbUHXPDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267495AbUHXPDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUHXPDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:03:01 -0400
Received: from cantor.suse.de ([195.135.220.2]:3737 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267495AbUHXPB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:01:57 -0400
Date: Tue, 24 Aug 2004 17:01:38 +0200
From: Karsten Keil <kkeil@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9-rc1 - #ifdef fixes for drivers/isdn/hifax/*
Message-ID: <20040824150137.GC7664@pingi3.kke.suse.de>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200408241341.i7ODfRK7016008@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <200408241341.i7ODfRK7016008@turing-police.cc.vt.edu>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.5-7.95-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yes that patch obvious correct.

Signed-off-by: Karsten keil <kkeil@suse.de>

On Tue, Aug 24, 2004 at 09:41:27AM -0400, Valdis.Kletnieks@vt.edu wrote:
> Hopefully -rc1 is a good time for small cleanups.. ;)
>=20
> This patch changes a bunch of '#if CONFIG_PCI' to '#ifdef' instead,
> to make the kernel source cleaner for compiling with 'gcc -Wundef'.
>=20
> As an aside, while doing this cleanup I spotted a number of
> obviously null #ifdef/#endif pairs that had absolutely nothing
> between them - anybody have a clue what *that* is all about?

Hmm, I know 2 reasons for such things, after cut and paste code
and remove some lines it was left over.
I use a preparser which eliminates compatibility code between
different kernel versions (e.g. 2.4/2.6) from our CVS codebase before
patching the kernel, sometimes it produce such relics (be free to delete
them).

>=20
> --- linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a4t.c.ifdef	2004-08-14 01:36:5=
6.000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a4t.c	2004-08-24 09:29:46.0038=
34717 -0400
> @@ -265,7 +265,7 @@ setup_bkm_a4t(struct IsdnCard *card)
>  	char tmp[64];
>  	u_int pci_memaddr =3D 0, found =3D 0;
>  	I20_REGISTER_FILE *pI20_Regs;
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  #endif
> =20
>  	strcpy(tmp, bkm_a4t_revision);
> @@ -275,7 +275,7 @@ setup_bkm_a4t(struct IsdnCard *card)
>  	} else
>  		return (0);
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  	while ((dev_a4t =3D pci_find_device(PCI_VENDOR_ID_ZORAN,
>  		PCI_DEVICE_ID_ZORAN_36120, dev_a4t))) {
>  		u16 sub_sys;
> --- linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a8.c.ifdef	2004-08-14 01:37:39=
=2E000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/bkm_a8.c	2004-08-24 09:30:51.65658=
6568 -0400
> @@ -21,7 +21,7 @@
>  #include <linux/pci.h>
>  #include "bkm_ax.h"
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
> =20
>  #define	ATTEMPT_PCI_REMAPPING	/* Required for PLX rev 1 */
> =20
> @@ -285,7 +285,7 @@ static u_char pci_irq __initdata =3D 0;
>  int __init
>  setup_sct_quadro(struct IsdnCard *card)
>  {
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  	struct IsdnCardState *cs =3D card->cs;
>  	char tmp[64];
>  	u_char pci_rev_id;
> --- linux-2.6.9-rc1/drivers/isdn/hisax/diva.c.ifdef	2004-08-14 01:38:04.0=
00000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/diva.c	2004-08-24 09:31:04.8697253=
12 -0400
> @@ -1027,7 +1027,7 @@ setup_diva(struct IsdnCard *card)
>  			}
>  		}
>  #endif
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  		cs->subtyp =3D 0;
>  		if ((dev_diva =3D pci_find_device(PCI_VENDOR_ID_EICON,
>  			PCI_DEVICE_ID_EICON_DIVA20, dev_diva))) {
> --- linux-2.6.9-rc1/drivers/isdn/hisax/elsa.c.ifdef	2004-08-14 01:36:17.0=
00000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/elsa.c	2004-08-24 09:28:59.2974140=
44 -0400
> @@ -1022,7 +1022,7 @@ setup_elsa(struct IsdnCard *card)
>  		       cs->hw.elsa.base,
>  		       cs->irq);
>  	} else if (cs->typ =3D=3D ISDN_CTYPE_ELSA_PCI) {
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  		cs->subtyp =3D 0;
>  		if ((dev_qs1000 =3D pci_find_device(PCI_VENDOR_ID_ELSA,
>  			PCI_DEVICE_ID_ELSA_MICROLINK, dev_qs1000))) {
> --- linux-2.6.9-rc1/drivers/isdn/hisax/enternow_pci.c.ifdef	2004-08-14 01=
:37:38.000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/enternow_pci.c	2004-08-24 09:30:36=
=2E606706557 -0400
> @@ -299,7 +299,7 @@ setup_enternow_pci(struct IsdnCard *card
>  	struct IsdnCardState *cs =3D card->cs;
>  	char tmp[64];
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  #ifdef __BIG_ENDIAN
>  #error "not running on big endian machines now"
>  #endif
> --- linux-2.6.9-rc1/drivers/isdn/hisax/gazel.c.ifdef	2004-08-14 01:36:59.=
000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/gazel.c	2004-08-24 09:30:17.574387=
534 -0400
> @@ -634,7 +634,7 @@ setup_gazel(struct IsdnCard *card)
>  			return (0);
>  	} else {
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  		if (setup_gazelpci(cs))
>  			return (0);
>  #else
> --- linux-2.6.9-rc1/drivers/isdn/hisax/hfc_pci.c.ifdef	2004-08-14 01:36:5=
6.000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/hfc_pci.c	2004-08-24 09:30:05.1041=
44152 -0400
> @@ -65,7 +65,7 @@ static const PCI_ENTRY id_list[] =3D
>  };
> =20
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
> =20
>  /******************************************/
>  /* free hardware resources used by driver */
> @@ -1655,7 +1655,7 @@ setup_hfcpci(struct IsdnCard *card)
>  #endif
>  	strcpy(tmp, hfcpci_revision);
>  	printk(KERN_INFO "HiSax: HFC-PCI driver Rev. %s\n", HiSax_getrev(tmp));
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  	cs->hw.hfcpci.int_s1 =3D 0;
>  	cs->dc.hfcpci.ph_state =3D 0;
>  	cs->hw.hfcpci.fifo =3D 255;
> --- linux-2.6.9-rc1/drivers/isdn/hisax/niccy.c.ifdef	2004-08-14 01:36:56.=
000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/niccy.c	2004-08-24 09:29:30.065079=
935 -0400
> @@ -309,7 +309,7 @@ setup_niccy(struct IsdnCard *card)
>  			return (0);
>  		}
>  	} else {
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  		u_int pci_ioaddr;
>  		cs->subtyp =3D 0;
>  		if ((niccy_dev =3D pci_find_device(PCI_VENDOR_ID_SATSAGEM,
> --- linux-2.6.9-rc1/drivers/isdn/hisax/nj_s.c.ifdef	2004-08-14 01:36:33.0=
00000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/nj_s.c	2004-08-24 09:29:22.5921326=
16 -0400
> @@ -167,7 +167,7 @@ setup_netjet_s(struct IsdnCard *card)
>  		return(0);
>  	test_and_clear_bit(FLG_LOCK_ATOMIC, &cs->HW_Flags);
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
> =20
>  	for ( ;; )
>  	{
> --- linux-2.6.9-rc1/drivers/isdn/hisax/nj_u.c.ifdef	2004-08-14 01:36:32.0=
00000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/nj_u.c	2004-08-24 09:31:36.7392360=
58 -0400
> @@ -137,7 +137,7 @@ setup_netjet_u(struct IsdnCard *card)
>  	int bytecnt;
>  	struct IsdnCardState *cs =3D card->cs;
>  	char tmp[64];
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  #endif
>  #ifdef __BIG_ENDIAN
>  #error "not running on big endian machines now"
> @@ -148,7 +148,7 @@ setup_netjet_u(struct IsdnCard *card)
>  		return(0);
>  	test_and_clear_bit(FLG_LOCK_ATOMIC, &cs->HW_Flags);
> =20
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
> =20
>  	for ( ;; )
>  	{
> --- linux-2.6.9-rc1/drivers/isdn/hisax/sedlbauer.c.ifdef	2004-08-14 01:38=
:08.000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/sedlbauer.c	2004-08-24 09:31:11.04=
4855460 -0400
> @@ -618,7 +618,7 @@ setup_sedlbauer(struct IsdnCard *card)
>  		}
>  #endif
>  /* Probe for Sedlbauer speed pci */
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  		if ((dev_sedl =3D pci_find_device(PCI_VENDOR_ID_TIGERJET,
>  				PCI_DEVICE_ID_TIGERJET_100, dev_sedl))) {
>  			if (pci_enable_device(dev_sedl))
> --- linux-2.6.9-rc1/drivers/isdn/hisax/telespci.c.ifdef	2004-08-14 01:37:=
25.000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/telespci.c	2004-08-24 09:30:27.559=
980918 -0400
> @@ -300,7 +300,7 @@ setup_telespci(struct IsdnCard *card)
>  	printk(KERN_INFO "HiSax: Teles/PCI driver Rev. %s\n", HiSax_getrev(tmp)=
);
>  	if (cs->typ !=3D ISDN_CTYPE_TELESPCI)
>  		return (0);
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  	if ((dev_tel =3D pci_find_device (PCI_VENDOR_ID_ZORAN, PCI_DEVICE_ID_ZO=
RAN_36120, dev_tel))) {
>  		if (pci_enable_device(dev_tel))
>  			return(0);
> --- linux-2.6.9-rc1/drivers/isdn/hisax/w6692.c.ifdef	2004-08-14 01:37:40.=
000000000 -0400
> +++ linux-2.6.9-rc1/drivers/isdn/hisax/w6692.c	2004-08-24 09:30:58.456628=
686 -0400
> @@ -1012,7 +1012,7 @@ setup_w6692(struct IsdnCard *card)
>  	printk(KERN_INFO "HiSax: W6692 driver Rev. %s\n", HiSax_getrev(tmp));
>  	if (cs->typ !=3D ISDN_CTYPE_W6692)
>  		return (0);
> -#if CONFIG_PCI
> +#ifdef CONFIG_PCI
>  	while (id_list[id_idx].vendor_id) {
>  		dev_w6692 =3D pci_find_device(id_list[id_idx].vendor_id,
>  					    id_list[id_idx].device_id,
>=20
>=20



--=20
Karsten Keil
SuSE Labs
ISDN development
--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBK1hRo5VVC52CNcQRAnwUAKCCvOXdt+f1UMlzGFotFnyvBtBfngCbBjlo
yeslh9xzabfJ1nAgntn8Nk4=
=0j2L
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
