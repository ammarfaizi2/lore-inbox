Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbTBQNvU>; Mon, 17 Feb 2003 08:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTBQNvR>; Mon, 17 Feb 2003 08:51:17 -0500
Received: from [24.206.178.254] ([24.206.178.254]:24451 "EHLO
	mail.brianandsara.net") by vger.kernel.org with ESMTP
	id <S267097AbTBQNtl>; Mon, 17 Feb 2003 08:49:41 -0500
From: Brian Jackson <brian@mdrx.com>
To: camber@yakko.cs.wmich.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.5 AGP for 2.4.21-pre4
Date: Mon, 17 Feb 2003 07:58:39 -0600
User-Agent: KMail/1.5
References: <JJEJKAPBMJAOOFPKFDFKAEDOCEAA.camber@yakko.cs.wmich.edu>
In-Reply-To: <JJEJKAPBMJAOOFPKFDFKAEDOCEAA.camber@yakko.cs.wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302170758.39205.brian@mdrx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snipped DaveJ from cc: he is a busy man these days>

On Monday 17 February 2003 06:43 am, Edward Killips wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> You patch deleted the definitions for the Via chipsets.

you mean for other parts of the chipset? Not for the agp bridge, right? Can 
you tell me which ones you added back in? I can add them to v2 which I am 
working on now to add module ability back.

> After I added them
> back the agpgart driver appeared to load correctly. When I try to start X I
> get a black screen and have to shutdown and reboot to get video back.

Are you using DRI? I wasn't able to test with DRI, so that may not work 
correctly. I guess I should have said something about that :) Would it be 
possible for you to send some dmesg output. Maybe keep X from starting, get 
the output, and send it to me. Does 2.5 work in 8X mode for you?

> This
> is with an AIW 9700 Pro and a Gigabyte GA-7VAXP KT400 based motherboard .

Good I was hoping somebody with 8X hardware would try it out. BTW have you 
ever seen any other AIW cards before, I was curious if the new one looked any 
better or worse.

--Brian Jackson

>
> - -- Edward Killips
>
> - -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Brian Jackson
> Sent: Saturday, February 15, 2003 10:35 PM
> To: linux-kernel@vger.kernel.org; davej@codemonkey.org.uk;
> brian@brianandsara.net
> Subject: 2.5 AGP for 2.4.21-pre4
>
>
> This is a poor attempt at a backport of the 2.5.61 AGP subsystem by someone
> who doesn't know what he is doing and is in way over his head. That said,
> are
> there any "brave" souls out there that want to try this out with an AGP3
> card
> and 2.4.21pre4. I compile/boot tested it with an old ati card, but I don't
> have an AGP 3.0 card/MB to test it on. I got into X and ran glxgears using
> this kernel(I am using it to finish writing this email)
>
> http://www.mdrx.com/brian/2.4.21-pre4-2.5agp.diff.gz
>
> caveats:
> agp has to be built in to the kernel (no modules)
>
> I did the following:
> copied the drivers/char/agp directory from 2.5.61
> copied include/asm-*/agp.h from 2.5.61
> copied include/linux/*agp.h from 2.5.61
> made some changes to drivers/char/agp/Makefile
> on line 619&635 of frontend.c changed remap_page_range to only have 4
> 	arguments
> line 705 generic.c changed SetPageLocked -->SetPageReserved
> 	(not sure if this is right, but Locked doesn't exist in 2.4 and I thought
> 	Reserved might work -- Let me know if this should be something else)
> backend.c:241 & backend.c:263 commented references to 2.5 module stuff
> 	(therefore this only safe to be built into the kernel for now, any ideas
> what
> 	I should use here instead?)
> added some device id's to drivers/char/agp/agp.h from
> 	2.5.61/include/linux/pci_ids.h
> uninclude gfp.h & linux/page-flags.h from amd-k7-agp.c
>
> What else I need to do:
> change to old style module init stuff
>
> This is nowhere near suitable for production use, but I would like some
> people
> that actually have AGP3 cards/MB's to try this out
>
> - --Brian Jackson
>
> P.S. All criticism is welcome even flaming since I am in a decent mood
> right now
>
> P.S.S. To Dave Jones -- I thought 2.5 had support for VIA chipsets & AGP3,
> but
> I only saw config options for the 7205/7505
>
> - -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -----BEGIN PGP SIGNATURE-----
> Version: PGP 8.0
>
> iQA/AwUBPlDY2Xg7wzlNS3haEQLFswCfU0OJLlObv53E0kII4VpQJfQeDNEAoLSz
> 0h6O30p+lfi7kjuj28Mv6vpN
> =kwgx
> -----END PGP SIGNATURE-----
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

