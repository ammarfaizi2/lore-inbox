Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129703AbQLAXGv>; Fri, 1 Dec 2000 18:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129790AbQLAXGl>; Fri, 1 Dec 2000 18:06:41 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:19972 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129703AbQLAXGY>; Fri, 1 Dec 2000 18:06:24 -0500
Date: Fri, 1 Dec 2000 16:35:25 -0600
To: "T. Camp" <campt@openmars.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
Message-ID: <20001201163525.A25464@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0012010843470.4856-100000@magic.skylab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012010843470.4856-100000@magic.skylab.org>; from campt@openmars.com on Fri, Dec 01, 2000 at 08:49:43AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tracy Camp]
> A much cleaner patch prompted after right proper chastisement on the
> sloppy patch I sent a few days back.  This one is against 2.4-pre11

Hmmm, I don't like your array thing (also in v.I of the patch),
limiting us to <n> possible root devices, where n==8.  A better
approach might be to iterate over the root= arguments when mounting.  I
know why you used the array -- easier to code.

One potential problem with the patch is that you have changed behavior
some people are relying on.  If you use 'syslinux' to boot, for
example, the SYSLINUX.CFG file can define a default command line
including root=.  Then you can augment that line at runtime by typing
in your own command line.  Your patch makes it impossible, in this
situation, to override the default root device from the syslinux
command line.  A kludge to make it work again would be to process the
root devices in reverse.  That would be ugly and unintuitive, though.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
