Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265062AbUFMNHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUFMNHI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 09:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFMNHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 09:07:08 -0400
Received: from nmts-mur.murom.net ([213.177.124.6]:15016 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S265056AbUFMNGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 09:06:45 -0400
Date: Sun, 13 Jun 2004 17:06:30 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: timer + fpu stuff locks up computer
Message-ID: <20040613130630.GB2236@sirius.home>
References: <26h3z-t3-15@gated-at.bofh.it> <26hGq-Zr-29@gated-at.bofh.it> <26isF-1Im-11@gated-at.bofh.it> <26lJU-4lC-23@gated-at.bofh.it> <m3isdwo2et.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <m3isdwo2et.fsf@averell.firstfloor.org>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 13, 2004 at 12:08:10AM +0200, Andi Kleen wrote:
> One problem on 486s/P5s would be the race that is described in D.2.1.3
> of Volume 1 of the Intel architecture manual when the FPU is in MSDOS
> compatibility. When that happens we can still get the exception later
> (e.g. on a following fwait which the kernel can still execute). The
> only way to handle that would be to check in the exception handler,
> like my patch did.

But in head.S we set the NE flag in CR0 for all 486 or better
processors, so the MSDOS compatibility mode is not used, and we don't
need to care about this race.

> However my patch was also not complete, since it
> didn't handle it for all fwaits in the kernel.

Looked at your patch...  I was also thinking about something similar.

You treat exception 16 and IRQ13 the same - is this really correct?
Asynchronous IRQ13 might break things.  But this would be visible only
on a real 80386+80387 - does someone still have such hardware? ;)

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzFFWW82GfkQfsqIRApU6AJ9vcEelNI31jSePaPbuYQiBMhEwbQCfY2IH
ceh3O6amLtQxb8qMK9+GrNE=
=VyFe
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
