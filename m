Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUFAPik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUFAPik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUFAPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 11:38:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28334 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262106AbUFAPiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 11:38:15 -0400
Date: Tue, 1 Jun 2004 17:38:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Resume enhancement: restore pci config space
Message-ID: <20040601153800.GA22986@devserv.devel.redhat.com>
References: <20040526203524.GF2057@devserv.devel.redhat.com> <20040530184031.GF997@openzaurus.ucw.cz> <20040531133834.GA5834@devserv.devel.redhat.com> <s5hllj7qt7g.wl@alsa2.suse.de> <1086102397.7500.2.camel@laptop.fenrus.com> <s5hbrk3qoxw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <s5hbrk3qoxw.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 01, 2004 at 05:26:51PM +0200, Takashi Iwai wrote:
> At Tue, 01 Jun 2004 17:06:38 +0200,
> Arjan van de Ven wrote:
> > 
> > [1  <text/plain (quoted-printable)>]
> > 
> > > int xxx_resume(struct pci_dev *dev)
> > > {
> > > 	int err;
> > > 	if ((err = pci_default_resume(dev)) < 0)
> > > 		return err;
> > > 	// ... do h/w specific
> > > }
> > 
> > well define "h/w specific", just give me an example of a real (alsa?)
> > driver that would use it (or point me to one) so that I can see if this
> > is the best API, what the return value should be etc etc 
> 
> I'm afraid the ALSA drivers aren't be the best examples :)
> It doesn't handle the error in suspend/resume at all.

hm it looks like all this would gain is that instead of 2 or 3 function calls
you need to do one which then calls those 3. The *driver* already knows if
it needs busmaster or not etc, so when I wrote this code I felt that the
driver could do a better job really. But well if you think it's worth it to
save those 3 lines into 1 ?


> Hmm, looking at them right now, and i found most of them don't have
> pci_suspend_state() because it worked without saving/restoring the pci
> state _casually_, and missing pci_set_power_state(), etc...

I made the PCI layer save PCI config space always, and the generic resume callback
conditional, so saving PCI config state is not something that explicitly
needs to be done in the suspend hook. I don't know what else a suspend
standard function needs to do.


Gretings,
   Arjan van de Ven

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAvKLXxULwo51rQBIRAvRAAJ9Jz7Yw1lq1mQDihDPJm9C7LUv4lwCfVel8
Y61MuHGAqyaV8QTr/Qzm9+I=
=rzJ5
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
