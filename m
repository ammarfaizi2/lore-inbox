Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129248AbQK0SbI>; Mon, 27 Nov 2000 13:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130352AbQK0Sam>; Mon, 27 Nov 2000 13:30:42 -0500
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:44552 "EHLO
        munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
        id <S129401AbQK0SaV>; Mon, 27 Nov 2000 13:30:21 -0500
Date: Mon, 27 Nov 2000 13:01:36 -0500
From: Michael Meissner <meissner@spectacle-pond.org>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001127130136.A17104@munchkin.spectacle-pond.org>
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001127094139.H599@almesberger.net>; from Werner.Almesberger@epfl.ch on Mon, Nov 27, 2000 at 09:41:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 09:41:39AM +0100, Werner Almesberger wrote:
> Adam J. Richter wrote:
> > 	At the moment, I have started daydreaming about instead
> > writing an "elf squeezer" to do this and other space optimizations
> > by modifying objdump.
> 
> Hmm, this would require that gcc never calculates the location of an
> explicitly initialized static variable based on the address of another
> one. E.g. in
> 
> static int a = 0, b = 0, c = 0, d = 0;
> 
> ...
>     ... a+b+c+d ...
> ...
> 
> egcs-2.91.66 indeed doesn't seem to make this optimization on i386.
> (Maybe the pointer increment or pointer offset solution would
> actually be slower - didn't check.) But I'm not sure if this is also
> true for other versions/architectures, or other code constructs.

Jeff Law played with a similar optimization about 1-2 years ago, and eventually
deleted all of the code because there were problems with the code.  It would
help some of our platforms (but not the x86) to access all variables in the
same section via a common pointer.  This is because on those systems, it often
times takes 2-3 instructions to access global/static variables.  Global
variables you have more problems visiblity and such.

-- 
Michael Meissner, Red Hat, Inc.
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
