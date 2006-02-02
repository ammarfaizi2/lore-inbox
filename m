Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWBBLYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWBBLYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBBLYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:24:16 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:14735 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750737AbWBBLYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:24:15 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Date: Thu, 2 Feb 2006 21:20:46 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022029.32524.nigel@suspend2.net> <20060202103947.GB1884@elf.ucw.cz>
In-Reply-To: <20060202103947.GB1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5487206.Kxvxjo4h7k";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022120.50485.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5487206.Kxvxjo4h7k
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 20:39, Pavel Machek wrote:
> Hi!
>
> > > > I'm more concerned about the security implications. I'll freely adm=
it
> > > > that I haven't spent any real time looking at your code, but I'm
> > > > concerned that the additional functionality made available could be
> > > > used by viruses and the like. I'm sure you'd have to be root to do
> > > > anything, but how could the interfaces be misused?
> > >
> > > In vanilla kernel userland suspend has no security implications: root
> > > can just do what he wants in /dev/mem, anyway.
> >
> > Ok.
> >
> > > In fedora kernel, userland suspend can be [miss]used to snapshot an
> > > image, modify it, and write it back. Fortunately, this is going to
> > > take *long* time so people will notice. [Interface changed on DaveJ's
> > > request, now we have separate device, we no longer mess with
> > > /dev/mem]. And similar problem exists in suspend2 -- malicious
> > > graphical progress bar could probably modify memory image on disk.
> >
> > How? It's just an ordinary process with no special permissions or access
> > to memory. The communication between the userspace process and the kern=
el
> > is in the form of a netlink socket, with the only messages sent back and
> > forth being what should be displayed or what actions the user requested.
> > Everything related to preparing the image and performing the I/O is done
> > in the kernel. There's no way I can see that a malicious userspace
> > program could modify anything but its own memory.
>
> Fedora people have some "interesting" ideas about security. They want
> to prevent userland to modify kernel memory, root or not. AFAICS
> progress bar helper could access kernel memory  while it is on disk,
> then wait for resume to pick up the modifications.

Hi again.

Maybe I'm just being thick, but I don't see what you mean by "progress bar=
=20
helper could access kernel memory while it is on disk". I suppose it could=
=20
potentially be given some means of writing directly to the disk that bypass=
ed=20
filesystem code (remember that filesystems are frozen), but even if it coul=
d=20
overwrite a page of the image, most Suspend2 users compress the image, and=
=20
the corruption would be detected at resume time because the data wouldn't=20
decompress properly. The hypothetical malicious program wouldn't be able to=
=20
assume that blocks are page aligned, or that a particular compression metho=
d=20
was used. Encryption might also be used, and that could be using any of the=
=20
cryptoapi modules in any valid configuration.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart5487206.Kxvxjo4h7k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4esSN0y+n1M3mo0RAtTTAJ4gRgrEsviXevinZhExfO0u/y1l3ACgoOmT
hfpirL8uNbtKI13+vZwV9b8=
=P6mq
-----END PGP SIGNATURE-----

--nextPart5487206.Kxvxjo4h7k--
