Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLBAGC>; Fri, 1 Dec 2000 19:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLBAFw>; Fri, 1 Dec 2000 19:05:52 -0500
Received: from 216-99-201-166.hurrah.com ([216.99.201.166]:2313 "EHLO
	magic.skylab.org") by vger.kernel.org with ESMTP id <S129183AbQLBAFk>;
	Fri, 1 Dec 2000 19:05:40 -0500
Date: Fri, 1 Dec 2000 15:35:05 -0800 (PST)
From: "T. Camp" <campt@openmars.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
In-Reply-To: <20001201163525.A25464@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012011529070.4856-100000@magic.skylab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, I don't like your array thing (also in v.I of the patch),
> limiting us to <n> possible root devices, where n==8.  A better
> approach might be to iterate over the root= arguments when mounting.  I
> know why you used the array -- easier to code.
I was unsure if it was okay to be using kmalloc during early stages of
init/main.c so I decided to follow the example allready set and just use a
static array - can anyone advise on being able to do this dynamically?

> One potential problem with the patch is that you have changed behavior
> some people are relying on.  If you use 'syslinux' to boot, for
> example, the SYSLINUX.CFG file can define a default command line
> including root=.  Then you can augment that line at runtime by typing
> in your own command line.  Your patch makes it impossible, in this
> situation, to override the default root device from the syslinux
> command line.  A kludge to make it work again would be to process the
> root devices in reverse.  That would be ugly and unintuitive, though.
Yeah you would need to patch lilo as well to handle the new syntax amongst
other things.  I use grub and have no troubles along these lines.
Refrencing the idea in the follow on message about just using the last
root= only and not allowing multiple root= would work around this.  I
guess I can't think of any really good reason why having multiple root= is
a necissary feature.

t.

Fear the future?  Change the past. 
 This message has resulted in an increase in the entropy of the universe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
