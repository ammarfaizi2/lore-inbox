Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVEBMS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVEBMS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 08:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVEBMS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 08:18:56 -0400
Received: from mx2.mail.ru ([194.67.23.122]:33284 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261223AbVEBMSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 08:18:52 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [linux-usb-devel] init 1 kill khubd on 2.6.11
Date: Mon, 2 May 2005 16:18:43 +0400
User-Agent: KMail/1.8
Cc: stern@rowland.harvard.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200505012021.56649.arvidjaar@mail.ru> <200505021200.10313.arvidjaar@mail.ru> <20050502023047.4c965f3e.akpm@osdl.org>
In-Reply-To: <20050502023047.4c965f3e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1307709.8tIub9MkeP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505021618.44007.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1307709.8tIub9MkeP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 02 May 2005 13:30, Andrew Morton wrote:
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> >  > It's pretty simple to convert khubd to use the kthread API.  Somethi=
ng
> >  > like this (untested):
> >
> >  Something strange is going on with this patch.
> >
> >  insmod usbcore; insmod uhci-hcd works as expected, finds out all
> > devices, triggers hotplug etc. But
> >
> >  {pts/2}% sudo insmod ./usbcore.ko
> >  {pts/2}% sudo mount -t usbfs -o devmode=3D0664,devgid=3D43 none
> > /proc/bus/usb {pts/2}% sudo modprobe usb-interface
> >
> >  results in
> >
> > ...
> >  uhci_hcd 0000:00:1f.2: Unlink after no-IRQ?  Controller is probably
> > using the wrong IRQ.
> >  usb 1-1: khubd timed out on ep0out
>
> Does this only happen when the convert-khubd-to-kevent patch is applied?

(Do you mean patch posted in this thread?)

Now I must admit it does happen without patch too. Sometimes it goes throug=
h=20
but most of the time it results in those timeouts.

So I confirm that patch posted in this thread fixes original problem (khubd=
=20
killed by SIGKILL).

W.r.t. to timeouts - I appreciate hints where to start debugging. (I am=20
downloading vanilla kernel + -mm to give it a try).

regards

=2Dandrey

--nextPart1307709.8tIub9MkeP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCdhqjR6LMutpd94wRAunMAJ9v5BXM4gqa6IA5GGuqjpB5502jSwCeMDgx
QH4h4gG1TWwvUQBk+laXmaE=
=2206
-----END PGP SIGNATURE-----

--nextPart1307709.8tIub9MkeP--
