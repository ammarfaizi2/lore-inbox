Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283645AbRLEBE0>; Tue, 4 Dec 2001 20:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283648AbRLEBER>; Tue, 4 Dec 2001 20:04:17 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14070 "EHLO
	phobos.mvista.com") by vger.kernel.org with ESMTP
	id <S283645AbRLEBEC>; Tue, 4 Dec 2001 20:04:02 -0500
Date: Tue, 4 Dec 2001 17:02:35 -0800
From: Jeremy Puhlman <jpuhlman@mvista.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
Message-ID: <20011204170235.M25671@mvista.com>
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de> <3C0D6CB6.7000905@zytor.com> <20011204164941.A29968@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204164941.A29968@one-eyed-alien.net>; from mdharm-kernel@one-eyed-alien.net on Tue, Dec 04, 2001 at 04:49:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 04:49:41PM -0800, Matthew Dharm wrote:
> There is another argument for supporting both endiannesses....
> 
> Consider an embedded system which can be run in either endianness.  Sounds
> silly?  MIPS processors can run big or little endian, and many people
> routinely switch between them.
Yes but typically this also includes a step of reflashing firmware or
swaping of firmware...So it would not be unrealistic to swap out the
filesystem as well...

Since in a deployment situation you will always be sticking with one endianness 
it makes sense that you would want the most speed for your buck...Since flash 
filesystems are slow to begin with also adding in the decompression
hit you get from cramfs...it would seem to me that adding in le<->be
would just add to its speed reduction....That would seem to be a good
place to trim the fat so to speak...

Just My humble oppinion
Jeremy

> 
> Matt
> 
> On Tue, Dec 04, 2001 at 04:39:18PM -0800, H. Peter Anvin wrote:
> > Ingo Oeser wrote:
> > 
> > > 
> > > Yes, from a CS point of view. 
> > > 
> > > But practically cramfs is created once to contain some kind of
> > > ROM for embedded devices. So if we never modify these data again,
> > > why not creating it in the required byte order? 
> > > 
> > > Why wasting kernel cycles for le<->be conversion? Just because
> > > it's more general? For writable general purpose file systems it
> > > makes sense, but to none of romfs, cramfs etc.
> > > 
> > 
> > 
> > Because otherwise you far too easily end up in a situation where every
> > system suddenly need to be able to support *BOTH* endianisms, at which
> > point you're really screwed; supporting dual endianism is significantly
> > more expensive than supporting the "wrong" endianism, and it affects all
> > systems.
> > 
> > Nip this one in the bud.
> > 
> > 	-hpa
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.net 
> Maintainer, Linux USB Mass Storage Driver
> 
> M:  No, Windows doesn't have any nag screens.
> C:  Then what are those blue and white screens I get every day?
> 					-- Mike and Cobb
> User Friendly, 1/4/1999


