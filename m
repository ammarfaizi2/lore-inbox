Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbUKDPTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUKDPTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUKDPS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:18:26 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:34963 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262257AbUKDPQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:16:15 -0500
Message-ID: <418A47BB.5010305@g-house.de>
Date: Thu, 04 Nov 2004 16:16:11 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Oops in 2.6.10-rc1
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de>
In-Reply-To: <4180FDB3.8080305@g-house.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hm,

still no sound with snd_ens1371 but now i spend some time to find out how
to revert a patch with bk. while compiling is still ongoing, let me tell
you how i tried to revert the patch with bk, because i am not entirely
sure if i do the right thing here:

bk changes > ../changes-04-11-2004.txt

as written before, i suspect (!) two changes here:

> [...]
> <rddunlap@osdl.org>
>     [PATCH] i386/io_apic init section fixups
> 
> <wli@holomorphy.com>
>     [PATCH] vm: convert users of remap_page_range() under sound/ to
>     use remap_pfn_range()
> [...]
> 
> so i'll revert the patches and see what it gives.

in ../changes-04-11-2004.txt i found out the ChnageSet numbers:
1.1988.72.76 + 1.2000.5.77. then i did

bk undo -a1.1988.72.76

only to find out that i misread the manual and 1.1988.72.76 is still in
place. i did

bk changes > ../changes-1.1988.72.76.txt

and the very patch has a different ChangeSet now: 1.2202. so i did

bk undo -a1.2201

is this the right way to revert patches when subsequent patches might not
allow to simply "bk undo -r<vers>" (because subsequent patches rely on
this single ChangeSet).

thank you for your assistance,
Christian
- --
BOFH excuse #182:

endothermal recalibration
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBike6+A7rjkF8z0wRAl/DAKDAMP31cXrzjBnnl+713F1zJ5ShQQCdFYRr
TpRkMTwdhZq9SvoZEPR2Plw=
=sm2q
-----END PGP SIGNATURE-----
