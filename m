Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129969AbQLBMcv>; Sat, 2 Dec 2000 07:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129953AbQLBMcm>; Sat, 2 Dec 2000 07:32:42 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:19982 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S129882AbQLBMcd>; Sat, 2 Dec 2000 07:32:33 -0500
Date: Sat, 2 Dec 2000 12:01:41 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/random probs in 2.4test(12-pre3)
In-Reply-To: <908q2g$1pf$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012021201090.31306-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Dec 2000, H. Peter Anvin wrote:

> > open("/dev/random", O_RDONLY)           = 3
> > read(3, "q\321Nu\204\251^\234i\254\350\370\363\"\305\366R\2708V"..., 72) = 29
> > close(3)                                = 0
> >
> > Have the semantics of the device changed, or is vpnd doing
> > something wrong?
>
> vpnd is doing something wrong: it's assuming short reads won't happen.
> /dev/random will block if there is NOTHING to be read; however, if
> there are bytes to be read, it will return them even if it is less
> than the user asked for.

Ah, many thanks for the clarification.  I'll fix vpnd then.

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
