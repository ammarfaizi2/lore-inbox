Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUHXGNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUHXGNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 02:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHXGNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 02:13:01 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:60897 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S266353AbUHXGKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 02:10:19 -0400
Date: Mon, 23 Aug 2004 23:08:24 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-ID: <20040823230824.3c937d88@laptop.delusion.de>
In-Reply-To: <4125AD23.4000705@yahoo.com.au>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<20040808113930.24ae0273.akpm@osdl.org>
	<200408100012.08945.gene.heskett@verizon.net>
	<200408102342.12792.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	<20040810211849.0d556af4@laptop.delusion.de>
	<Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	<20040812180033.62b389db@laptop.delusion.de>
	<Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	<20040820000238.55e22081@laptop.delusion.de>
	<20040820001154.0a5cf331.akpm@osdl.org>
	<20040820001905.27a9ff8f@laptop.delusion.de>
	<4125AD23.4000705@yahoo.com.au>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__23_Aug_2004_23_08_24_-0700_ufzWG4sTPr7oOwhC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__23_Aug_2004_23_08_24_-0700_ufzWG4sTPr7oOwhC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 20 Aug 2004 17:49:55 +1000 Nick Piggin (NP) wrote:

NP> Can you reproduce the OOM with the following patch please? Then
NP> send the output.

I reproduced the problem using a slightly different setup to trigger the
problem faster:  128 MB RAM, 188992 KB swap

Here's the output of the OOM killer with your patch applied:

oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7
HighMem per-cpu: empty

Free pages:        1316kB (0kB HighMem)
Active:5281 inactive:23611 dirty:0 writeback:0 unstable:0 free:329 slab:1403 mapped:12232 pagetables:167
DMA free:712kB min:44kB low:88kB high:132kB active:5076kB inactive:5332kB present:16384kB pages_scanned:10112 all_unreclaimable? yes
protections[]: 22 178 178
Normal free:604kB min:312kB low:624kB high:936kB active:16048kB inactive:89112kB present:114688kB pages_scanned:62432 all_unreclaimable? yes
protections[]: 0 156 156
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 0*4kB 3*8kB 13*16kB 1*32kB 1*64kB 1*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 712kB
Normal: 1*4kB 1*8kB 1*16kB 0*32kB 1*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 604kB
HighMem: empty
Swap cache: add 90886, delete 74524, find 4659/4974, race 0+0
Out of Memory: Killed process 1217 (gphoto2).

-Udo.

--Signature=_Mon__23_Aug_2004_23_08_24_-0700_ufzWG4sTPr7oOwhC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBKttbnhRzXSM7nSkRAq3iAJ4vAHlhRGpXrdqzzD0DOp/UqnPrIACfRV+x
os9EhVNwu+qiopaMJldtHJo=
=yhBv
-----END PGP SIGNATURE-----

--Signature=_Mon__23_Aug_2004_23_08_24_-0700_ufzWG4sTPr7oOwhC--
