Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264643AbUEaNoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264643AbUEaNoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUEaNlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:41:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:968 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264550AbUEaNip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:38:45 -0400
Date: Mon, 31 May 2004 15:38:34 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Resume enhancement: restore pci config space
Message-ID: <20040531133834.GA5834@devserv.devel.redhat.com>
References: <20040526203524.GF2057@devserv.devel.redhat.com> <20040530184031.GF997@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20040530184031.GF997@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 30, 2004 at 08:40:31PM +0200, Pavel Machek wrote:
> Hi!
> 
> > One can rightfully argue that the driver resume method should do this, and
> > yes that is right. So the patch only does it for devices that don't have a
> > resume method. Like the main PCI bridge on my testbox of which the bios so
> > nicely forgets to restore the bus master bit during resume.. With this patch
> > my testbox resumes just fine while it, well, wasn't all too happy as you can
> > imagine without a busmaster pci bridge.
> ...
> > +/* 
> > + * Default resume method for devices that have no driver provided resume,
> > + * or not even a driver at all.
> > + */
> > +static void pci_default_resume(struct pci_dev *pci_dev)
> > +{
> 
> Perhaps this should not be static so that drivers don't
> need to duplicate this?

I wonder if that is useful, can you see cases where it would be?
I mean, all it does is provide a default handler for places that don't have
one. All this is info drivers already have, if a driver chooses to implement
it's resume handler I think they can do better than this (and thus don't
need this helper). But... if you can come up with a reasonable use I don't
oppose it. I do like to see a sane user first though before adding this to
the driver API...

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAuzVZxULwo51rQBIRAnDcAJ9qD8srfdo1yEMGEi3Xp4mtI3gfHACeLfKV
6mxjI1pqhmFZ2xOa0GzjcRg=
=764q
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
