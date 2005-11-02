Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbVKBRm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbVKBRm1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVKBRm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:42:27 -0500
Received: from mivlgu.ru ([81.18.140.87]:53383 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1751348AbVKBRm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:42:27 -0500
Date: Wed, 2 Nov 2005 20:42:12 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Ilya <khext@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PAE bug in 2.4?!
Message-Id: <20051102204212.256584e7.vsu@altlinux.ru>
In-Reply-To: <1130946595.4434.20.camel@localhost.localdomain>
References: <1130946595.4434.20.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__2_Nov_2005_20_42_12_+0300_rUkl3xrs92NBhMtq"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__2_Nov_2005_20_42_12_+0300_rUkl3xrs92NBhMtq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 02 Nov 2005 18:49:55 +0300 Ilya wrote:

> I've ASUS P4P800-Mx-EAYVZ motherboard and have to use a 2GB memory. But
> after including PAE support in kernel it almost twice... Surely, i
> understand, that it's inevitable, the slowing of PAE, but twice?! Does
> anybody faced this problem? Or is there some bug in PAE?! I tested the
> PAE at some other motherboards, but only on this model on asus it works
> strange) 
[skip]
> Here is the difference in kernels:
> khext@al:~$ diff linux-2.4.31/.config linux-2.4.31-PAE/.config
> 61,62c61,62
> < CONFIG_NOHIGHMEM=y
> < # CONFIG_HIGHMEM4G is not set
> ---
> > # CONFIG_NOHIGHMEM is not set
> > CONFIG_HIGHMEM4G=y
> 64c64,65
> < # CONFIG_HIGHMEM is not set
> ---
> > CONFIG_HIGHMEM=y
> > CONFIG_HIGHIO=y

CONFIG_HIGHMEM4G does not enable PAE - it is CONFIG_HIGHMEM64G which
does it.  So the slowdown must be due to something other than PAE.

Please also show the start of dmesg output - lines which look like:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 ...
xxxMB HIGHMEM available.
xxxMB LOWMEM available.

Also show the output of "cat /proc/mtrr".  Some systems have buggy MTRR
setup done by BIOS, which can lead to such slowness when using the full
amount of memory.  Such problems may be fixed by a BIOS upgrade, or
worked around by specifying the mem=... option to avoid using the memory
which is not covered by MTTRs (if the amount of such misconfigured
memory is not excessively large).

--Signature=_Wed__2_Nov_2005_20_42_12_+0300_rUkl3xrs92NBhMtq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDaPp3W82GfkQfsqIRAsjLAJ9MDdXRT8RLVQpBcSQ4NCRSW1zFFgCfd3vn
6MfENVt1PVdmztlnUYQGHzY=
=7QXo
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Nov_2005_20_42_12_+0300_rUkl3xrs92NBhMtq--
