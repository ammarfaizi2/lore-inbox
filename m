Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282109AbRKWKKs>; Fri, 23 Nov 2001 05:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282106AbRKWKKj>; Fri, 23 Nov 2001 05:10:39 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:14737 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S282109AbRKWKKa>; Fri, 23 Nov 2001 05:10:30 -0500
Date: Fri, 23 Nov 2001 11:10:25 +0100 (MET)
From: <Oliver.Neukum@lrz.uni-muenchen.de>
X-X-Sender: <ui222bq@sun3.lrz-muenchen.de>
To: Rick Lindsley <ricklind@us.ibm.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove needless BKL from release functions 
In-Reply-To: <200111230944.fAN9ib421870@eng4.beaverton.ibm.com>
Message-Id: <Pine.SOL.4.33.0111231106530.7403-100000@sun3.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Rick Lindsley wrote:

> Christoph Hellwig <hch@ns.caldera.de> said:
>
>     Nope, it's fine to remove it.  Input is racy all over the place and the list
>     are modified somewhere else without any locking anyways.
>
> Horst von Brand <vonbrand@inf.utfsm.cl> then said:
>
>     "It is broken anyway, breaking it some more makes no difference"!?
>
> No, it is more a matter of "it is not helping at all, so removing it
> makes no difference in behavior."  Removing it does, however, help
> clean up the code and remove unnecessary instances of the BKL from the
> kernel code.
>
> If you check the web page at
> http://lse.sourceforge.net/lockhier/patches.html, you'll find
> additional information on why this patch was produced.  The most common
> "no-op" was that (BKL) locking was done during release but not during
> open. In some cases, there truly are things to guard. In some cases,
> there really isn't. In all cases, nothing was really being correctly
> guarded.

While this is doubtlessly true, please don't do things like removing the
lock from interfaces like the call to open() in the input subsystem.
People may depend on the lock being held there. Having open() under BKL
simplifies writing USB device drivers.

	Regards
		Oliver


