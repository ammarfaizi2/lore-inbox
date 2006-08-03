Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWHCGWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWHCGWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWHCGWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:22:39 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:64673 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932295AbWHCGWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:22:38 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH] Move valid_dma_direction() from x86_64 to generic code
Date: Thu, 3 Aug 2006 08:25:19 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org
References: <200607280928.54306.eike-kernel@sf-tec.de> <200608021720.40815.eike-kernel@sf-tec.de> <20060802185527.GB4982@rhun.ibm.com>
In-Reply-To: <20060802185527.GB4982@rhun.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2030929.fPakumaD0l";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608030825.19651.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2030929.fPakumaD0l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Muli Ben-Yehuda wrote:
> On Wed, Aug 02, 2006 at 05:20:40PM +0200, Rolf Eike Beer wrote:
> > As suggested by Muli Ben-Yehuda this function is moved to generic code =
as
> > may be useful for all archs.
>
> I like it, but ...

> Several files include asm/dma-mapping.h directly, which will now cause
> them to fail to compile on x86-64 due to the missing definition for
> valid_dma_direction, unless by chance another header already brought
> it in indirectly. I guess the right thing to do is convert them all to
> using linux/dma-mapping.h instead.

Yes, akpm already fixed it up. Sorry guys, currently no x86 kernel around=20
here. Need to fix that.

> ./arch/x86_64/kernel/pci-swiotlb.c:6:#include <asm/dma-mapping.h>
> ./drivers/net/fec_8xx/fec_main.c:40:#include <asm/dma-mapping.h>
> ./drivers/net/fs_enet/fs_enet.h:11:#include <asm/dma-mapping.h>
> ./include/asm-x86_64/swiotlb.h:5:#include <asm/dma-mapping.h>

I suspect it to be a bug anyway that every of this files ever included=20
asm/dma-mapping.h.

> ./include/linux/dma-mapping.h:27:#include <asm/dma-mapping.h>

This is perfectly valid, isn't it :)

Eike

--nextPart2030929.fPakumaD0l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE0ZbPXKSJPmm5/E4RAgBmAKCe902VmyAQ98TogYy+FNJLYhlelgCfWGII
uZjrxLM07fCXpVIiqSk7tmo=
=01x3
-----END PGP SIGNATURE-----

--nextPart2030929.fPakumaD0l--
