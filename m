Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268589AbUILKLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268589AbUILKLf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUILKLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:11:35 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:13552 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S268589AbUILKLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:11:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Subject: Re: [PATCH] Yielding processor resources during lock contention
Date: Sun, 12 Sep 2004 12:10:32 +0200
User-Agent: KMail/1.6.2
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
MIME-Version: 1.0
Message-Id: <200409121210.32259.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_YCCRBpvt/IsLG5P";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_YCCRBpvt/IsLG5P
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 12. September 2004 06:59, Zwane Mwaikambo wrote:
> The following patch introduces cpu_lock_yield which allows architectures=
=20
> to possibly yield processor resources during lock contention. The origina=
l=20
> requirement stems from Paul's requirement on PPC64 LPAR systems to yield=
=20
> the processor to the hypervisor instead of spinning.=20

=46or s390, this was solved by simply defining cpu_relax() to the hypervisor
yield operation, because we found that cpu_relax() is used only in busy-wait
situations where it makes sense to continue on another virtual CPU.

What is the benefit of not always doing a full hypervisor yield when
you hit cpu_relax()?

	Arnd <><

--Boundary-02=_YCCRBpvt/IsLG5P
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBRCCY5t5GS2LDRf4RAmrLAKCVu/b5omHQlZ6lqkZfXagdySzIAwCglWEP
guEo1FqkpG1bfMVizqjQtOQ=
=dxuj
-----END PGP SIGNATURE-----

--Boundary-02=_YCCRBpvt/IsLG5P--
