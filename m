Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVHHItm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVHHItm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 04:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVHHItm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 04:49:42 -0400
Received: from ozlabs.org ([203.10.76.45]:46058 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750764AbVHHItl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 04:49:41 -0400
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove warning about e1000_suspend
Date: Mon, 8 Aug 2005 18:49:34 +1000
User-Agent: KMail/1.8
Cc: Nikhil Dharashivkar <nikhildharashivkar@gmail.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>
References: <256850000.1123442258@10.10.2.4> <17db6d3a05080723096ec26531@mail.gmail.com>
In-Reply-To: <17db6d3a05080723096ec26531@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2663196.llpg3Sp0Ko";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508081849.34831.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2663196.llpg3Sp0Ko
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 8 Aug 2005 16:09, Nikhil Dharashivkar wrote:
> Hi Martin,
>     But e1000_notify_reboot () function calls this e1000_suspend()
> function irrespective of  CONFIG_FM is defined or not. So according to
> your soution, what if CONFIG_FM is not defined.

Does it? I can't find it.

Martin's patch works for me.

cheers

>
> On 8/8/05, Martin J. Bligh <mbligh@mbligh.org> wrote:
> > e1000_suspend is only used under #ifdef CONFIG_PM. Move the declaration
> > of it to be the same way, just like e1000_resume, otherwise gcc whines
> > on compile. I offer as evidence:
> >
> >         static struct pci_driver e1000_driver =3D {
> >                .name     =3D e1000_driver_name,
> >               .id_table =3D e1000_pci_tbl,
> >               .probe    =3D e1000_probe,
> >               .remove   =3D __devexit_p(e1000_remove),
> >               /* Power Managment Hooks */
> >         #ifdef CONFIG_PM
> >                .suspend  =3D e1000_suspend,
> >                .resume   =3D e1000_resume
> >         #endif
> >         };
> >
> >
> > diff -aurpN -X /home/fletch/.diff.exclude
> > virgin/drivers/net/e1000/e1000_main.c
> > e1000_suspend/drivers/net/e1000/e1000_main.c ---
> > virgin/drivers/net/e1000/e1000_main.c       2005-08-07 09:15:36.0000000=
00
> > -0700 +++ e1000_suspend/drivers/net/e1000/e1000_main.c        2005-08-07
> > 12:10:42.000000000 -0700 @@ -162,8 +162,8 @@ static void
> > e1000_vlan_rx_add_vid(struct
> >  static void e1000_vlan_rx_kill_vid(struct net_device *netdev, uint16_t
> > vid); static void e1000_restore_vlan(struct e1000_adapter *adapter);
> >
> > -static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
> >  #ifdef CONFIG_PM
> > +static int e1000_suspend(struct pci_dev *pdev, uint32_t state);
> >  static int e1000_resume(struct pci_dev *pdev);
> >  #endif
> >
> > @@ -3641,6 +3641,7 @@ e1000_set_spd_dplx(struct e1000_adapter
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_PM
> >  static int
> >  e1000_suspend(struct pci_dev *pdev, uint32_t state)
> >  {
> > @@ -3733,7 +3734,6 @@ e1000_suspend(struct pci_dev *pdev, uint
> >         return 0;
> >  }
> >
> > -#ifdef CONFIG_PM
> >  static int
> >  e1000_resume(struct pci_dev *pdev)
> >  {
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart2663196.llpg3Sp0Ko
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC9xyedSjSd0sB4dIRAkJoAKC6EufXYZsquU+ZmsoeoIM/3Hj20gCgj9T7
8z+PucxvABjG6EUJrBzWMms=
=LYyD
-----END PGP SIGNATURE-----

--nextPart2663196.llpg3Sp0Ko--
