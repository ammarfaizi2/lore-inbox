Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129738AbQLASuA>; Fri, 1 Dec 2000 13:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbQLAStv>; Fri, 1 Dec 2000 13:49:51 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129437AbQLAStl>; Fri, 1 Dec 2000 13:49:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/random probs in 2.4test(12-pre3)
Date: 1 Dec 2000 10:18:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <908q2g$1pf$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10012011720050.23462-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.10.10012011720050.23462-100000@sphinx.mythic-beasts.com>
By author:    Matthew Kirkwood <matthew@hairy.beasts.org>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> It looks like the random driver in 2.4test will return a
> short read, rather than blocking.  This is breaking vpnd
> (http://sunsite.dk/vpnd/) which breaks with "failed to
> gather random data" or similar.
> 
> Here's a sample strace:
> 
> open("/dev/random", O_RDONLY)           = 3
> read(3, "q\321Nu\204\251^\234i\254\350\370\363\"\305\366R\2708V"..., 72) = 29
> close(3)                                = 0
> 
> Have the semantics of the device changed, or is vpnd doing
> something wrong?
> 

vpnd is doing something wrong: it's assuming short reads won't
happen.  /dev/random will block if there is NOTHING to be read;
however, if there are bytes to be read, it will return them even if it
is less than the user asked for.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
