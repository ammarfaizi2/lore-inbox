Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRIDUNp>; Tue, 4 Sep 2001 16:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbRIDUNf>; Tue, 4 Sep 2001 16:13:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:31164 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268900AbRIDUNX>; Tue, 4 Sep 2001 16:13:23 -0400
Date: Tue, 4 Sep 2001 14:13:34 -0600
Message-Id: <200109042013.f84KDYD08203@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Taral <taral@taral.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEVFS_FL_AUTO_DEVNUM on block devices
In-Reply-To: <20010904144605.A5496@taral.net>
In-Reply-To: <20010904144605.A5496@taral.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

taral@taral.net writes:
> 
> --HlL+5n6rz5pIUxbD
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable

Please fix your mailer to not send this junk.

> I'm trying to write a device driver that dynamically creates block
> devices (kind of like loop does). I'd like to use DEVFS_FL_AUTO_DEVNUM,
> but it looks like devfs doesn't initialize the block queues in any
> useful way. Does anyone have any code that I can use? If so, Cc: me on
> replies. Thanks!

Devfs isn't supposed to manage your block queues. That's not what it's
designed for. Devfs is just a way of managing your device nodes.

Block queue management can be done by the "generic" block I/O layer
(or you can write your own management code, but that's not
practical). This layer requires that you have a major number for your
driver, so that certain information can be shoved into some static
arrays (yes, it's butt-ugly, and it will change in 2.5).

You can use the devfs_alloc_major() function to grab a major number
that won't conflict with another driver. Then use that major when
calling devfs_register().

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
