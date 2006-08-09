Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030652AbWHILGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030652AbWHILGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWHILGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:06:55 -0400
Received: from nigel.suspend2.net ([203.171.70.205]:65473 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030652AbWHILGy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:06:54 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 20:47:12 +1000
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>
References: <200608091152.49094.rjw@sisk.pl>
In-Reply-To: <200608091152.49094.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1396333.oGUYJeNH2X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608092047.13493.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1396333.oGUYJeNH2X
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 09 August 2006 19:52, Rafael J. Wysocki wrote:
> Hi,
>
> Currently swsusp handles highmem in a simplistic way, by trying to store a
> copy of each saveable highmem page in the "normal" memory before creating
> the suspend image.  These copies are then copied once again before saving,
> because they are treated as any other non-highmem pages with data.  For
> this reason, to save one highmem page swsusp needs two free pages in the
> "normal" memory, so on a system with high memory it is practically
> impossible to create a suspend image above 400 kilobytes.  Moreover, if
> there's much more highmem than the "normal" memory in the system, it may =
be
> impossible to suspend at all due to the lack of space for saving
> non-freeable highmem pages.
>
> This limitation may be overcome in a satisfactory way if swsusp does its
> best to store the copies of saveable highmem pages in the highmem itself.=
=20
> However, for this purpose swsusp has to be taught to use pfns, or (struct
> page *) pointers, instead of kernel virtual addresses to identify memory
> pages. Yet, if this is to be implemented, we can also attack the minor
> problem that the current swsusp's internal data structure, the list of pa=
ge
> backup entries (aka PBEs), is not very efficient as far as the memory usa=
ge
> is concerned.
>
> This issue can be addressed by replacing the list of PBEs with a pair of
> memory bitmaps.  Still, to remove the list of PBEs completely, we would
> have to make some complicated modifications to the architecture-dependent
> parts of the code which would be quite undesirable.  However, we can use
> the observation that memory is only a limiting resource during the suspend
> phase of the suspend-resume cycle, because during the resume phase
> many image pages may be loaded directly to their "original" page frames, =
so
> we don't need to keep a copy of each of them in the memory.  Thus the list
> of PBEs may be used safely in the last part of the resume phase without
> limitting the amount of memory we can use.
>
> The following series of patches introduces the memory bitmap data
> structure, makes swsusp use it to store its internal information and
> implements the improved handling of saveable highmem pages.
>
> Comments welcome.

Thanks for the reminder. I'd forgotten half the reason why I didn't want to=
=20
make Suspend2 into incremental patches! You're a brave man!

Nigel
=2D-=20
while (1) {
  size=3D$RANDOM * 65536 + 1
  dd if=3D/dev/random bs=3D1 count=3D$size | patch -p0-b
  make && break
}

--nextPart1396333.oGUYJeNH2X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBE2b0xN0y+n1M3mo0RArPsAKDKwcs53R7yWpALi4wx7Qt6tp59BACdHgBM
pFSeLwnIp0r6z9KbQQ3+7KU=
=I1Yq
-----END PGP SIGNATURE-----

--nextPart1396333.oGUYJeNH2X--
