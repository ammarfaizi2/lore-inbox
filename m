Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWECR5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWECR5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 13:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWECR5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 13:57:04 -0400
Received: from master.altlinux.org ([62.118.250.235]:13317 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1751054AbWECR5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 13:57:01 -0400
Date: Wed, 3 May 2006 21:56:35 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Markus M_ller <mm@priv.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfsck dies
Message-Id: <20060503215635.4b3a28bf.vsu@altlinux.ru>
In-Reply-To: <4458C48B.8040703@priv.de>
References: <4458C48B.8040703@priv.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__3_May_2006_21_56_35_+0400_/MTkC720Xd4a+mMS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__3_May_2006_21_56_35_+0400_/MTkC720Xd4a+mMS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 03 May 2006 16:56:11 +0200 Markus M_ller wrote:

> reiserfsck told me that I have to run --rebuild-tree to fix all errors.=20
> But this don't work (see below), I tried two times (every time I am=20
> waiting 28 hours).

Apparently you have a huge filesystem (374936503 blocks - about 1.5 TB,
if these are 4KB blocks).  reiserfsck --rebuild-tree works by reading
every data block on the filesystem, finding blocks which look like
reiserfs tree nodes and rebuilding the tree from that nodes - so it
would take a long time, even if the volume was almost empty.

> If I mount the filesystem, there are no files in it.=20
> What can I do?

[skip]
> Pass 1 (will try to insert 423131 leaves):
> ####### Pass 1 #######
> Looking for allocable blocks .. Killed
[skip]
> Out of memory: Killed process 5622 (reiserfsck).

reiserfsck may need lots of memory (especially with such a huge FS) ...

> stacker:/# cat /proc/meminfo
> MemTotal:       512716 kB
> MemFree:        413660 kB
> Buffers:         20268 kB
> Cached:          47324 kB
> SwapCached:          0 kB
> Active:          19500 kB
> Inactive:        56656 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       512716 kB
> LowFree:        413660 kB
> SwapTotal:           0 kB
> SwapFree:            0 kB

... and you have only 512 MB with no swap.  Try to add some swap space -
then reiserfsck might eventually complete.

AFAIK, the only way to recover reiserfs after --rebuild-tree has been
attempted is to run "reiserfsck --rebuild-tree" to completion.

--Signature=_Wed__3_May_2006_21_56_35_+0400_/MTkC720Xd4a+mMS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFEWO7VW82GfkQfsqIRArd4AJ9Wb3EogjsTYt+sMmX6IXkwvuJrygCfUEUK
lpMWtBPLx4WECgeCvAQqlEI=
=+RuA
-----END PGP SIGNATURE-----

--Signature=_Wed__3_May_2006_21_56_35_+0400_/MTkC720Xd4a+mMS--
