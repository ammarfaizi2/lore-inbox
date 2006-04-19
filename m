Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDSBnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDSBnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 21:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDSBnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 21:43:31 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:39365 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750706AbWDSBnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 21:43:31 -0400
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
Date: Wed, 19 Apr 2006 11:41:46 +1000
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com> <200604190838.29247.ncunningham@cyclades.com> <1145409721.19994.5.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1145409721.19994.5.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1481279.zVo6WbAH9k";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604191141.51492.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1481279.zVo6WbAH9k
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 19 April 2006 11:22, Shaohua Li wrote:
> On Wed, 2006-04-19 at 08:38 +1000, Nigel Cunningham wrote:
> > Hi.
> >
> > On Wednesday 12 April 2006 12:38, Shaohua Li wrote:
> > > @@ -1400,6 +1401,111 @@ static void set_mca_bus(int x)
> > >  static void set_mca_bus(int x) { }
> > >  #endif
> > >
> > > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > > +static void __init mark_nosave_page_range(unsigned long start,
> > > unsigned long end) +{
> > > +	struct page *page;
> > > +	while (start <=3D end) {
> >
> > Should this be start < end? (End is usually the first byte of the next
> > zone IIUC).
>
> Thanks for looking at it. Yes you are right. Before calling this
> routine, I already decrement 1 for 'end', so the routine will have the
> last page pfn.

Ah. I see. In the call itself. Sneaky :)

Would you consider modifying that bit so it doesn't confuse others in the=20
future?

Oh, and while we're on the topic, if only part of a page is NVS, what's the=
=20
right behaviour? My e820 table has:

BIOS-e820: 000000003dff0000 - 000000003dffffc0 (ACPI data)
BIOS-e820: 000000003dffffc0 - 000000003e000000 (ACPI NVS)

Regards,

Nigel

--nextPart1481279.zVo6WbAH9k
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERZVfN0y+n1M3mo0RAhxnAJ90Ywubt7GyAmoIu4gvIPZovoKYHACeJG2w
V/Kw1Fgsrwwrz9R/BxxhDPk=
=CXXs
-----END PGP SIGNATURE-----

--nextPart1481279.zVo6WbAH9k--
