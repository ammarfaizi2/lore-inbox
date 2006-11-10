Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946399AbWKJK44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946399AbWKJK44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946410AbWKJK44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:56:56 -0500
Received: from mivlgu.ru ([81.18.140.87]:52937 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1946388AbWKJK4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:56:55 -0500
Date: Fri, 10 Nov 2006 13:56:49 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unexplainable read errors, copy/diff-issue
Message-Id: <20061110135649.16cccca0.vsu@altlinux.ru>
In-Reply-To: <4553DD90.1090604@scientia.net>
References: <4553DD90.1090604@scientia.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.2; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__10_Nov_2006_13_56_49_+0300_jL_yIibQwNVtjb9e"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__10_Nov_2006_13_56_49_+0300_jL_yIibQwNVtjb9e
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2006 03:01:52 +0100 Christoph Anton Mitterer wrote:

> The original post may be found under:
> http://marc.theaimsgroup.com/?t=116291314500001&r=1&w=2
>
> First of all my software/hardware data:
> CPU: 2x DualCore Opteron 275
> Mainboard: Tyan Thunder K8WE (S2895)
> Chipsets: Nvidia nForce professional 2200, Nvidia nForce professional
> 2050, AMD 8131
> Memory: Kingston ValueRAM 4x 1GB Registered ECC
> Harddisks: 1x PATA IBM/Hitachi, 2x SATA IBM/Hitachi
> Additional Devices/Drives: Plextor PX760A DVD/CD, TerraTec Aureon 7.1
> Universe soundcard, Hauppage Nova 500T DualDVB-T card.
> Distribution: Debian sid
> Kernel: self-compiled 2.6.18.2 (see below for .config) with applied EDAC
> patches
>
> The system should be cooled enough so I don't think that this comes from
> overheating issues. Nothing is overclocked.
>
> Ok the problem is the following:
> I copy large amounts of data (>15GB in several files each about 80MB,
> but it happens even for smaller amounts so size does not seem to be
> related) from one location to another.
> Then I diff the two locations.
> There are differences found!!!
> When I do diff again I find again differences but mostly in other files
> (so not always in the same place).
> Sometimes there are not differences (but this is rare as I'm testing
> with > 15GB)

So you have 4GB RAM, and most likely some memory is remapped above the
4GB address boundary.  Could you show the full dmesg output after boot?

Other things you can try:

 - Boot with mem=3072M (or some larger value which is still less than
   the amount of RAM below the 4GB boundary - the exact value could be
   found from the dmesg output) and check whether you can reproduce the
   corruption in this configuration.

 - Look in the BIOS setup for memory remapping options (Google indicates
   that it may be called "Hammer Configuration/Memory Hole Mapping" on
   this board).  Maybe you need to try different values (AFAIR there
   were some complaints about unstabilities with software remapping;
   cannot find the exact page now).

--Signature=_Fri__10_Nov_2006_13_56_49_+0300_jL_yIibQwNVtjb9e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVFr0W82GfkQfsqIRAoCVAJ9YjZeS7y26NH7T891gC9nzhEcx1gCfT/TH
2UTH5f9OEo7CJ+RYkJFso18=
=vg3z
-----END PGP SIGNATURE-----

--Signature=_Fri__10_Nov_2006_13_56_49_+0300_jL_yIibQwNVtjb9e--
