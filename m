Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDSDBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDSDBi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 23:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWDSDBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 23:01:38 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61345 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750730AbWDSDBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 23:01:37 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
Date: Wed, 19 Apr 2006 12:59:53 +1000
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com> <200604191208.49386.ncunningham@cyclades.com> <1145415212.19994.15.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1145415212.19994.15.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart38183849.jCkosog981";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604191259.57951.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart38183849.jCkosog981
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 19 April 2006 12:53, Shaohua Li wrote:
> On Wed, 2006-04-19 at 12:08 +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 19 April 2006 11:51, Shaohua Li wrote:
> > > On Wed, 2006-04-19 at 11:41 +1000, Nigel Cunningham wrote:
> > > > Oh, and while we're on the topic, if only part of a page is NVS,
> > > > what's the right behaviour? My e820 table has:
> > > >
> > > > BIOS-e820: 000000003dff0000 - 000000003dffffc0 (ACPI data)
> > > > BIOS-e820: 000000003dffffc0 - 000000003e000000 (ACPI NVS)
> > >
> > > If only part of a page is NVS, my patch will save the whole page. Any
> > > other idea?
> >
> > A device model driver that handles saving just the part of the page,
> > using preallocated buffers to avoid the potential allocation problems?
> > (The whole page could then safely be Nosave).
>
> The allocation might not be a problem, this just needs one or two extra
> pages. A problem is if just part of the page is NVS, could we touch
> other part (save/restore) the page.

Yes, so I was thinking of treating it with a pseudo driver that could save =
and=20
restore just that portion of the page.

Regarding the allocation, I was originally thinking of that other ACPI=20
allocation while atomic issue, and trying to avoid another one. I guess thi=
s=20
is simpler though because we know ahead of time how much is needed (am I=20
right in thinking that in the other case, the amount of memory needed isn't=
=20
known ahead of time?).

Regards,

Nigel

--nextPart38183849.jCkosog981
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERaetN0y+n1M3mo0RAlnWAJ9wW9aivOTZCM2OOWELPCwxVi+G/QCdEMwa
AgiB3CaVBnMI0IfXVbf/jwo=
=yvDw
-----END PGP SIGNATURE-----

--nextPart38183849.jCkosog981--
