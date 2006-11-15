Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966563AbWKOAyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966563AbWKOAyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 19:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966561AbWKOAyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 19:54:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:30847 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966563AbWKOAyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 19:54:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id;
        b=O9NA15p375p/FHHpTqK5WY05f/Hgt58X09sGwHZxo188MPhcNLhG4iez4xTNL6MekncAJvsU+7ouzj8klsuqNj7HuARhkQ0d3UlFTjbjArHGsBxX9Bc+1ug+nVVQ621Sri9FFZVTBbFIkiyPLcbb2oaicJt8zeDcDL008uiy2Do=
From: Christian Hoffmann <chrmhoffmann@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Wed, 15 Nov 2006 01:54:35 +0100
User-Agent: KMail/1.9.5
Cc: linux-fbdev-devel@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com> <200611142247.55137.chrmhoffmann@gmail.com> <1163542033.5940.156.camel@localhost.localdomain>
In-Reply-To: <1163542033.5940.156.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4245875.DufH7IB6Kf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611150154.39499.chrmhoffmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4245875.DufH7IB6Kf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 14 November 2006 23:07, Benjamin Herrenschmidt wrote:
> > I tried that patch, but the last message I see over netconsole (using
> > tg3) is: Suspending console(s)
> > and then nothing. Nothing on resume at all :(
> >
> > Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume
> > (radeon_pm.c) didn't help: I don't see them. But I am not a kernel
> > programmer at all, so I might do something wrong or in the wrong place.
>
> Does it resume if you make radeon_pci_resume() a nop ?
>
> Of course, the fbdev will not come back, but will the machine overall
> resume ?
>
> Ben.
Yes, if i make radeon_pci_resume a nop, the machine resumes if i do a retur=
n 0=20
immediately.
I think I tracked it down to the call to acquire_console_sem() as the=20
following code makes the machine hang again:

int radeonfb_pci_resume(struct pci_dev *pdev)
{
        struct fb_info *info =3D pci_get_drvdata(pdev);
        struct radeonfb_info *rinfo =3D info->par;
        int rc =3D 0;
        if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_ON)
                return 0;
        if (rinfo->no_schedule) {
        /*      if (try_acquire_console_sem())*/
                        return 0;
        } else
                acquire_console_sem();

        return 0;
=2E..

Chris
NB: kernel 2.6.18.1, amd64




--nextPart4245875.DufH7IB6Kf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARVplT9onrF4PGGDNAQKTLQ//T+7b7qnk4GuWrXHjcCpfP2yjvKYE3TY4
Or81CJnxjOX1LdAKBTosxPVK8d6D/CaiIDtBdivYw2tZ3a76rXWXOkY2hgxQ1jen
Agiop6UE+IdywfuwvGYxMc+6mX9Q3TbZJE1Yv1/uZujHVUhSWJVFGCh9GONO17nN
CTWW6RMZEAGEPS5EnCIPAg0V/BshSTOx8fPk0S4664KUMUv5JB65EU5dIluQOsqi
rCpO8gg+gnUf4X7UJj2XDu/GWNypgNIxzmBWDN8cNYSnptM5hDgspz4P87gZLk3E
GwCgkYBa5yZIfqvP6zQPyn4UnpCPCtj9DAw4esrU0aJ8ocwqYTYbTzge/1Hbi+aP
r6gDPxpB1T9BTk5nICne0CBS1T9b7tHZTQvRGhSoQaCYKsGEJNRf+UG6ARTAhMdz
rwmEDnhFPzGs/YVoCnoxtqxgPItoI2XdYjJD4vIusoxxXoY9IyPa5pW32+YtMWwr
a5+GhQzi640scg6jJKGc5kGxld8w57DhkfnDU/GEYqLgOnquOBCeVGabN9oOeHMQ
56af2rW9YdK+bjUjGN+n9Kl/ynFmKzMiwgaE8HfjNOJhm9QiYk+KFPVySX8pk6Hr
WnWwfxreIQmuiGwzLXD7oxu2v2G2zJmJW54qM1cf8Bqm+pLf9kO5AkSto4p1cORo
cj/jUx57XtE=
=6JOM
-----END PGP SIGNATURE-----

--nextPart4245875.DufH7IB6Kf--
