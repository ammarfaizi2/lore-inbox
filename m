Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDSGfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDSGfG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 02:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWDSGfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 02:35:06 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:5517 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750793AbWDSGfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 02:35:04 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
Date: Wed, 19 Apr 2006 16:33:20 +1000
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com> <200604191259.57951.ncunningham@cyclades.com> <1145417334.19994.24.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1145417334.19994.24.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3582793.tEGnbnD81J";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604191633.24433.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3582793.tEGnbnD81J
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 19 April 2006 13:28, Shaohua Li wrote:
> On Wed, 2006-04-19 at 12:59 +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 19 April 2006 12:53, Shaohua Li wrote:
> > > On Wed, 2006-04-19 at 12:08 +1000, Nigel Cunningham wrote:
> > > > Hi.
> > > >
> > > > On Wednesday 19 April 2006 11:51, Shaohua Li wrote:
> > > > > On Wed, 2006-04-19 at 11:41 +1000, Nigel Cunningham wrote:
> > > > > > Oh, and while we're on the topic, if only part of a page is NVS,
> > > > > > what's the right behaviour? My e820 table has:
> > > > > >
> > > > > > BIOS-e820: 000000003dff0000 - 000000003dffffc0 (ACPI data)
> > > > > > BIOS-e820: 000000003dffffc0 - 000000003e000000 (ACPI NVS)
> > > > >
> > > > > If only part of a page is NVS, my patch will save the whole page.
> > > > > Any other idea?
> > > >
> > > > A device model driver that handles saving just the part of the page,
> > > > using preallocated buffers to avoid the potential allocation
> > > > problems? (The whole page could then safely be Nosave).
> > >
> > > The allocation might not be a problem, this just needs one or two ext=
ra
> > > pages. A problem is if just part of the page is NVS, could we touch
> > > other part (save/restore) the page.
> >
> > Yes, so I was thinking of treating it with a pseudo driver that could
> > save and restore just that portion of the page.
>
> Sounds like a good idea. If NVS is already aligned to page size, do you
> still use the pseudo driver to save/restore the pages? In my system, the
> NVS memory is 512k.
> In the other way, we could let the 'swsusp_add_arch_pages' accept
> address instead of a pfn and let snapshot.c handle the partial page
> issue.

I guess the cleanest solution would be to use the same routine in either ca=
se.=20
If that was a pseudo driver, it would mean double the memory usage (the pag=
es=20
allocated would also be atomically copied), so perhaps using=20
swsusp_add_arch_pages is the way to go.

I wonder too whether Mel Gorman e820 table patches could be leveraged to ma=
ke=20
finding the NVS data really nice and simple?

Regards,

Nigel

--nextPart3582793.tEGnbnD81J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERdm0N0y+n1M3mo0RAp6hAJ9CjvGAjG4nvOmljHAbX1l6wwD0ngCfX87k
JTCBoyA0uziYQgowpKxkDKU=
=+55Y
-----END PGP SIGNATURE-----

--nextPart3582793.tEGnbnD81J--
