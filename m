Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267041AbTBQMdK>; Mon, 17 Feb 2003 07:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBQMdJ>; Mon, 17 Feb 2003 07:33:09 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:24526 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id <S267041AbTBQMdI>;
	Mon, 17 Feb 2003 07:33:08 -0500
Reply-To: <camber@yakko.cs.wmich.edu>
From: "Edward Killips" <camber@yakko.cs.wmich.edu>
To: "Brian Jackson" <brian@mdrx.com>, <linux-kernel@vger.kernel.org>,
       <davej@codemonkey.org.uk>, <brian@brianandsara.net>
Subject: RE: 2.5 AGP for 2.4.21-pre4
Date: Mon, 17 Feb 2003 07:43:05 -0500
Message-ID: <JJEJKAPBMJAOOFPKFDFKAEDOCEAA.camber@yakko.cs.wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200302152135.22425.brian@mdrx.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

You patch deleted the definitions for the Via chipsets. After I added them
back the agpgart driver appeared to load correctly. When I try to start X I
get a black screen and have to shutdown and reboot to get video back. This
is with an AIW 9700 Pro and a Gigabyte GA-7VAXP KT400 based motherboard .

- -- Edward Killips

- -----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Brian Jackson
Sent: Saturday, February 15, 2003 10:35 PM
To: linux-kernel@vger.kernel.org; davej@codemonkey.org.uk;
brian@brianandsara.net
Subject: 2.5 AGP for 2.4.21-pre4


This is a poor attempt at a backport of the 2.5.61 AGP subsystem by someone
who doesn't know what he is doing and is in way over his head. That said,
are
there any "brave" souls out there that want to try this out with an AGP3
card
and 2.4.21pre4. I compile/boot tested it with an old ati card, but I don't
have an AGP 3.0 card/MB to test it on. I got into X and ran glxgears using
this kernel(I am using it to finish writing this email)

http://www.mdrx.com/brian/2.4.21-pre4-2.5agp.diff.gz

caveats:
agp has to be built in to the kernel (no modules)

I did the following:
copied the drivers/char/agp directory from 2.5.61
copied include/asm-*/agp.h from 2.5.61
copied include/linux/*agp.h from 2.5.61
made some changes to drivers/char/agp/Makefile
on line 619&635 of frontend.c changed remap_page_range to only have 4
	arguments
line 705 generic.c changed SetPageLocked -->SetPageReserved
	(not sure if this is right, but Locked doesn't exist in 2.4 and I thought
	Reserved might work -- Let me know if this should be something else)
backend.c:241 & backend.c:263 commented references to 2.5 module stuff
	(therefore this only safe to be built into the kernel for now, any ideas
what
	I should use here instead?)
added some device id's to drivers/char/agp/agp.h from
	2.5.61/include/linux/pci_ids.h
uninclude gfp.h & linux/page-flags.h from amd-k7-agp.c

What else I need to do:
change to old style module init stuff

This is nowhere near suitable for production use, but I would like some
people
that actually have AGP3 cards/MB's to try this out

- --Brian Jackson

P.S. All criticism is welcome even flaming since I am in a decent mood right
now

P.S.S. To Dave Jones -- I thought 2.5 had support for VIA chipsets & AGP3,
but
I only saw config options for the 7205/7505

- -
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: PGP 8.0

iQA/AwUBPlDY2Xg7wzlNS3haEQLFswCfU0OJLlObv53E0kII4VpQJfQeDNEAoLSz
0h6O30p+lfi7kjuj28Mv6vpN
=kwgx
-----END PGP SIGNATURE-----

